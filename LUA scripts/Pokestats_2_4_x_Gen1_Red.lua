--
-- Pokémon Status Display LUA Script
-- for VBA-RR
-- To be used at http://www.twitch.tv/rngplayspokemon
-- Created by dude22072
--

-- http://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_in_Generation_I

local textoutputpath = "pokestats.txt" --Path + text file name, or just text file name to output to current directory

local pokemonSpeciesNames={
 "None",
 "Rhydon",
 "Kangaskhan",
 "Nidoran",
 "Clefairy",
 "Spearow",
 "Voltorb",
 "Nidoking",
 "Slowbro",
 "Ivysaur",
 "Exeggutor",
 "Lickitung",
 "Exeggcute",
 "Grimer",
 "Gengar",
 "NidoranF", "Nidoqueen",
 "Cubone",
 "Rhyhorn",
 "Lapras",
 "Arcanine",
 "Mew",
 "Gyarados",
 "Shellder",
 "Tentacool",
 "Gastly",
 "Scyther",
 "Staryu",
 "Blastoise",
 "Pinsir",
 "Tangela",
 "MissingNo.", "MissingNo.",
 "Growlithe",
 "Onix",
 "Fearow",
 "Pidgey",
 "Slowpoke",
 "Kadabra",
 "Graveler",
 "Chansey",
 "Machoke",
 "Mr. Mime",
 "Hitmonlee",
 "Hitmonchan",
 "Arbok",
 "Parasect",
 "Psyduck",
 "Drowzee",
 "Golem",
 "MissingNo.",
 "Magmar",
 "MissingNo.",
 "Electabuzz",
 "Magneton",
 "Koffing",
 "MissingNo.",
 "Mankey",
 "Seal",
 "Diglet",
 "Tauros",
 "MissingNo.","MissingNo.","MissingNo.",
 "Farfetch'd",
 "Venonat",
 "Dragonite",
 "MissingNo.","MissingNo.","MissingNo.",
 "Doduo",
 "Poliwag",
 "Jynx",
 "Moltres",
 "Articuno",
 "Zapdos",
 "Ditto",
 "Meowth",
 "Krabby",
 "MissingNo.","MissingNo.","MissingNo.",
 "Vulpix","Ninetales",
 "Pikachu","Raichu",
 "MissingNo.","MissingNo.",
 "Dratini","Dragonair",
 "Kabuto","Kabutops",
 "Horsea","Seadra",
 "MissingNo.","MissingNo.",
 "Sandshrew","Sandslash",
 "Omanyte","Omastar",
 "Jigglypuff","Wigglytuff",
 "Eevee","Flareon","Jolteon","Vaporeon",
 "Machop",
 "Zubat",
 "Ekans",
 "Paras",
 "Poliwhirl","Poliwrath",
 "Weedle",
 "Kakuna","Beedrill",
 "MissingNo.",
 "Dodrio",
 "Primeape",
 "Dugtrio",
 "Venomoth",
 "Dewgong",
 "MissingNo.","MissingNo.",
 "Caterpie","Metapod",
 "Butterfree",
 "Machamp",
 "MissingNo.",
 "Golduck",
 "Hypno",
 "Golbat",
 "Mewtwo",
 "Snorlax",
 "Magikrap",
 "MissingNo.","MissingNo.",
 "Muk",
 "MissingNo.",
 "Kingler",
 "Cloyster",
 "MissingNo.",
 "Electrode",
 "Clefable",
 "Weezing",
 "Persian",
 "Marowak",
 "MissingNo.",
 "Haunter",
 "Abra","Alakazam",
 "Pidgeotto","Pidgeot",
 "Starmie",
 "Bulbasaur","Venusaur",
 "Tentacruel",
 "MissingNo.",
 "Goldeen","Seaking",
 "MissingNo.","MissingNo.","MissingNo.","MissingNo.",
 "Ponyta","Rapidash",
 "Rattata","Raticate",
 "Nidorino",
 "Nidorina",
 "Geodude",
 "Porygon",
 "Aerodactyl",
 "MissingNo.",
 "Magnemite",
 "MissingNo.","MissingNo.",
 "Charmander",
 "Squirtle",
 "Charmeleon",
 "Wartortle",
 "Charizard",
 "MissingNo.","MissingNo.","MissingNo.","MissingNo.",
 "Oddish","Gloom","Vileplume",
 "Bellsprout","Weepinbell","Victreebel"}
local charMap={
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","",""," ",
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
 "Q","R","S","T","U","V","W","X","Y","Z","(",")",":",";","[","]",
 "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p",
 "q","r","s","t","u","v","w","x","y","z","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","-","","","?","!",".","","","","","","","♂",
 "","×","","/",",","♀","0","1","2","3","4","5","6","7","8","9"}
--All Empty ""'s Are REQUIRED

--Locals
local team = {}
team[1] = {}
team[2] = {}
team[3] = {}
team[4] = {}
team[5] = {}
team[6] = {}
team[1].start = 0xD16B
team[2].start=team[1].start+44
team[3].start=team[1].start+88
team[4].start=team[1].start+132
team[5].start=team[1].start+176
team[6].start=team[1].start+220
team[1].startNick=0xD2B5
team[2].startNick=0xD2C0
team[3].startNick=0xD2CB
team[4].startNick=0xD2D6
team[5].startNick=0xD2E1
team[6].startNick=0xD2EC

for i=1,6 do team[i].nickname = {} end
for i=1,6 do team[i].experience = {} end

---File Output
local file=io.open(textoutputpath, "w")
local filecheck=io.read("*all")

local function isempty(s)
  return s == nil or s == ''
end

-- timer for status updates (#frames)
local timer = 0;
local timer_threshold = 180;

function do_pokestats()
	-- Status check
	timer = timer + 1
	if timer >= timer_threshold then
		timer = 0
		
		if isempty(pokemonSpeciesNames) then
			pokemonSpeciesNames = "Loading..."
		end
		
		for i=1,6 do
			--Species & Item
			team[i].species=memory.readbyteunsigned(team[i].start)
            team[i].item=0
				
			--Nickname
			stringTerminated = false
			for j=1,10 do
                if stringTerminated then
					team[i].nickname[j]=255
				else
                    team[i].nickname[j]=memory.readbyteunsigned(team[i].startNick-1+j)
                    if team[i].nickname[j] == 255 then
						stringTerminated = true
					end
                end
			end
            
            --Experience
            team[i].experience[1]=memory.readbyteunsigned(team[i].start+0x0E)
            team[i].experience[2]=memory.readbyteunsigned(team[i].start+0x0F)
            team[i].experience[3]=memory.readbyteunsigned(team[i].start+0x10)
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
			team[i].statusTemp=memory.readbyteunsigned(team[i].start+0x04)
            
            if team[i].statusTemp==0x04 then
                team[i].status=3
            end
            if team[i].statusTemp==0x08 then
                team[i].status=4
            end
            if team[i].statusTemp==0x10 then
                team[i].status=5
            end
            if team[i].statusTemp==0x20 then
                team[i].status=6
            end
            if team[i].statusTemp==0x40 then
                team[i].status=7
            end
            
            
			team[i].level=memory.readbyteunsigned(team[i].start+0x21)
            --Hp reader
			team[i].curHPB1=memory.readbyteunsigned(team[i].start+0x01)
            team[i].curHPB2=memory.readbyteunsigned(team[i].start+0x02)
            team[i].currentHP=(team[i].curHPB1*255)+team[i].curHPB2
            team[i].maxHPB1=memory.readbyteunsigned(team[i].start+0x22)
            team[i].maxHPB2=memory.readbyteunsigned(team[i].start+0x23)
            team[i].totalHP=(team[i].maxHPB1*255)+team[i].maxHPB2
		end
        
       
		--File Output
		if filecheck~=file then
			file:close()
			file=io.open(textoutputpath, "w+")
			file:close()
			file=io.open(textoutputpath, "w")
			
			for i=1,6 do
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
					"0".."\n"..
					team[i].item.."\n"..
                    team[i].experience[4].."\n")
			end
			file:flush()
		elseif filecheck==file then
			file:flush()
		end
	end
end
