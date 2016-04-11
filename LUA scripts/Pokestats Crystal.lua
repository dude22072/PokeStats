--Joseph Keller's Pokemon Crystal PokeStats Display LUA script
--Requires display 4.0.0 or higher.

----------------------------------------------------------------------------------------------

--The key to toggle if the debug display is shown
displayKey = "U" 
--Moves the debug screen to the next pokemon
nextPokemonKey = "T" 
-- Moves the debug screen to the previous pokemon
previousPokemonKey="R" 
--Weather the debug screen should be show at startup or not
local debugscreenbool = false 

----------------------------------------------------------------------------------------------

--TCP stuff
local host, port = "127.0.0.1", 54545
local socket = require("socket")
local tcp = assert(socket.tcp())
tcp:connect(host, port)
tcp:settimeout(0)
print(tcp:getpeername())
    
--Pokestats Include File
function B(a)
  return memory.readbyteunsigned(a)
end

function W(a)
  return memory.readwordunsigned(a)
end

function D(a)
  return memory.readdwordunsigned(a)
end

local function isempty(s)
  return s == nil or s == ''
end

--Locals
local team_count = 0xDCD7
local team = {}
team[1] = {}
team[2] = {}
team[3] = {}
team[4] = {}
team[5] = {}
team[6] = {}
team[7] = {} --In-Battle Pokemon
team[1].start = 0xDCDF
team[2].start=team[1].start+48
team[3].start=team[1].start+96
team[4].start=team[1].start+144
team[5].start=team[1].start+192
team[6].start=team[1].start+240
team[1].startNick=0xDE41
team[2].startNick=team[1].startNick+0x0B
team[3].startNick=team[1].startNick+0x16
team[4].startNick=team[1].startNick+0x21
team[5].startNick=team[1].startNick+0x2C
team[6].startNick=team[1].startNick+0x37
team[7].startNick=0xC621
local debugsubmode = 0

for i=1,7 do team[i].nickname = {} end
for i=1,6 do team[i].experience = {}; team[i].iv = {} end

local pokemonSpeciesNames={
 "None",
 "Bulbasaur","Ivysaur","Venusaur",
 "Charmander","Charmeleon","Charizard",
 "Squirtle","Wartortle","Blastoise",
 "Caterpie","Metapod","Butterfree",
 "Weedle","Kakuna","Beedrill",
 "Pidgey","Pidgeotto","Pidgeot",
 "Rattata","Raticate",
 "Spearow","Fearow",
 "Ekans","Arbok",
 "Pikachu","Raichu",
 "Sandshrew","Sandslash",
 "Nidoran♀","Nidorina","Nidoqueen",
 "Nidoran♂","Nidorino","Nidoking",
 "Clefairy","Clefable",
 "Vulpix","Ninetales",
 "Jigglypuff","Wigglytuff",
 "Zubat","Golbat",
 "Oddish","Gloom","Vileplume",
 "Paras","Parasect",
 "Venonat","Venomoth",
 "Diglet","Dugtrio",
 "Meowth","Persian",
 "Psyduck","Golduck",
 "Mankey","Primape",
 "Growlithe","Arcanine",
 "Poliwag","Poliwhirl","Poliwrath",
 "Abra","Kadabra","Alakazam",
 "Machop","Machoke","Machamp",
 "Bellsprout","Weepinbell","Victreebel",
 "Tentacol","Tentacruel",
 "Geodude","Graveler","Golem",
 "Ponyta","Rapidash",
 "Slowpoke","Slowbro",
 "Magnemite","Magneton",
 "Farfetch'd",
 "Doduo","Dodrio",
 "Seel","Dewgong",
 "Grimer","Muk",
 "Shelder","Cloyster",
 "Ghastly","Haunter","Gengar",
 "Onix",
 "Drowzee","Hypno",
 "Krabby","Kingler",
 "Voltorb","Electrode",
 "Exeggcute","Exeggutor",
 "Cubone","Marowak",
 "Hitmonlee","Hitmonchan",
 "Lickitung",
 "Koffing","Weezing",
 "Rhyhorn","Rhydon",
 "Chansey",
 "Tangela",
 "Kangaskhan",
 "Horsea","Seadra",
 "Goldeen","Seaking",
 "Staryu","Starmie",
 "Mr. Mime",
 "Scyther",
 "Jynx",
 "Electabuzz",
 "Magmar",
 "Pinsir",
 "Tauros",
 "Magikrap","Gyarados",
 "Lapras",
 "Ditto",
 "Eevee","Vaporeon","Jolteon","Flareon",
 "Porygon",
 "Omanyte","Omastar",
 "Kabuto","Kabutops",
 "Aerodactyl",
 "Snorlax",
 "Articuno",
 "Zapdos",
 "Moltress",
 "Dratini","Dragonair","Dragonite",
 "Mewtwo",
 "Mew",
 "Chikorita","Bayleef","Meganium",
 "Cyndaquil","Quilava","Typhlosion",
 "Totodile","Croconaw","Feraligatr",
 "Sentret","Furret",
 "Hoothoot","Noctowl",
 "Ledyba","Ledian",
 "Spinarak","Ariados",
 "Crobat",
 "Chinchou","Lanturn",
 "Pichu",
 "Cleffa",
 "Igglybuff",
 "Togepi","Togetic",
 "Natu","Xatu",
 "Mareep","Flaaffy","Ampharos",
 "Bellossom",
 "Marill","Azumarill",
 "Sudowoodo",
 "Politoed",
 "Hoppip","Skiploom","Jumpluff",
 "Aipom",
 "Sunkern","Sunflora",
 "Yanma",
 "Wooper","Quagsire",
 "Espeon","Umbreon",
 "Murkrow",
 "Slowking",
 "Misdreavus",
 "Unown",
 "Wobbuffet",
 "Girafarig",
 "Pineco","Forretress",
 "Dunsparce",
 "Gligar",
 "Sttelix",
 "Snubbull","Granbull",
 "Qwilfish",
 "Scizor",
 "Shuckle",
 "Heracross",
 "Sneasel",
 "Teddiursa","Ursaring",
 "Slugma","Marcargo",
 "Swinub","Piloswine",
 "Corsla",
 "Remoraid","Octillery",
 "Delibird",
 "Mantine",
 "Skarmory",
 "Houndor","Houndoom",
 "Kingdra",
 "Phanpy","Donphan",
 "Porygon2",
 "Stantler",
 "Smeargle",
 "Tyrouge","Hitmontop",
 "Smoochum",
 "Elekid",
 "Magby",
 "Miltank",
 "Blissey",
 "Raikou",
 "Entei",
 "Suicune",
 "Larvitar","Pupitar","Tyranitar",
 "Lugia",
 "Ho-Oh",
 "Celebi",
 "?????", "Glitch Egg", "?????", "?????"}
local charMap={
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","POKé","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","PKMN","","","","","",
 "","","","","POKé","","","","","","","PC","TM","TRAINER","ROCKET","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","",""," ",
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
 "Q","R","S","T","U","V","W","X","Y","Z","(",")",":",";","[","]",
 "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p",
 "q","r","s","t","u","v","w","x","y","z","","","","","","",
 "Ä","Ö","Ü","ä","ö","ü","","","","","","","","","","",
 "'d","'l","'m","'r","'s","'t","'v","","","","","","","","","←",
 "'","Pk","Mn","-","","","?","!",".","&","é","→","▷","▶","▼","♂",
 "","×",".","/",",","♀","0","1","2","3","4","5","6","7","8","9"}
--All Empty ""'s Are REQUIRED
    
local timer = 0;
local timer_threshold = 180;

local xfix = 10
local yfix = 10
function displaybox(a,b,c,d,e,f)
	gui.box(a+xfix,b+yfix,c+xfix,d+yfix,e,f)
end

function display(a,b,c,d)
	gui.text(xfix+a,yfix+b,c, d)
end

function debugScreen()
    i = debugsubmode + 1
    
    -- Display data
	displaybox(-5,-5,148,133,"#000000A0", "white")
    display(0,0,"dude22072's PokeStats Script (DEBUG)","white")
	display(0,8, "Crystal", "white")
    display(0,15,"Slot:","White")
    display(80,15,i,"White")
    if i > B(team_count) then
    
    else
	if pokemonID == -1 then
		display(55,30, "Invalid Pokemon Data", "red")
	else
		--[[if isegg == 1 then
			display(0,25, "Pokemon: " .. pokemonSpeciesNames[team[i].species + 1] .. " egg", "yellow")
		else]]
			display(0,25, "Pokemon: " .. pokemonSpeciesNames[team[i].species + 1], "yellow")
		--end
        display(0,35,"Nickname: ", "yellow")
        for j=1,10 do
            display(50 + (j*5),35,(charMap[team[i].nickname[j]+1]), "yellow")
		end
        
		display(0,55, "Item: ", "white")
        display(80,55,team[i].item,"white")
		display(0,65, "Level: ", "green")
        display(80,65, team[i].level, "green")
        display(0,75, "HP: ", "green")
        
        if tonumber(team[i].currentHP) > 0 then
            if team[i].totalHP >= 100 then
                if team[i].currentHP >= 100 then
                    display(44,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                else 
                    if team[i].currentHP >= 10 then
                        display(50,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                    else
                        display(56,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                    end
                end
            else 
                if team[i].totalHP >= 10 then
                    if team[i].currentHP >= 10 then
                        display(56,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                    else
                        display(62,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                    end
                else
                    display(68,75, team[i].currentHP.."/"..team[i].totalHP, "green")
                end
            end
        else
            if team[i].totalHP >= 100 then
                display(56,65, team[i].currentHP.."/"..team[i].totalHP, "red")
            else
                if team[i].totalHP >= 10 then
                    display(62,75, team[i].currentHP.."/"..team[i].totalHP, "red")
                else
                    display(68,75, team[i].currentHP.."/"..team[i].totalHP, "red")
                end
            end
        end
        
        display(0,85, "EXP:", "blue")
        display(25,85,team[i].experience[4],"blue")
        
		--[[if pkrs == 0 then
			display(0,95, "PKRS:       no", "red")
		else
			display(0,95, "PKRS: yes (" .. team[i].pokerus .. ")", "red")
		end]]
        display(0,95, "PKRS:Unimplemented", "red")
        display(0,45, "Gender:", "green")
        --[[if team[i].gender == 0 then
            display(60,45, "Genderless", "green")
        elseif team[i].gender == 1 then
            display(60,45, "Male", "blue")
        elseif team[i].gender == 2 then
            display(60,45, "Female", "red")
        end]]
        display(60,45, "Unimplemented", "red")
	end
    end
    
    --Controls
    display(0,105,previousPokemonKey.."/"..nextPokemonKey..": Change Pokemon","orange")
    display(0,115,displayKey..": Show/Hide Display","orange")
    
end

function menu()
    local submodemax = 5
	tabl = input.get()
    if tabl[displayKey] and not prev[displayKey] then
        if debugscreenbool == true then
            debugscreenbool = false
        else
            debugscreenbool = true
        end
    end
	if tabl[previousPokemonKey] and not prev[previousPokemonKey] then
		debugsubmode = debugsubmode - 1
		if debugsubmode < 0 then
			debugsubmode = submodemax
		end
	end
	if tabl[nextPokemonKey] and not prev[nextPokemonKey] then
		debugsubmode = debugsubmode + 1
		if debugsubmode == submodemax + 1 then
			debugsubmode = 0
		end
	end
    
    if tabl[textOutputKey] and not prev[textOutputKey] then
		if textoutputbool == true then
            textoutputbool = false
        else
            textoutputbool = true
        end
	end
	prev = tabl
end

function do_pokestats()
    timer = timer + 1
	if timer >= timer_threshold then
        timer = 0
        --print("Timer elapsed!")
        
        if B(team_count) > 6 then return end
		if isempty(pokemonSpeciesNames) then
			pokemonSpeciesNames = "Loading..."
		end
		
		for i=1,6 do
            --Nickname
            stringTerminated = false 
            for j=1,10 do 
                if stringTerminated then 
                    team[i].nickname[j]=0x7F
                else 
                    team[i].nickname[j]=B(team[i].startNick-1+j)

                    if team[i].nickname[j] == 0x50 then 
                        stringTerminated = true 
                    end 
                end 
            end
            
                --Species & Item
                team[i].species=B(team[i].start)
                team[i].item=B(team[i].start+0x01)
            
                --Experience
                team[i].experience[1]=B(team[i].start+0x08)
                team[i].experience[2]=B(team[i].start+0x09)
                team[i].experience[3]=B(team[i].start+0x0A)
                if team[i].experience[1] < 0 then
                    team[i].experience[1] = (team[i].experience[1]+256)%256
                end 
                if team[i].experience[2] < 0 then
                    team[i].experience[2] = (team[i].experience[2]+256)%256
                end 
                if team[i].experience[3] < 0 then
                    team[i].experience[3] = (team[i].experience[3]+256)%256
                end 
                team[i].experience[4]=((((math.abs(team[i].experience[1])*65536))+(math.abs(team[i].experience[2])*256))+(math.abs(team[i].experience[3])))
            
                --level/hp/status
                team[i].status = B(team[i].start+0x20)
                team[i].level=B(team[i].start+0x1F)
                team[i].pokerus=B(team[i].start+0x1C)
                --Hp reader
                team[i].curHPB1=B(team[i].start+0x22)
                team[i].curHPB2=B(team[i].start+0x23)
                team[i].currentHP=(team[i].curHPB1*255)+team[i].curHPB2
                team[i].maxHPB1=B(team[i].start+0x24)
                team[i].maxHPB2=B(team[i].start+0x25)
                team[i].totalHP=(team[i].maxHPB1*255)+team[i].maxHPB2
                
                --Pokestats 3 Stuff
                team[i].gender=0
                
                team[i].iv.read1 = B(team[i].start+0x15)
                team[i].iv.read2 = B(team[i].start+0x16)
                team[i].iv.defense = bit.band(team[i].iv.read1, 0x0F)
                team[i].iv.attack = bit.rshift(bit.band(team[i].iv.read1,0xF0), 4) 
                team[i].iv.speed = bit.band(team[i].iv.read2, 0x0F)
                team[i].iv.special = bit.rshift(bit.band(team[i].iv.read2,0xF0), 4) 
                if team[i].iv.special == 10 and team[i].iv.speed == 10 and team[i].iv.defense == 10 then
                    if team[i].iv.attack == 2 or team[i].iv.attack == 3 or team[i].iv.attack == 6 or team[i].iv.attack == 7 or team[i].iv.attack == 10 or team[i].iv.attack == 11 or team[i].iv.attack == 14 or team[i].iv.attack == 15 then
                        team[i].isShiny = 1
                    else
                        team[i].isShiny = 0
                    end
                else
                    team[i].isShiny = 0
                end
		end
        
        
        stringTerminated = false 
            for j=1,10 do 
                if stringTerminated then 
                    team[7].nickname[j]=0x7F
                else 
                    team[7].nickname[j]=B(team[7].startNick-1+j)
                    if team[7].nickname[j] == 0x50 then 
                        stringTerminated = true 
                    end 
                end 
            end
            
            local stringToSend = "POKESTATS:"
       
		--File Output
			for i=1, 6 do
                if i <= B(team_count) then
                    if team[i].species >= 0 and team[i].species <= 411 then
                        stringToSend = stringToSend..(pokemonSpeciesNames[team[i].species+1]..":")
                    end
                    for j=1,10 do
                        stringToSend = stringToSend..(charMap[team[i].nickname[j]+1])
                    end
                    stringToSend = stringToSend..(":"..
                        team[i].currentHP..":"..
                        team[i].totalHP..":"..
                        team[i].level..":"..
                        team[i].status..":"..
                        team[i].pokerus..":"..
                        team[i].item..":"..
                            team[i].experience[4]..":")
                else
                    stringToSend = stringToSend..(pokemonSpeciesNames[1]..":")
                    stringToSend = stringToSend..("None")
                    stringToSend = stringToSend..(":"..
                        "0" ..":"..
                        "0" ..":"..
                        "0" ..":"..
                        "0" ..":"..
                        "0"..":"..
                        "0"..":"..
                            "0"..":")
                end
			end
            
            --file:write("POKESTATS 3.0.0 STUFF\n")
            
            if charMap[team[7].nickname[1]+1] == "" then
                stringToSend = stringToSend..("NOBATTLE")
            else
                for k=1,10 do
                    stringToSend = stringToSend..(charMap[team[7].nickname[k]+1])
                end
            end
            for i=1,6 do
                stringToSend = stringToSend..(":"..team[i].gender)
            end
            for i=1,6 do
                stringToSend = stringToSend..(":"..team[i].isShiny)
            end
            
            stringToSend = stringToSend.."\n"
            tcp:send(stringToSend)
        
    end
    
    if debugscreenbool == true then
        if team[1].species ~= nil then
            debugScreen()
        end
    end
        
    menu()
end

gui.register(do_pokestats)

