--Joseph Keller's Pokemon Gen4/5 PokeStats Display LUA script
--Based of a lua script by MKDasher

local textoutputpath = "pokestats.txt"  --Path + text file name, or just text file name to output to current directory
local game = 1 -- 1 = Pearl, 2 = HeartGold, 3 = Platinum, 4 = Black, 5 = White, 6 = Black 2, 7 = White 2
local displayKey = "U" --The key to toggle if the debug display is shown
local displayScreenKey = "Y" --The key to change weather the debug screen is shown on the top or bottom screen
local nextPokemonKey = "T" --Moves the debug screen to the next pokemon
local previousPokemonKey="R" -- Moves the debug screen to the previous pokemon
local textOutputKey="E" --Toggles text file output
local debugscreenbool = 1 --Weather the debug screen should be show at startup or not (0=no, 1=yes)
local textoutputbool = 1 --Weather text output should be on at startup or not (0=no, 1=yes)

local gen
local pointer
local pidAddr
local pid = 0
local trainerID, secretID, lotteryID
local shiftvalue
local checksum = 0
local mode = 1
local submode = 1
local debugsubmode = 1
local submodemax = 6
local tabl = {}
local prev = {}
local prng

--BlockA
local pokemonID = 0
local heldItem = 0
local friendship_or_steps_to_hatch
local experience = 0
--BlockB
local ivspart = {}, ivs
local isegg
--BlockC
local nickname = {}
--BlockD
local pkrs
--Functions
local bnd,br,bxr=bit.band,bit.bor,bit.bxor
local rshift, lshift=bit.rshift, bit.lshift
local mdword=memory.readdwordunsigned
local mword=memory.readwordunsigned
local mbyte=memory.readbyteunsigned
--currentStats
local level, hpstat, maxhpstat
--offsets
local BlockAoff, BlockBoff, BlockCoff, BlockDoff

local file=io.open(textoutputpath, "w")
local filecheck=io.read("*all")

local function isempty(s)
  return s == nil or s == ''
end

BlockA = {1,1,1,1,1,1, 2,2,3,4,3,4, 2,2,3,4,3,4, 2,2,3,4,3,4}
BlockB = {2,2,3,4,3,4, 1,1,1,1,1,1, 3,4,2,2,4,3, 3,4,2,2,4,3}
BlockC = {3,4,2,2,4,3, 3,4,2,2,4,3, 1,1,1,1,1,1, 4,3,4,3,2,2}
BlockD = {4,3,4,3,2,2, 4,3,4,3,2,2, 4,3,4,3,2,2, 1,1,1,1,1,1}

pokemon =  {"None", "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
			"Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree",
			"Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
			"Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash",
			"NidoranF", "Nidorina", "Nidoqueen", "NidoranM", "Nidorino", "Nidoking",
			"Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
			"Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth",
			"Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape",
			"Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
			"Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel",
			"Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
			"Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
			"Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
			"Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak",
			"Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey",
			"Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie",
			"Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados",
			"Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
			"Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres",
			"Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",

			"Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion",
			"Totodile", "Croconaw", "Feraligatr", "Sentret", "Furret", "Hoothoot", "Noctowl",
			"Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn", "Pichu", "Cleffa",
			"Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
			"Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom",
			"Sunkern", "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking",
			"Misdreavus", "Unown", "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar",
			"Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel",
			"Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola", "Remoraid", "Octillery",
			"Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
			"Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank",
			"Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",
			
			"Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp", 
			"Swampert", "Poochyena", "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly",
			"Cascoon", "Dustox", "Lotad", "Lombre", "Ludicolo", "Seedot", "Nuzleaf", "Shiftry", 
			"Taillow", "Swellow", "Wingull", "Pelipper", "Ralts", "Kirlia", "Gardevoir", "Surskit", 
			"Masquerain", "Shroomish", "Breloom", "Slakoth", "Vigoroth", "Slaking", "Nincada", "Ninjask", 
			"Shedinja", "Whismur", "Loudred", "Exploud", "Makuhita", "Hariyama", "Azurill", "Nosepass", 
			"Skitty", "Delcatty", "Sableye", "Mawile", "Aron", "Lairon", "Aggron", "Meditite", "Medicham",
			"Electrike", "Manectric", "Plusle", "Minun", "Volbeat", "Illumise", "Roselia", "Gulpin", 
			"Swalot", "Carvanha", "Sharpedo", "Wailmer", "Wailord", "Numel", "Camerupt", "Torkoal", 
			"Spoink", "Grumpig", "Spinda", "Trapinch", "Vibrava", "Flygon", "Cacnea", "Cacturne", "Swablu",
			"Altaria", "Zangoose", "Seviper", "Lunatone", "Solrock", "Barboach", "Whiscash", "Corphish",
			"Crawdaunt", "Baltoy", "Claydol", "Lileep", "Cradily", "Anorith", "Armaldo", "Feebas", 
			"Milotic", "Castform", "Kecleon", "Shuppet", "Banette", "Duskull", "Dusclops", "Tropius", 
			"Chimecho", "Absol", "Wynaut", "Snorunt", "Glalie", "Spheal", "Sealeo", "Walrein", "Clamperl",
			"Huntail", "Gorebyss", "Relicanth", "Luvdisc", "Bagon", "Shelgon", "Salamence", "Beldum", 
			"Metang", "Metagross", "Regirock", "Regice", "Registeel", "Latias", "Latios", "Kyogre", 
			"Groudon", "Rayquaza", "Jirachi", "Deoxys",
			
			"Turtwig", "Grotle", "Torterra", "Chimchar", "Monferno", "Infernape", "Piplup", "Prinplup", 
			"Empoleon", "Starly", "Staravia", "Staraptor", "Bidoof", "Bibarel", "Kricketot", "Kricketune", 
			"Shinx", "Luxio", "Luxray", "Budew", "Roserade", "Cranidos", "Rampardos", "Shieldon", "Bastiodon", 
			"Burmy", "Wormadam", "Mothim", "Combee", "Vespiquen", "Pachirisu", "Buizel", "Floatzel", "Cherubi", 
			"Cherrim", "Shellos", "Gastrodon", "Ambipom", "Drifloon", "Drifblim", "Buneary", "Lopunny", 
			"Mismagius", "Honchkrow", "Glameow", "Purugly", "Chingling", "Stunky", "Skuntank", "Bronzor", 
			"Bronzong", "Bonsly", "Mime Jr.", "Happiny", "Chatot", "Spiritomb", "Gible", "Gabite", "Garchomp", 
			"Munchlax", "Riolu", "Lucario", "Hippopotas", "Hippowdon", "Skorupi", "Drapion", "Croagunk", 
			"Toxicroak", "Carnivine", "Finneon", "Lumineon", "Mantyke", "Snover", "Abomasnow", "Weavile", 
			"Magnezone", "Lickilicky", "Rhyperior", "Tangrowth", "Electivire", "Magmortar", "Togekiss", 
			"Yanmega", "Leafeon", "Glaceon", "Gliscor", "Mamoswine", "Porygon-Z", "Gallade", "Probopass", 
			"Dusknoir", "Froslass", "Rotom", "Uxie", "Mesprit", "Azelf", "Dialga", "Palkia", "Heatran", 
			"Regigigas", "Giratina", "Cresselia", "Phione", "Manaphy", "Darkrai", "Shaymin", "Arceus",
			
			"Victini", "Snivy", "Servine", "Serperior", "Tepig", "Pignite", "Emboar", "Oshawott", "Dewott", "Samurott", "Patrat", "Watchog",
			"Lillipup", "Herdier", "Stoutland", "Purrloin", "Liepard", "Pansage", "Simisage", "Pansear", "Simisear", "Panpour", "Simipour",
			"Munna", "Musharna", "Pidove", "Tranquill", "Unfezant", "Blitzle", "Zebstrika", "Roggenrola", "Boldore", "Gigalith", "Woobat",
			"Swoobat", "Drilbur", "Excadrill", "Audino", "Timburr", "Gurdurr", "Conkeldurr", "Tympole", "Palpitoad", "Seismitoad", "Throh",
			"Sawk", "Sewaddle", "Swadloon", "Leavanny", "Venipede", "Whirlipede", "Scolipede", "Cottonee", "Whimsicott", "Petilil",
			"Lilligant", "Basculin", "Sandile", "Krokorok", "Krookodile", "Darumaka", "Darmanitan", "Maractus", "Dwebble", "Crustle",
			"Scraggy", "Scrafty", "Sigilyph", "Yamask", "Cofagrigus", "Tirtouga", "Carracosta", "Archen", "Archeops", "Trubbish",
			"Garbodor", "Zorua", "Zoroark", "Minccino", "Cinccino", "Gothita", "Gothorita", "Gothitelle", "Solosis", "Duosion",
			"Reuniclus", "Ducklett", "Swanna", "Vanillite", "Vanillish", "Vanilluxe", "Deerling", "Sawsbuck", "Emolga", "Karrablast",
			"Escavalier", "Foongus", "Amoonguss", "Frillish", "Jellicent", "Alomomola", "Joltik", "Galvantula", "Ferroseed",
			"Ferrothorn", "Klink", "Klang", "Klinklang", "Tynamo", "Eelektrik", "Eelektross", "Elgyem", "Beheeyem", "Litwick",
			"Lampent", "Chandelure", "Axew", "Fraxure", "Haxorus", "Cubchoo", "Beartic", "Cryogonal", "Shelmet", "Accelgor",
			"Stunfisk", "Mienfoo", "Mienshao", "Druddigon", "Golett", "Golurk", "Pawniard", "Bisharp", "Bouffalant", "Rufflet",
			"Braviary", "Vullaby", "Mandibuzz", "Heatmor", "Durant", "Deino", "Zweilous", "Hydreigon", "Larvesta", "Volcarona", "Cobalion", 
			"Terrakion", "Virizion", "Tornadus", "Thundurus", "Reshiram", "Zekrom", "Landorus", "Kyurem", "Keldeo", "Meloetta", "Genesect",
			
			"Pokémon Egg", "Manaphy Egg"
            }
local xfix = 10
local yfix = 10
function displaybox(a,b,c,d,e,f)
	gui.box(a+xfix,b+yfix,c+xfix,d+yfix,e,f)
end

function display(a,b,c,d)
	gui.text(xfix+a,yfix+b,c, d)
end

function mult32(a,b)
	local c=rshift(a,16)
	local d=a%0x10000
	local e=rshift(b,16)
	local f=b%0x10000
	local g=(c*f+d*e)%0x10000
	local h=d*f
	local i=g*0x10000+h
	return i
end

function getbits(a,b,d)
	return rshift(a,b)%lshift(1,d)
end

function gettop(a)
	return(rshift(a,16))
end

function getGen()
	if game < 4 then
		return 4
	else
		return 5
	end
end

function getGameName()
	if game == 1 then
		return "Pearl"
	elseif game == 2 then
		return "HeartGold"
	elseif game == 3 then
		return "Platinum"
	elseif game == 4 then
		return "Black"
	elseif game == 5 then
		return "White"
	elseif game == 6 then
		return "Black 2"
	else--if game == 7 then
		return "White 2"
	end
end

function getPointer()
	if game == 1 then
		return memory.readdword(0x02106FAC)
	elseif game == 2 then
		return memory.readdword(0x0211186C)
	else -- game == 3
		return memory.readdword(0x02101D2C)
	end
	-- haven't found pointers for BW/B2W2, probably not needed anyway.
end

function getPidAddr()
	if game == 1 then --Pearl
		enemyAddr = pointer + 0x364C8
		if mode == 5 then
			return pointer + 0x36C6C
		elseif mode == 4 then
			return memory.readdword(enemyAddr) + 0x774 + 0x5B0 + 0xEC*(submode-1)
		elseif mode == 3 then
			return memory.readdword(enemyAddr) + 0x774 + 0xB60 + 0xEC*(submode-1)
		elseif mode == 2 then
			return memory.readdword(enemyAddr) + 0x774 + 0xEC*(submode-1)
		else
			return pointer + 0xD2AC + 0xEC*(submode-1)
		end
	elseif game == 2 then --HeartGold
		enemyAddr = pointer + 0x37970
		if mode == 5 then
			return pointer + 0x38540
		elseif mode == 4 then
			return memory.readdword(enemyAddr) + 0x1C70 + 0xA1C + 0xEC*(submode-1)	
		elseif mode == 3 then
			return memory.readdword(enemyAddr) + 0x1C70 + 0x1438 + 0xEC*(submode-1)
		elseif mode == 2 then
			return memory.readdword(enemyAddr) + 0x1C70 + 0xEC*(submode-1)
		else
			return pointer + 0xD088 + 0xEC*(submode-1)
		end
	elseif game == 3 then --Platinum
		enemyAddr = pointer + 0x352F4
		if mode == 5 then
			return pointer + 0x35AC4
		elseif mode == 4 then
			return memory.readdword(enemyAddr) + 0x7A0 + 0x5B0 + 0xEC*(submode-1)
		elseif mode == 3 then
			return memory.readdword(enemyAddr) + 0x7A0 + 0xB60 + 0xEC*(submode-1) 
		elseif mode == 2 then
			return memory.readdword(enemyAddr) + 0x7A0 + 0xEC*(submode-1) 
		else
			return pointer + 0xD094 + 0xEC*(submode-1)
		end
	elseif game == 4 then --Black
		if mode == 5 then
			return 0x02259DD8
		elseif mode == 4 then
			return 0x0226B7B4 + 0xDC*(submode-1)
		elseif mode == 3 then
			return 0x0226C274 + 0xDC*(submode-1)
		elseif mode == 2 then
			return 0x0226ACF4 + 0xDC*(submode-1)
		else -- mode 1
			return 0x022349B4 + 0xDC*(submode-1) 
		end
	elseif game == 5 then --White
		if mode == 5 then
			return 0x02259DF8
		elseif mode == 4 then
			return 0x0226B7D4 + 0xDC*(submode-1)
		elseif mode == 3 then
			return 0x0226C294 + 0xDC*(submode-1)	
		elseif mode == 2 then
			return 0x0226AD14 + 0xDC*(submode-1)
		else -- mode 1
			return 0x022349D4 + 0xDC*(submode-1) 
		end
	elseif game == 6 then --Black 2
		if mode == 5 then
			return 0x0224795C
		elseif mode == 4 then
			return 0x022592F4 + 0xDC*(submode-1)
		elseif mode == 3 then
			return 0x02259DB4 + 0xDC*(submode-1)			
		elseif mode == 2 then
			return 0x02258834 + 0xDC*(submode-1)
		else -- mode 1
			return 0x0221E3EC + 0xDC*(submode-1)
		end
	else --White 2
		if mode == 5 then
			return 0x0224799C
		elseif mode == 4 then
			return 0x02259334 + 0xDC*(submode-1)
		elseif mode == 3 then
			return 0x02259DF4 + 0xDC*(submode-1)
		elseif mode == 2 then
			return 0x02258874 + 0xDC*(submode-1)
		else -- mode 1
			return 0x0221E42C + 0xDC*(submode-1)
		end
	end
end

function read_adressess()
    gen = getGen()
	pointer = getPointer()
	pidAddr = getPidAddr()
	pid = memory.readdword(pidAddr)
    checksum = memory.readword(pidAddr + 6)
	shiftvalue = (rshift((bnd(pid,0x3E000)),0xD)) % 24
    
    BlockAoff = (BlockA[shiftvalue + 1] - 1) * 32
	BlockBoff = (BlockB[shiftvalue + 1] - 1) * 32
	BlockCoff = (BlockC[shiftvalue + 1] - 1) * 32
	BlockDoff = (BlockD[shiftvalue + 1] - 1) * 32
    
    -- Block A
	prng = checksum
	for i = 1, BlockA[shiftvalue + 1] - 1 do
		prng = mult32(prng,0x5F748241) + 0xCBA72510 -- 16 cycles
	end
	
	prng = mult32(prng,0x41C64E6D) + 0x6073
	pokemonID = bxr(memory.readword(pidAddr + BlockAoff + 8), gettop(prng))
	if gen == 4 and pokemonID > 494 then --just to make sure pokemonID is right (gen 4)
		pokemonID = -1 -- (pokemonID = -1 indicates invalid data)
	elseif gen == 5 and pokemonID > 651 then -- gen5
		pokemonID = -1 -- (pokemonID = -1 indicates invalid data)
	end
	
	prng = mult32(prng,0x41C64E6D) + 0x6073
	heldItem = bxr(memory.readword(pidAddr + BlockAoff + 2 + 8), gettop(prng))
	if gen == 4 and heldItem > 537 then -- Gen 4
		pokemonID = -1 -- (pokemonID = -1 indicates invalid data)
	elseif gen == 5 and heldItem > 639 then -- Gen 5
		pokemonID = -1 -- (pokemonID = -1 indicates invalid data)
	end
	
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
    experience = bxr(memory.readword(pidAddr + BlockAoff + 8 + 8), gettop(prng))
	prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
	ability = bxr(memory.readword(pidAddr + BlockAoff + 12 + 8), gettop(prng))
	friendship_or_steps_to_hatch = getbits(ability, 0, 8)
	ability = getbits(ability, 8, 8)
	if gen == 4 and ability > 123 then
		pokemonID = -1 -- (pokemonID = -1 indicates invalid data)
	elseif gen == 5 and ability > 164 then
		pokemonID = -1
	end
    
    -- Block B
	prng = checksum
	for i = 1, BlockB[shiftvalue + 1] - 1 do
		prng = mult32(prng,0x5F748241) + 0xCBA72510 -- 16 cycles
	end
    
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
    prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
	
	prng = mult32(prng,0x41C64E6D) + 0x6073
	ivspart[1] = bxr(memory.readword(pidAddr + BlockBoff + 16 + 8), gettop(prng))
	prng = mult32(prng,0x41C64E6D) + 0x6073
	ivspart[2] = bxr(memory.readword(pidAddr + BlockBoff + 18 + 8), gettop(prng))
	ivs = ivspart[1]  + lshift(ivspart[2],16)
	isegg = getbits(ivs,30,1)
    
    -- Block C
	prng = checksum
	for i = 1, BlockC[shiftvalue + 1] - 1 do
		prng = mult32(prng,0x5F748241) + 0xCBA72510 -- 16 cycles
	end
    --No clue if any of black c works.
    prng = mult32(prng,0x41C64E6D) + 0x6073
    for i = 0, 21 do
        nickname[i+1] = bxr(memory.readbyte(pidAddr + BlockCoff + i + 8), gettop(prng))
    end
    
    -- Block D
	prng = checksum
	for i = 1, BlockD[shiftvalue + 1] - 1 do
		prng = mult32(prng,0x5F748241) + 0xCBA72510 -- 16 cycles
	end
	
	prng = mult32(prng,0xCFDDDF21) + 0x67DBB608 -- 8 cycles
	prng = mult32(prng,0xEE067F11) + 0x31B0DDE4 -- 4 cycles
	prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
	pkrs = bxr(memory.readword(pidAddr + BlockDoff + 0x1A + 8), gettop(prng))
	pkrs = getbits(pkrs,0,8)
	
	-- Current stats
	prng = pid
	prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
	prng = mult32(prng,0x41C64E6D) + 0x6073
	level = getbits(bxr(memory.readword(pidAddr + 0x8C), gettop(prng)),0,8)
	prng = mult32(prng,0x41C64E6D) + 0x6073
	hpstat = bxr(memory.readword(pidAddr + 0x8E), gettop(prng))
	prng = mult32(prng,0x41C64E6D) + 0x6073
	maxhpstat = bxr(memory.readword(pidAddr + 0x90), gettop(prng))
end

function debugScreen()
    submode = debugsubmode
    -- Display data
	displaybox(-5,-5,240,175,"#000000A0", "white")
    display(5,0,"dude22072's PokeStats Script (DEBUG)","white")
	display(180,10, getGameName(), "#FF88FFFF")
    display(0,15,"Slot:","White")
    display(80,15,submode,"White")
	if pokemonID == -1 then
		display(55,30, "Invalid Pokemon Data", "red")
	else
		if isegg == 1 then
			display(0,25, "Pokemon: " .. pokemon[pokemonID + 1] .. " egg", "yellow")
		else
			display(0,25, "Pokemon: " .. pokemon[pokemonID + 1], "yellow")
		end
        display(0,35,"Nickname: ", "yellow")
        for i = 1,23 do
            display(50 + (i*5),35,nickname[i], "yellow")
        end
        
		display(0,45, "PID : " .. bit.tohex(pid), "magenta")
		display(0,55, "Item: ", "white")
        display(80,55,heldItem,"white")
		display(0,65, "Level: ", "green")
        display(80,65, level, "green")
        display(0,75, "HP: ", "green")
        
        if hpstat > 0 then
            if maxhpstat >= 100 then
                if hpstat >= 100 then
                    display(44,75, hpstat.."/"..maxhpstat, "green")
                else 
                    if hpstat >= 10 then
                        display(50,75, hpstat.."/"..maxhpstat, "green")
                    else
                        display(56,75, hpstat.."/"..maxhpstat, "green")
                    end
                end
            else 
                if maxhpstat >= 10 then
                    if hpstat >= 10 then
                        display(56,75, hpstat.."/"..maxhpstat, "green")
                    else
                        display(62,75, hpstat.."/"..maxhpstat, "green")
                    end
                else
                    display(68,75, hpstat.."/"..maxhpstat, "green")
                end
            end
        else
            if maxhpstat >= 100 then
                display(56,65, hpstat.."/"..maxhpstat, "red")
            else
                if maxhpstat >= 10 then
                    display(62,75, hpstat.."/"..maxhpstat, "red")
                else
                    display(68,75, hpstat.."/"..maxhpstat, "red")
                end
            end
        end
        
        display(0,85, "EXP:", "blue")
        display(25,85,experience,"blue")
        
		if pkrs == 0 then
			display(0,95, "PKRS:       no", "red")
		else
			display(0,95, "PKRS: yes (" .. pkrs .. ")", "red")
		end
		if isegg == 0 then
			display(0,105, "Friendship: " .. friendship_or_steps_to_hatch, "orange")
		else
			display(0,105, "Steps to hatch: ", "orange")
			display(0,115, friendship_or_steps_to_hatch * 256 .. "-" .. (friendship_or_steps_to_hatch + 1) * 256 .. " steps", "orange")
		end
	end
    
    --Controls
    display(0,130,previousPokemonKey.."/"..nextPokemonKey..": Change Pokemon","orange")
    display(0,140,displayScreenKey..": Change Displays", "orange")
    display(0,150,displayKey..": Show/Hide Display","orange")
    display(0,160,textOutputKey..": Enable/Disable Text Output","orange")
    
    if textoutputbool ~= 0 then
        display(185,160,"(Enabled)","green")
    else 
        display(180,160,"(Disabled)","red")
    end
end

function menu()
	tabl = input.get()
    if tabl[displayKey] and not prev[displayKey] then
        if debugscreenbool == 0 then
            debugscreenbool = 1
        else
            debugscreenbool = 0
        end
    end
	if tabl[previousPokemonKey] and not prev[previousPokemonKey] and mode < 5 then
		debugsubmode = debugsubmode - 1
		if debugsubmode == 0 then
			debugsubmode = submodemax
		end
	end
	if tabl[nextPokemonKey] and not prev[nextPokemonKey] and mode < 5 then
		debugsubmode = debugsubmode + 1
		if debugsubmode == submodemax + 1 then
			debugsubmode = 1
		end
	end
	if tabl[displayScreenKey] and not prev[displayScreenKey] then
		if yfix == 10 then
			yfix = -185
		else
			yfix = 10
		end
	end
    
    if tabl[textOutputKey] and not prev[textOutputKey] then
		if textoutputbool == 0 then
            textoutputbool = 1
        else
            textoutputbool = 0
        end
	end
	prev = tabl
end

function do_pokestats()
    menu()
    if textoutputbool ~= 0 then
    --File Output
        if filecheck~=file then
            file:close()
            file=io.open(textoutputpath, "w+")
            file:close()
            file=io.open(textoutputpath, "w")
            for i=1, 6 do
                submode = i
                read_adressess()
                file:write(pokemon[pokemonID + 1].."\n")
                file:write(pokemon[pokemonID + 1].."\n") --Writing the species as the nickname because we don't have a charmap
                --for i = 1,22 do
                --    file:write(nickname[i])
                --end
                file:write("\n"..
                    hpstat.."\n"..
                    maxhpstat.."\n"..
                    level.."\n"..
                    "0\n"..--team[i].status.."\n"..
                    pkrs.."\n"..
                    heldItem.."\n"..
                        experience.."\n")
                file:flush()
            end
        end  
    end
    if debugscreenbool ~= 0 then
        submode = debugsubmode
        read_adressess()
        debugScreen()
    end
end