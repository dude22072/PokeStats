require("Pokestats_Config")
--
-- Pokémon Status Display LUA Script
-- for VBA-RR
-- Originally made to be used at http://www.twitch.tv/rngplayspokemon
-- Created by dude22072
-- http://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_structure_in_Generation_III
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
 "Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch","Glitch",
 "Treecko","Grovyle","Sceptile",
 "Torchic","Combusken","Blaziken",
 "Mudkip","Marshtomp","Swampert",
 "Poochyena","Mightyena",
 "Zigzagoon","Linoone",
 "Wurmple","Silcoon","Beautifly","Cascoon","Dustox",
 "Lotad","Lombre","Ludicolo",
 "Seedot","Nuzleaf","Shiftry",
 "Nincada","Ninjask","Shedinja",
 "Taillow","Swellow",
 "Shroomish","Breloom",
 "Spinda",
 "Wingull","Pelipper",
 "Surskit","Masquerian",
 "Wailmer","Wailord",
 "Skitty","Delcatty",
 "Keckleon",
 "Baltoy","Claydol",
 "Nosepass",
 "Torkoal",
 "Sableye",
 "Barboach","Whiscash",
 "Luvdisc",
 "Corphish","Crawdaunt",
 "Feebas","Milotic",
 "Carvanha","Sharpedo",
 "Trapinch","Vibrava","Flygon",
 "Makuhita","Hariyama",
 "Electrike","Manectric",
 "Numel","Camerupt",
 "Spheal","Sealeo","Walrein",
 "Cacnea","Cacturne",
 "Snorunt","Glalie",
 "Lunatone","Solrock",
 "Azurill",
 "Spoink","Grumpig",
 "Plusle","Minum",
 "Mawile",
 "Meditite","Medicham",
 "Swablu","Altaria",
 "Wynaut",
 "Duskull","Dusclops",
 "Roseila",
 "Slakoth","Vigoroth","Slaking",
 "Gulpin","Swalot",
 "Tropius",
 "Whishmur","Loudred","Exploud",
 "Clamperl","Huntail","Gorebyss",
 "Absol",
 "Shuppet","Banette",
 "Seviper",
 "Zangoose",
 "Relicanth",
 "Aron","Lairon","Aggron",
 "Castform",
 "Volbeat","Illmise",
 "Lileep","Cradily",
 "Anorith","Armaldo",
 "Ralts","Kirlia","Gardevoir",
 "Bagon","Shelgon","Salamence",
 "Beldum","Metang","Metagross",
 "Regirock",
 "Regice",
 "Registeel",
 "Latias",
 "Latios",
 "Kyogre",
 "Groundon",
 "Rayquaza",
 "Jirachi",
 "Deoxys",
 "Chimecho"}
local charMap={
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","","","","","","","","","","","","","","","",
 "","0","1","2","3","4","5","6","7","8","9","!","?",".","-","",
 "…","“","”","‘","’","♂","♀","",".","","/","A","B","C","D","E",
 "F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U",
 "V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k",
 "l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","",
 "","","","","","","","","","","","","","","",""}
--All Empty ""'s Are REQUIRED

--Locals
local team = {}
team[1] = {}
team[2] = {}
team[3] = {}
team[4] = {}
team[5] = {}
team[6] = {}
team[1].start = 0x020244EC
team[2].start=team[1].start+100
team[3].start=team[1].start+200
team[4].start=team[1].start+300
team[5].start=team[1].start+400
team[6].start=team[1].start+500

for i=1,6 do team[i].nickname = {} end
for i=1,6 do team[i].experience = {} end

local growthData = 0
---File Output
local file=io.open(textoutputpath, "w")
local filecheck=io.read("*all")

local function isempty(s)
  return s == nil or s == ''
end

-- timer for status updates (#frames)
local timer = 0;

function do_pokestats()
	-- Status check
	timer = timer + 1
	if timer >= timer_threshold then
		timer = 0
		
		if isempty(pokemonSpeciesNames) then
			pokemonSpeciesNames = "Loading..."
		end
		
		for i=1,6 do
			--Personality, trainerID, magic
			team[i].personality=D(team[i].start)
			team[i].trainerID=D(team[i].start+4)
			team[i].magic=bit.bxor(team[i].personality, team[i].trainerID)
			
			--gender
			team[i].gendervalue=team[i].personality%256
            team[i].genderthreshold=B(((0x083203E8+28*i)+16))
            if team[i].genderthreshold == 255 then
                team[i].gender = 0
            elseif team[i].genderthreshold == 0 then
                team[i].gender = 1
            elseif team[i].genderthreshold == 254 then
                team[i].gender = 2
            else
                if team[i].gendervalue >= team[i].genderthreshold then
                    team[i].gender = 1
                else
                    team[i].gender = 2
                end
            end
			
			--I's
			team[i].i=team[i].personality%24
			
			--I to Growth/Misc
			if team[i].i<=5 then
				team[i].growthOffset=0
			elseif team[i].i%6<=1 then
				team[i].growthOffset=12
			elseif team[i].i%2==0 then
				team[i].growthOffset=24
			else
				team[i].growthOffset=36
			end

			if team[i].i>=18 then
				team[i].miscOffset=0
			elseif team[i].i%6>=4 then
				team[i].miscOffset=12
			elseif team[i].i%2==1 then
				team[i].miscOffset=24
			else
				team[i].miscOffset=36
			end
			
			--Species & Item
			growthData = bit.bxor(
				D(team[i].start+32+team[i].growthOffset),
				team[i].magic)
			team[i].species=bit.band(growthData, 0xFFF)
			team[i].item=bit.rshift(bit.band(growthData, 0xFFFF0000),16)
            team[i].experience=0 --Need help with bitshifting
				
			--Pokérus
			team[i].pokerus=bit.band(
				bit.bxor(D(team[i].start+32+team[i].miscOffset),
					team[i].magic),
				0xFF)
				
            --Nickname
			stringTerminated = false
			for j=1,10 do
				if stringTerminated then
					team[i].nickname[j]=255
				else
					team[i].nickname[j]=memory.readbyteunsigned(team[i].start+7+j)
					if team[i].nickname[j] == 255 then
						stringTerminated = true
					end
				end
			end
            
			--level/hp/status
			team[i].status=D(team[i].start+80)
			team[i].level=B(team[i].start+84)
			team[i].currentHP=W(team[i].start+86)
			team[i].totalHP=W(team[i].start+88)
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
				file:write(
					"\n"..team[i].currentHP..
					"\n"..team[i].totalHP..
					"\n"..team[i].level..
					"\n"..team[i].status..
					"\n"..team[i].pokerus..
					"\n"..team[i].item..
                    "\n"..team[i].experience.. --Experience
                    "\n")
			end
            
            file:write("POKESTATS 3.0.0 STUFF\n")
            
            --if charMap[team[7].nickname[1]+1] == "" then
                file:write("NOBATTLE")
            --else
            --    for k=1,10 do
            --        file:write(charMap[team[7].nickname[k]+1])
            --    end
            --end
            for i=1,6 do
                file:write("\n"..team[i].gender)
            end
            
			file:flush()
		elseif filecheck==file then
			file:flush()
		end
	end
end

--gui.register(do_pokestats)
