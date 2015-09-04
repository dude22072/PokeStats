require("Pokestats_Config")
--
-- Pokémon Status Display LUA Script
-- for VBA-RR
-- To be used at http://www.twitch.tv/rngplayspokemon
-- Created by dude22072
-- http://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_in_Generation_II
--

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
 "Odish","Gloom","Vileplume",
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
team[2].startNick=0xDE4C
team[3].startNick=0xDE57
team[4].startNick=0xDE62
team[5].startNick=0xDE6D
team[6].startNick=0xDD78
team[7].startNick=0xC621

for i=1,7 do team[i].nickname = {} end
for i=1,6 do team[i].experience = {} end

---File Output
local file=io.open(textoutputpath, "w")
local filecheck=io.read("*all")

local function isempty(s)
  return s == nil or s == ''
end

-- timer for status updates (#frames)
local timer = 0;

function do_pokestats()
    
    
    --shiny
       wildIV = {}
       wildIV.read1 = B(0xD20C)
       wildIV.read2 = B(0xD20D)
       wildIV.defense = bit.band(wildIV.read1, 0x0F)
       wildIV.attack = bit.rshift(bit.band(wildIV.read1,0xF0), 4) 
       wildIV.speed = bit.band(wildIV.read2, 0x0F)
       wildIV.special = bit.rshift(bit.band(wildIV.read2,0xF0), 4) 
       --print("ATK:"..wildIV.attack.." DEF:"..wildIV.defense.." SPD:"..wildIV.speed.." SPL:"..wildIV.special)
       if B(0xD22D) == 0x01 then
            if wildIV.special == 10 and wildIV.speed == 10 and wildIV.defense == 10 then
                if wildIV.attack == 2 or wildIV.attack == 3 or wildIV.attack == 6 or wildIV.attack == 7 or wildIV.attack == 10 or wildIV.attack == 11 or wildIV.attack == 14 or wildIV.attack == 15 then
                    gui.text(0,35,"shiny","yellow")
                end
            end
        end
  
	timer = timer + 1
	if timer >= timer_threshold then
		timer = 0
    -- if anything seems amiss, don't do an update:
	--if checkImpossibleValues then
	--	return
	--end
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
                
                team[i].gender=0
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
       
		--File Output
		if filecheck~=file then
			file:close()
			file=io.open(textoutputpath, "w+")
			file:close()
			file=io.open(textoutputpath, "w")
			
			for i=1, 6 do
                if i <= B(team_count) then
                    if team[i].species >= 0 and team[i].species <= 411 then
                        file:write(pokemonSpeciesNames[team[i].species+1].."\n")
                    end
                    for j=1,10 do
                        file:write(charMap[team[i].nickname[j]+1])
                    end
                    file:write("\n"..
                        team[i].currentHP.."\n"..
                        team[i].totalHP.."\n"..
                        team[i].level.."\n"..
                        team[i].status.."\n"..
                        team[i].pokerus.."\n"..
                        team[i].item.."\n"..
                            team[i].experience[4].."\n")
                else
                    file:write(pokemonSpeciesNames[1].."\n")
                    file:write("None")
                    file:write("\n"..
                        "0" .."\n"..
                        "0" .."\n"..
                        "0" .."\n"..
                        "0" .."\n"..
                        "0".."\n"..
                        "0".."\n"..
                            "0".."\n")
                end
			end
            
            file:write("POKESTATS 3.0.0 STUFF\n")
            
            if charMap[team[7].nickname[1]+1] == "" then
                file:write("NOBATTLE")
            else
                for k=1,10 do
                    file:write(charMap[team[7].nickname[k]+1])
                end
            end
            for i=1,6 do
                file:write("\n"..team[i].gender)
            end
            
			file:flush()
		elseif filecheck==file then
			file:flush()
		end
	end
end

function checkImpossibleValues()
	partyCount = B(team_count)
	partyByte1 = B(team[1].start)
	if partyCount > 6 
	or partyByte1 == 255
--	or b
--	or c
--	or d
	then
		return true
	end
end

--gui.register(do_pokestats)