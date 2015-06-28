--TODO:Status, PKRS, Item, Other things
local pokestatsTextFilePath = "D:/pokestats.txt"
local file = nil
local fileReader = {}
imgEXPBarFrame = love.graphics.newImage('BarFix/BARexpFRAME.gif')
imgEXPBarBlue = love.graphics.newImage('BarFix/BARexpBLUE.gif')
imgEXPBarBack = love.graphics.newImage('BarFix/BARexpBACK.gif')
imgHPBarFrame = love.graphics.newImage('BarFix/BAR.gif')
imgHPBarGrey = love.graphics.newImage('BarFix/BARhpGRAY.gif')
imgHPBarRed = love.graphics.newImage('BarFix/BARhpRED.gif')
imgHPBarYellow = love.graphics.newImage('BarFix/BARhpYELLOW.gif')
imgHPBarGreen = love.graphics.newImage('BarFix/BARhpGREEN.gif')
pokemonIMG = {}
pokemonNickname = {}
pokemonHP = {}
pokemonHPMax = {}
pokemonLevel = {}
pokemonStatus = {}
pokemonPKRS = {}
pokemonItem = {}
pokemonCurEXP = {}
pokemonMaxEXP = {}
pokemonEXPDif = {}
hpQuads = {}
hpGreyQuad = {}
expQuads = {}
local shifter = 115


-- Configuration
function love.conf(t)
	t.title = "PokeStats Display 3.0.0" -- The title of the window the game is in (string)
	t.version = "0.9.2"        -- The LÖVE version this was made for
	t.window.width = 722
	t.window.height = 86

	-- For Windows debugging
	t.console = true
end

--Runs before anything else
function love.load(arg)
    if CheckPath(pokestatsTextFilePath) == false then
        print("ERROR:FILE NOT FOUND")
    end
    --love.graphics.setNewFont("C:/Users/tammi/Documents/GitHub/PokeStats/pkmmfl.ttf", "9")
    love.graphics.setNewFont(9)
end

--Called every frame
function love.update(dt)
    --print("hello World")
    file=io.open(pokestatsTextFilePath, "r")
    local filecheck=file:read("*all")
    fileReader = mysplit(filecheck, "\n")
    
    for I=0,5 do
        if fileReader[1+(I*9)] ~= "None" then
        pokemonIMG[I] = love.graphics.newImage('sprites/'..fileReader[1+(I*9)]..'.gif')
        pokemonNickname[I] = fileReader[2+(I*9)]
        pokemonHP[I] = fileReader[3+(I*9)]
        pokemonHPMax[I] = fileReader[4+(I*9)]
        pokemonLevel[I] = fileReader[5+(I*9)]
        pokemonStatus[I] = fileReader[6+(I*9)]
        pokemonPKRS[I] = fileReader[7+(I*9)]
        pokemonItem[I] = fileReader[8+(I*9)]
        pokemonCurEXP[I] = fileReader[9+(I*9)]
        
        pokemonEXPDif[I] = expNeeded(pokemonLevel[I], getExpGroup(fileReader[1+(I*9)]))
        pokemonCurEXP[I] = pokemonCurEXP[I] - pokemonEXPDif[I]
        pokemonMaxEXP[I] = (expNeeded((pokemonLevel[I] + 1), getExpGroup(fileReader[1+(I*9)]))) - pokemonEXPDif[I]
        else
        
        end
    end
end

--Called every frame
function love.draw(dt)
    for I=0,5 do
        if fileReader[1+(I*9)] ~= nil and fileReader[1+(I*9)] ~= "None" then
            --Sprite and name and crap
            love.graphics.draw(pokemonIMG[I], (I*shifter), 0)
            love.graphics.print(pokemonNickname[I], 70+(I*shifter), 0)
            love.graphics.print("Lvl: "..pokemonLevel[I], 70+(I*shifter), 15)
            
            --HP Bar
            hpGreyQuad[I] = love.graphics.newQuad(0, 0, 55, 4, imgHPBarGrey:getDimensions())
            love.graphics.draw(imgHPBarGrey, hpGreyQuad[I], 16+(I*shifter), 62)
            hpQuads[I] = love.graphics.newQuad(0, 0, map(pokemonHP[I], 0, pokemonHPMax[I], 0, 55), 4, imgHPBarGrey:getDimensions())
            if tonumber(pokemonHP[I]) <= (tonumber(pokemonHPMax[I])/4) then
                love.graphics.draw(imgHPBarRed, hpQuads[I], 16+(I*shifter), 62)
            elseif tonumber(pokemonHP[I]) <= (tonumber(pokemonHPMax[I])/2) then
                love.graphics.draw(imgHPBarYellow, hpQuads[I], 16+(I*shifter), 62)
            else
                love.graphics.draw(imgHPBarGreen, hpQuads[I], 16+(I*shifter), 62)
            end
            
            love.graphics.draw(imgHPBarFrame, 0+(I*shifter), 60)
            
            --EXP Bar
            love.graphics.draw(imgEXPBarBack, 16+(I*shifter), 71)
            expQuads[I] = love.graphics.newQuad(0, 0, map(pokemonCurEXP[I], 0, 100, 0, 110), 4, imgEXPBarFrame:getDimensions())
            love.graphics.draw(imgEXPBarBlue, expQuads[I], 16+(I*shifter), 71)
            love.graphics.draw(imgEXPBarFrame, 0+(I*shifter), 70)
        end
    end
end

function expNeeded(curLevel,expGroup)
    if expGroup == 1 then
        return ((5 * (curLevel ^ 3)) / 4)
    elseif expGroup == 2 then
        return (1.2 * (curLevel ^ 3)) - (15 * (curLevel ^ 2)) + (100 * curLevel) - 140
    elseif expGroup == 3 then
        return (curLevel ^ 3)
    elseif expGroup == 4 then
        return ((4 * (curLevel ^ 3)) / 5)
    else
        return 1
    end
end

function getExpGroup(species)
    if species ==  "Bulbasaur" then
        return 2
    elseif species ==  "Ivysaur" then
        return 2
    elseif species ==  "Venusaur" then
        return 2
    elseif species ==  "Charmander" then
        return 2
    elseif species ==  "Charmeleon" then
        return 2
    elseif species ==  "Charizard" then
        return 2
    elseif species ==  "Squirtle" then
        return 2
    elseif species ==  "Wartortle" then
        return 2
    elseif species ==  "Blastoise" then
        return 2
    elseif species ==  "Caterpie" then
        return 3
    elseif species ==  "Metapod" then
        return 3
    elseif species ==  "Butterfree" then
        return 3
    elseif species ==  "Weedle" then
        return 3
    elseif species ==  "Kakuna" then
        return 3
    elseif species ==  "Beedrill" then
        return 3
    elseif species ==  "Pidgey" then
        return 2
    elseif species ==  "Pidgeotto" then
        return 2
    elseif species ==  "Pidgeot" then
        return 2
    elseif species ==  "Rattata" then
        return 3
    elseif species ==  "Raticate" then
        return 3
    elseif species ==  "Spearow" then
        return 3
    elseif species ==  "Fearow" then
        return 3
    elseif species ==  "Ekans" then
        return 3
    elseif species ==  "Arbok" then
        return 3
    elseif species ==  "Pikachu" then
        return 3
    elseif species ==  "Raichu" then
        return 3
    elseif species ==  "Sandshrew" then
        return 3
    elseif species ==  "Sandslash" then
        return 3
    elseif species ==  "NidoranF" then
        return 2
    elseif species ==  "Nidorina" then
        return 2
    elseif species ==  "Nidoqueen" then
        return 2
    elseif species ==  "NidoranM" then
        return 2
    elseif species ==  "Nidorino" then
        return 2
    elseif species ==  "Nidoking" then
        return 2
    elseif species ==  "Clefairy" then
        return 4
    elseif species ==  "Clefable" then
        return 4
    elseif species ==  "Vulpix" then
        return 3
    elseif species ==  "Ninetales" then
        return 3
    elseif species ==  "Jigglypuff" then
        return 4
    elseif species ==  "Wigglytuff" then
        return 4
    elseif species ==  "Zubat" then
        return 3
    elseif species ==  "Golbat" then
        return 3
    elseif species ==  "Oddish" then
        return 2
    elseif species ==  "Gloom" then
        return 2
    elseif species ==  "Vileplume" then
        return 2
    elseif species ==  "Paras" then
        return 3
    elseif species ==  "Parasect" then
        return 3
    elseif species ==  "Venonat" then
        return 3
    elseif species ==  "Venomoth" then
        return 3
    elseif species ==  "Diglett" then
        return 3
    elseif species ==  "Dugtrio" then
        return 3
    elseif species ==  "Meowth" then
        return 3
    elseif species ==  "Persian" then
        return 3
    elseif species ==  "Psyduck" then
        return 3
    elseif species ==  "Golduck" then
        return 3
    elseif species ==  "Mankey" then
        return 3
    elseif species ==  "Primeape" then
        return 3
    elseif species ==  "Growlithe" then
        return 1
    elseif species ==  "Arcanine" then
        return 1
    elseif species ==  "Poliwag" then
        return 2
    elseif species ==  "Poliwhirl" then
        return 2
    elseif species ==  "Poliwrath" then
        return 2
    elseif species ==  "Abra" then
        return 2
    elseif species ==  "Kadabra" then
        return 2
    elseif species ==  "Alakazam" then
        return 2
    elseif species ==  "Machop" then
        return 2
    elseif species ==  "Machoke" then
        return 2
    elseif species ==  "Machamp" then
        return 2
    elseif species ==  "Bellsprout" then
        return 2
    elseif species ==  "Weepinbell" then
        return 2
    elseif species ==  "Victreebel" then
        return 2
    elseif species ==  "Tentacool" then
        return 1
    elseif species ==  "Tentacruel" then
        return 1
    elseif species ==  "Geodude" then
        return 2
    elseif species ==  "Graveler" then
        return 2
    elseif species ==  "Golem" then
        return 2
    elseif species ==  "Ponyta" then
        return 3
    elseif species ==  "Rapidash" then
        return 3
    elseif species ==  "Slowpoke" then
        return 3
    elseif species ==  "Slowbro" then
        return 3
    elseif species ==  "Magnemite" then
        return 3
    elseif species ==  "Magneton" then
        return 3
    elseif species ==  "Farfetch'd" then
        return 3
    elseif species ==  "Doduo" then
        return 3
    elseif species ==  "Dodrio" then
        return 3
    elseif species ==  "Seel" then
        return 3
    elseif species ==  "Dewgong" then
        return 3
    elseif species ==  "Grimer" then
        return 3
    elseif species ==  "Muk" then
        return 3
    elseif species ==  "Shellder" then
        return 1
    elseif species ==  "Cloyster" then
        return 1
    elseif species ==  "Gastly" then
        return 2
    elseif species ==  "Haunter" then
        return 2
    elseif species ==  "Gengar" then
        return 2
    elseif species ==  "Onix" then
        return 3
    elseif species ==  "Drowzee" then
        return 3
    elseif species ==  "Hypno" then
        return 3
    elseif species ==  "Krabby" then
        return 3
    elseif species ==  "Kingler" then
        return 3
    elseif species ==  "Voltorb" then
        return 3
    elseif species ==  "Electrode" then
        return 3
    elseif species ==  "Exeggcute" then
        return 1
    elseif species ==  "Exeggutor" then
        return 1
    elseif species ==  "Cubone" then
        return 3
    elseif species ==  "Marowak" then
        return 3
    elseif species ==  "Hitmonlee" then
        return 3
    elseif species ==  "Hitmonchan" then
        return 3
    elseif species ==  "Lickitung" then
        return 3
    elseif species ==  "Koffing" then
        return 3
    elseif species ==  "Weezing" then
        return 3
    elseif species ==  "Rhyhorn" then
        return 1
    elseif species ==  "Rhydon" then
        return 1
    elseif species ==  "Chansey" then
        return 4
    elseif species ==  "Tangela" then
        return 3
    elseif species ==  "Kangaskhan" then
        return 3
    elseif species ==  "Horsea" then
        return 3
    elseif species ==  "Seadra" then
        return 3
    elseif species ==  "Goldeen" then
        return 3
    elseif species ==  "Seaking" then
        return 3
    elseif species ==  "Staryu" then
        return 1
    elseif species ==  "Starmie" then
        return 1
    elseif species ==  "Mr. Mime" then
        return 3
    elseif species ==  "Scyther" then
        return 3
    elseif species ==  "Jynx" then
        return 3
    elseif species ==  "Electabuzz" then
        return 3
    elseif species ==  "Magmar" then
        return 3
    elseif species ==  "Pinsir" then
        return 1
    elseif species ==  "Tauros" then
        return 1
    elseif species ==  "Magikrap" then
        return 1
    elseif species ==  "Gyarados" then
        return 1
    elseif species ==  "Lapras" then
        return 1
    elseif species ==  "Ditto" then
        return 3
    elseif species ==  "Eevee" then
        return 3
    elseif species ==  "Vaporeon" then
        return 3
    elseif species ==  "Jolteon" then
        return 3
    elseif species ==  "Flareon" then
        return 3
    elseif species ==  "Porygon" then
        return 3
    elseif species ==  "Omanyte" then
        return 3
    elseif species ==  "Omastar" then
        return 3
    elseif species ==  "Kabuto" then
        return 3
    elseif species ==  "Kabutops" then
        return 3
    elseif species ==  "Aerodactyl" then
        return 1
    elseif species ==  "Snorlax" then
        return 1
    elseif species ==  "Articuno" then
        return 1
    elseif species ==  "Zapdos" then
        return 1
    elseif species ==  "Moltres" then
        return 1
    elseif species ==  "Dratini" then
        return 1
    elseif species ==  "Dragonair" then
        return 1
    elseif species ==  "Dragonite" then
        return 1
    elseif species ==  "Mewtwo" then
        return 1
    elseif species ==  "Mew" then
        return 2
    elseif species ==  "Chikorita" then
        return 2
    elseif species ==  "Bayleef" then
        return 2
    elseif species ==  "Meganium" then
        return 2
    elseif species ==  "Cyndaquil" then
        return 2
    elseif species ==  "Quilava" then
        return 2
    elseif species ==  "Typhlosion" then
        return 2
    elseif species ==  "Totodile" then
        return 2
    elseif species ==  "Croconaw" then
        return 2
    elseif species ==  "Feraligatr" then
        return 2
    elseif species ==  "Sentret" then
        return 3
    elseif species ==  "Furret" then
        return 3
    elseif species ==  "Hoothoot" then
        return 3
    elseif species ==  "Noctowl" then
        return 3
    elseif species ==  "Ledyba" then
        return 4
    elseif species ==  "Ledian" then
        return 4
    elseif species ==  "Spinarak" then
        return 4
    elseif species ==  "Ariados" then
        return 4
    elseif species ==  "Crobat" then
        return 3
    elseif species ==  "Chinchou" then
        return 1
    elseif species ==  "Lanturn" then
        return 1
    elseif species ==  "Pichu" then
        return 3
    elseif species ==  "Cleffa" then
        return 4
    elseif species ==  "Igglybuff" then
        return 4
    elseif species ==  "Togepi" then
        return 4
    elseif species ==  "Togetic" then
        return 4
    elseif species ==  "Natu" then
        return 3
    elseif species ==  "Xatu" then
        return 3
    elseif species ==  "Mareep" then
        return 2
    elseif species ==  "Flaaffy" then
        return 2
    elseif species ==  "Ampharos" then
        return 2
    elseif species ==  "Bellossom" then
        return 2
    elseif species ==  "Marill" then
        return 4
    elseif species ==  "Azumarill" then
        return 4
    elseif species ==  "Sudowoodo" then
        return 3
    elseif species ==  "Politoed" then
        return 2
    elseif species ==  "Hoppip" then
        return 2
    elseif species ==  "Skiploom" then
        return 2
    elseif species ==  "Jumpluff" then
        return 2
    elseif species ==  "Aipom" then
        return 4
    elseif species ==  "Sunkern" then
        return 2
    elseif species ==  "Sunflora" then
        return 2
    elseif species ==  "Yanma" then
        return 3
    elseif species ==  "Wooper" then
        return 3
    elseif species ==  "Quagsire" then
        return 3
    elseif species ==  "Espeon" then
        return 3
    elseif species ==  "Umbreon" then
        return 3
    elseif species ==  "Murkrow" then
        return 2
    elseif species ==  "Slowking" then
        return 3
    elseif species ==  "Misdreavus" then
        return 4
    elseif species ==  "Unown" then
        return 3
    elseif species ==  "Wobbuffet" then
        return 3
    elseif species ==  "Girafarig" then
        return 3
    elseif species ==  "Pineco" then
        return 3
    elseif species ==  "Forretress" then
        return 3
    elseif species ==  "Dunsparce" then
        return 3
    elseif species ==  "Gligar" then
        return 2
    elseif species ==  "Steelix" then
        return 3
    elseif species ==  "Snubbull" then
        return 4
    elseif species ==  "Granbull" then
        return 4
    elseif species ==  "Qwilfish" then
        return 3
    elseif species ==  "Scizor" then
        return 3
    elseif species ==  "Shuckle" then
        return 2
    elseif species ==  "Heracross" then
        return 1
    elseif species ==  "Sneasel" then
        return 2
    elseif species ==  "Teddiursa" then
        return 3
    elseif species ==  "Ursaring" then
        return 3
    elseif species ==  "Slugma" then
        return 3
    elseif species ==  "Magcargo" then
        return 3
    elseif species ==  "Swinub" then
        return 1
    elseif species ==  "Piloswine" then
        return 1
    elseif species ==  "Corsola" then
        return 4
    elseif species ==  "Remoraid" then
        return 3
    elseif species ==  "Octillery" then
        return 3
    elseif species ==  "Delibird" then
        return 4
    elseif species ==  "Mantine" then
        return 1
    elseif species ==  "Skarmory" then
        return 1
    elseif species ==  "Houndour" then
        return 1
    elseif species ==  "Houndoom" then
        return 1
    elseif species ==  "Kingdra" then
        return 3
    elseif species ==  "Phanpy" then
        return 3
    elseif species ==  "Donphan" then
        return 3
    elseif species ==  "Porygon2" then
        return 3
    elseif species ==  "Stantler" then
        return 1
    elseif species ==  "Smeargle" then
        return 4
    elseif species ==  "Tyrogue" then
        return 3
    elseif species ==  "Hitmontop" then
        return 3
    elseif species ==  "Smoochum" then
        return 3
    elseif species ==  "Elekid" then
        return 3
    elseif species ==  "Magby" then
        return 3
    elseif species ==  "Miltank" then
        return 1
    elseif species ==  "Blissey" then
        return 4
    elseif species ==  "Raikou" then
        return 1
    elseif species ==  "Entei" then
        return 1
    elseif species ==  "Suicune" then
        return 1
    elseif species ==  "Larvitar" then
        return 1
    elseif species ==  "Pupitar" then
        return 1
    elseif species ==  "Tyranitar" then
        return 1
    elseif species ==  "Lugia" then
        return 1
    elseif species ==  "Ho-oh" then
        return 1
    elseif species ==  "Celebi" then
        return 2
    else
        return 0
    end
end

function CheckPath(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function map(x,in_min,in_max,out_min,out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end
