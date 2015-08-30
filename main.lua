require("AnAL")
require("pokestats-conf")

math.randomseed(os.time())

local shifter = 117 --The space between the starting of the pokemon info panels
---------------------------------------------------------------------------------------------------------------
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
imgStatus = {}
    imgStatus.BRN = love.graphics.newImage('status/BRN.gif')
    imgStatus.FNT = love.graphics.newImage('status/FNT.gif')
    imgStatus.FRZ = love.graphics.newImage('status/FRZ.gif')
    imgStatus.ITEM = love.graphics.newImage('status/ITEM.gif')
    imgStatus.PAR = love.graphics.newImage('status/PAR.gif')
    imgStatus.PKRS = love.graphics.newImage('status/PKRS.gif')
    imgStatus.PSN = love.graphics.newImage('status/PSN.gif')
    imgStatus.SLP = love.graphics.newImage('status/SLP.gif')
	imgStatus.nBRN = love.graphics.newImage('nstatus/nBRN.gif')
    imgStatus.nFNT = love.graphics.newImage('nstatus/nFNT.gif')
    imgStatus.nFRZ = love.graphics.newImage('nstatus/nFRZ.gif')
    imgStatus.nITEM = love.graphics.newImage('nstatus/nITEM.gif')
    imgStatus.nPAR = love.graphics.newImage('nstatus/nPAR.gif')
    imgStatus.nPKRS = love.graphics.newImage('nstatus/nPKRS.gif')
    imgStatus.nPSN = love.graphics.newImage('nstatus/nPSN.gif')
    imgStatus.nSLP = love.graphics.newImage('nstatus/nSLP.gif')
pokemon = {}
pokemonIMG = {}
pokemonIMGANI = {}
pokemonAnimation = {}
pokemonAnimationFrame = {}
animatingSprite = {}
for I=0,5 do
    animatingSprite[I]=false
end
pokemonNickname = {}
pokemonHP = {}
pokemonHPMax = {}
pokemonLevel = {}
pokemonStatus = {}
local statusname={
 "NIL",
 "SLP","SLP","SLP","PSN","BRN",
 "FRZ","PAR","PSN"}
pokemonPKRS = {}
pokemonItem = {}
pokemonCurEXP = {}
pokemonMaxEXP = {}
pokemonEXPDif = {}
hpQuads = {}
hpGreyQuad = {}
expQuads = {}
animationStuff = {}
animationStuff[1] = "Kappa" --Animation.pokemonToAnimate
animationStuff[2] = false -- Animation.hasPokemonAnimated


function love.load(arg)
    if CheckPath(pokestatsTextFilePath) == false then
        error("ERROR:FILE NOT FOUND")
    end
    love.graphics.setNewFont("pkmnfl.ttf", "12")
    print(os.time().." Loaded")
end

function love.update(dt)
    file=io.open(pokestatsTextFilePath, "r")
    if file~=nil then
        local filecheck=file:read("*all")
        fileReader = mysplit(filecheck, "\n")
    
        animationStuff[1] = fileReader[56]
        if animationStuff[1] == "NOBATTLE" or animationStuff[1] ~= animationStuff[3] then
            animationStuff[2] = false
        end
        
        pokemon[0] = fileReader[1]
        if pokemon[0] ~= "None" then
    
        
            for I=0,5 do
                pokemon[I] = fileReader[1+(I*9)]
                if pokemon[I] ~= "None" and pokemon[I] ~= "0" and pokemon[I] ~= nil then
                    pokemonIMG[I] = love.graphics.newImage('sprites/'..pokemon[I]..'.png')
                    pokemonNickname[I] = fileReader[2+(I*9)]
                    --[[if pokemonNickname[I] == animationStuff[1] then
                        if animationStuff[2] == false then
                            pokemonIMGANI[I] = love.graphics.newImage('animations/'..pokemon[I]..'Ani.png')
                            pokemonAnimation[I] = newAnimation(pokemonIMGANI[I], 64, 64, 0.02, getFrames(pokemon[I]))
                            animatingSprite[I] = true
                            pokemonAnimationFrame[I] = 0
                            animationStuff[2] = true
                            animationStuff[3] = animationStuff[1]
                        end
                    end]]-- --animations disabled
                    
                    pokemonHP[I] = fileReader[3+(I*9)]
                    pokemonHPMax[I] = fileReader[4+(I*9)]
                    pokemonLevel[I] = fileReader[5+(I*9)]
                    pokemonStatus[I] = fileReader[6+(I*9)]
                    pokemonPKRS[I] = fileReader[7+(I*9)]
                    pokemonItem[I] = fileReader[8+(I*9)]
                    pokemonCurEXP[I] = fileReader[9+(I*9)]
            
                    pokemonEXPDif[I] = expNeeded(pokemonLevel[I], getExpGroup(pokemon[I]))
                    pokemonCurEXP[I] = pokemonCurEXP[I] - pokemonEXPDif[I]
                    pokemonMaxEXP[I] = (expNeeded((pokemonLevel[I] + 1), getExpGroup(pokemon[I]))) - pokemonEXPDif[I]
                else
        
                end
                --[[if animatingSprite[I] == true then
                    pokemonAnimation[I]:update(dt)
                    pokemonAnimationFrame[I] = pokemonAnimationFrame[I] + 1
                    if pokemonAnimationFrame[I] >= getFrames(pokemon[I]) then
                        animatingSprite[I] = false
                        pokemonAnimationFrame[I] = 0
                    end
                end]]-- -- animations disabled
            end
        end
    end
end

function love.draw(dt)
    for I=0,5 do
        if I == 0 then
            drawPokemon(0)
        else
            if pokemon[I] ~= nil and pokemon[I] ~= "None" then
                drawPokemon(I)
            end
        end
    end
end

function drawPokemon(I)
--Sprite and name and crap
            if animatingSprite[I] == false then
                love.graphics.draw(pokemonIMG[I], (I*shifter), 0)
            else
                --pokemonAnimation[I]:draw((I*shifter), 0) --animations disabled
            end
            love.graphics.print(pokemonNickname[I], 70+(I*shifter), 8)
            love.graphics.print("Lvl: "..pokemonLevel[I], 70+(I*shifter), 21)
            
            --if pokemonStatus[I] ~= "0" then
            --   love.graphics.draw(imgStatus[statusname[pokemonStatus[I]+1]], 70+(I*shifter), 30)
            --end
			
			drawStatus(I * shifter + 72, 32, 0, 1, pokemonPKRS[I])			
            
            --if pokemonPKRS[I] ~= nil and pokemonPKRS[I] ~= "0" then
            --    love.graphics.draw(imgStatus.PKRS, 92+(I*shifter), 30)
            --end
            
            if pokemonItem[I] ~= nil and pokemonItem[I] ~= "0" then
                love.graphics.draw(imgStatus.ITEM, 113+(I*shifter), 18)
                --love.graphics.print(pokemonItem[I], 80+(I*shifter), 45)
            end
            
            --HP Bar
            hpGreyQuad[I] = love.graphics.newQuad(0, 0, 55, 4, imgHPBarGrey:getDimensions())
            love.graphics.draw(imgHPBarGrey, hpGreyQuad[I], 16+(I*shifter), 62)
            hpQuads[I] = love.graphics.newQuad(0, 0, map(pokemonHP[I], 0, pokemonHPMax[I], 0, 55), 4, imgHPBarGrey:getDimensions())
            if tonumber(pokemonHP[I]) <= (tonumber(pokemonHPMax[I])/4) then
                love.graphics.draw(imgHPBarRed, hpQuads[I], 15+(I*shifter), 62)
            elseif tonumber(pokemonHP[I]) <= (tonumber(pokemonHPMax[I])/2) then
                love.graphics.draw(imgHPBarYellow, hpQuads[I], 15+(I*shifter), 62)
            else
                love.graphics.draw(imgHPBarGreen, hpQuads[I], 15+(I*shifter), 62)
            end
            
            love.graphics.draw(imgHPBarFrame, (0+(I*shifter))-1, 60)
            
            --EXP Bar
            love.graphics.draw(imgEXPBarBack, 16+(I*shifter), 71)
            expQuads[I] = love.graphics.newQuad(0, 0, map(pokemonCurEXP[I], 0, expNeeded(pokemonLevel[I],getExpGroup(pokemon[I])), 0, 110), 4, imgEXPBarFrame:getDimensions())
            love.graphics.draw(imgEXPBarBlue, expQuads[I], 16+(I*shifter), 71)
            love.graphics.draw(imgEXPBarFrame, 0+(I*shifter), 70)
end

function drawStatus(x,y,statusFlags,HP,hasPKRS)
	-- this function could be made much more compact by simply performing the drawings conditional to the checks.
	local isFNT, isPSN, isPKRS, isSLP, isBRN, isPAR, isFRZ = false,false,false,false,false,false,false
	if HP == 0 then isFNT = true end
	if hasPKRS ~= 0 then isPKRS = true end
	if bit.band(0x04,statusFlags) ~= 0 then isSLP = true end
	if bit.band(0x08,statusFlags) ~= 0 then isPSN = true end
	if bit.band(0x10,statusFlags) ~= 0 then isBRN = true end
	if bit.band(0x20,statusFlags) ~= 0 then isFRZ = true end
	if bit.band(0x40,statusFlags) ~= 0 then isPAR = true end
	
	love.graphics.draw(imgStatus.nFNT, 	x 		, y ) 
	love.graphics.draw(imgStatus.nPKRS, x + 21 	, y ) 
	love.graphics.draw(imgStatus.nSLP, 	x 		, y + 12) 
	love.graphics.draw(imgStatus.nPSN, 	x + 21	, y + 12) 
	love.graphics.draw(imgStatus.nBRN, 	x 		, y + 24) 
	love.graphics.draw(imgStatus.nFRZ, 	x + 21	, y + 24) 
	love.graphics.draw(imgStatus.nPAR, 	x 		, y + 36) 
	
	if statusFlags == 255 then -- make sure they're set for testing
		isFNT = true
		isPKRS = true
	end
	
	if isFNT then	love.graphics.draw(imgStatus.FNT, 	x 		, y )	end
	if isPKRS then	love.graphics.draw(imgStatus.PKRS, 	x + 21 	, y )	end
	if isSLP then	love.graphics.draw(imgStatus.SLP, 	x 		, y + 12 )	end
	if isPSN then	love.graphics.draw(imgStatus.PSN, 	x + 21	, y + 12)	end
	if isBRN then	love.graphics.draw(imgStatus.BRN, 	x 		, y + 24)	end
	if isFRZ then	love.graphics.draw(imgStatus.FRZ, 	x + 21	, y + 24)	end
	if isPAR then	love.graphics.draw(imgStatus.PAR, 	x 		, y + 36)	end
	
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

function getFrames(species)
    if species ==  "Bulbasaur" then
        return 214
    elseif species ==  "Ivysaur" then
        return 138
    elseif species ==  "Venusaur" then
        return 244
    elseif species ==  "Charmander" then
        return 154
    elseif species ==  "Charmeleon" then
        return 114
    elseif species ==  "Charizard" then
        return 134
    elseif species ==  "Squirtle" then
        return 341
    elseif species ==  "Wartortle" then
        return 164
    elseif species ==  "Blastoise" then
        return 241
    --[[elseif species ==  "Caterpie" then
        return 0
    elseif species ==  "Metapod" then
        return 0
    elseif species ==  "Butterfree" then
        return 0
    elseif species ==  "Weedle" then
        return 0
    elseif species ==  "Kakuna" then
        return 0
    elseif species ==  "Beedrill" then
        return 0
    elseif species ==  "Pidgey" then
        return 0
    elseif species ==  "Pidgeotto" then
        return 0
    elseif species ==  "Pidgeot" then
        return 0
    elseif species ==  "Rattata" then
        return 0
    elseif species ==  "Raticate" then
        return 0
    elseif species ==  "Spearow" then
        return 0
    elseif species ==  "Fearow" then
        return 0
    elseif species ==  "Ekans" then
        return 0
    elseif species ==  "Arbok" then
        return 0
    elseif species ==  "Pikachu" then
        return 0
    elseif species ==  "Raichu" then
        return 0
    elseif species ==  "Sandshrew" then
        return 0
    elseif species ==  "Sandslash" then
        return 0
    elseif species ==  "NidoranF" then
        return 0
    elseif species ==  "Nidorina" then
        return 0
    elseif species ==  "Nidoqueen" then
        return 0
    elseif species ==  "NidoranM" then
        return 0
    elseif species ==  "Nidorino" then
        return 0
    elseif species ==  "Nidoking" then
        return 0
    elseif species ==  "Clefairy" then
        return 0
    elseif species ==  "Clefable" then
        return 0
    elseif species ==  "Vulpix" then
        return 0
    elseif species ==  "Ninetales" then
        return 0
    elseif species ==  "Jigglypuff" then
        return 0
    elseif species ==  "Wigglytuff" then
        return 0
    elseif species ==  "Zubat" then
        return 0
    elseif species ==  "Golbat" then
        return 0
    elseif species ==  "Oddish" then
        return 0
    elseif species ==  "Gloom" then
        return 0
    elseif species ==  "Vileplume" then
        return 0
    elseif species ==  "Paras" then
        return 0
    elseif species ==  "Parasect" then
        return 0
    elseif species ==  "Venonat" then
        return 0
    elseif species ==  "Venomoth" then
        return 0
    elseif species ==  "Diglett" then
        return 0
    elseif species ==  "Dugtrio" then
        return 0
    elseif species ==  "Meowth" then
        return 0
    elseif species ==  "Persian" then
        return 0
    elseif species ==  "Psyduck" then
        return 0
    elseif species ==  "Golduck" then
        return 0
    elseif species ==  "Mankey" then
        return 0
    elseif species ==  "Primeape" then
        return 0
    elseif species ==  "Growlithe" then
        return 0
    elseif species ==  "Arcanine" then
        return 0
    elseif species ==  "Poliwag" then
        return 0
    elseif species ==  "Poliwhirl" then
        return 0
    elseif species ==  "Poliwrath" then
        return 0
    elseif species ==  "Abra" then
        return 0
    elseif species ==  "Kadabra" then
        return 0
    elseif species ==  "Alakazam" then
        return 0
    elseif species ==  "Machop" then
        return 0
    elseif species ==  "Machoke" then
        return 0
    elseif species ==  "Machamp" then
        return 0
    elseif species ==  "Bellsprout" then
        return 0
    elseif species ==  "Weepinbell" then
        return 0
    elseif species ==  "Victreebel" then
        return 0
    elseif species ==  "Tentacool" then
        return 0
    elseif species ==  "Tentacruel" then
        return 0
    elseif species ==  "Geodude" then
        return 0
    elseif species ==  "Graveler" then
        return 0
    elseif species ==  "Golem" then
        return 0
    elseif species ==  "Ponyta" then
        return 0
    elseif species ==  "Rapidash" then
        return 0
    elseif species ==  "Slowpoke" then
        return 0
    elseif species ==  "Slowbro" then
        return 0
    elseif species ==  "Magnemite" then
        return 0
    elseif species ==  "Magneton" then
        return 0
    elseif species ==  "Farfetch'd" then
        return 0
    elseif species ==  "Doduo" then
        return 0
    elseif species ==  "Dodrio" then
        return 0
    elseif species ==  "Seel" then
        return 0
    elseif species ==  "Dewgong" then
        return 0
    elseif species ==  "Grimer" then
        return 0
    elseif species ==  "Muk" then
        return 0
    elseif species ==  "Shellder" then
        return 0
    elseif species ==  "Cloyster" then
        return 0
    elseif species ==  "Gastly" then
        return 0
    elseif species ==  "Haunter" then
        return 0
    elseif species ==  "Gengar" then
        return 0
    elseif species ==  "Onix" then
        return 0
    elseif species ==  "Drowzee" then
        return 0
    elseif species ==  "Hypno" then
        return 0
    elseif species ==  "Krabby" then
        return 0
    elseif species ==  "Kingler" then
        return 0
    elseif species ==  "Voltorb" then
        return 0
    elseif species ==  "Electrode" then
        return 0
    elseif species ==  "Exeggcute" then
        return 0
    elseif species ==  "Exeggutor" then
        return 0
    elseif species ==  "Cubone" then
        return 0
    elseif species ==  "Marowak" then
        return 0
    elseif species ==  "Hitmonlee" then
        return 0
    elseif species ==  "Hitmonchan" then
        return 0
    elseif species ==  "Lickitung" then
        return 0
    elseif species ==  "Koffing" then
        return 0
    elseif species ==  "Weezing" then
        return 0
    elseif species ==  "Rhyhorn" then
        return 0
    elseif species ==  "Rhydon" then
        return 0
    elseif species ==  "Chansey" then
        return 0
    elseif species ==  "Tangela" then
        return 0
    elseif species ==  "Kangaskhan" then
        return 0
    elseif species ==  "Horsea" then
        return 0
    elseif species ==  "Seadra" then
        return 0
    elseif species ==  "Goldeen" then
        return 0
    elseif species ==  "Seaking" then
        return 0
    elseif species ==  "Staryu" then
        return 0
    elseif species ==  "Starmie" then
        return 0
    elseif species ==  "Mr. Mime" then
        return 0
    elseif species ==  "Scyther" then
        return 0
    elseif species ==  "Jynx" then
        return 0
    elseif species ==  "Electabuzz" then
        return 0
    elseif species ==  "Magmar" then
        return 0
    elseif species ==  "Pinsir" then
        return 0
    elseif species ==  "Tauros" then
        return 0
    elseif species ==  "Magikrap" then
        return 0
    elseif species ==  "Gyarados" then
        return 0
    elseif species ==  "Lapras" then
        return 0
    elseif species ==  "Ditto" then
        return 0
    elseif species ==  "Eevee" then
        return 0
    elseif species ==  "Vaporeon" then
        return 0
    elseif species ==  "Jolteon" then
        return 0
    elseif species ==  "Flareon" then
        return 0
    elseif species ==  "Porygon" then
        return 0
    elseif species ==  "Omanyte" then
        return 0
    elseif species ==  "Omastar" then
        return 0
    elseif species ==  "Kabuto" then
        return 0
    elseif species ==  "Kabutops" then
        return 0
    elseif species ==  "Aerodactyl" then
        return 0
    elseif species ==  "Snorlax" then
        return 0
    elseif species ==  "Articuno" then
        return 0
    elseif species ==  "Zapdos" then
        return 0
    elseif species ==  "Moltres" then
        return 0
    elseif species ==  "Dratini" then
        return 0
    elseif species ==  "Dragonair" then
        return 0
    elseif species ==  "Dragonite" then
        return 0
    elseif species ==  "Mewtwo" then
        return 0
    elseif species ==  "Mew" then
        return 0
    elseif species ==  "Chikorita" then
        return 0
    elseif species ==  "Bayleef" then
        return 0
    elseif species ==  "Meganium" then
        return 0
    elseif species ==  "Cyndaquil" then
        return 0
    elseif species ==  "Quilava" then
        return 0
    elseif species ==  "Typhlosion" then
        return 0
    elseif species ==  "Totodile" then
        return 0
    elseif species ==  "Croconaw" then
        return 0
    elseif species ==  "Feraligatr" then
        return 0
    elseif species ==  "Sentret" then
        return 0
    elseif species ==  "Furret" then
        return 0
    elseif species ==  "Hoothoot" then
        return 0
    elseif species ==  "Noctowl" then
        return 0
    elseif species ==  "Ledyba" then
        return 0
    elseif species ==  "Ledian" then
        return 0
    elseif species ==  "Spinarak" then
        return 0
    elseif species ==  "Ariados" then
        return 0
    elseif species ==  "Crobat" then
        return 0
    elseif species ==  "Chinchou" then
        return 0
    elseif species ==  "Lanturn" then
        return 0
    elseif species ==  "Pichu" then
        return 0
    elseif species ==  "Cleffa" then
        return 0
    elseif species ==  "Igglybuff" then
        return 0
    elseif species ==  "Togepi" then
        return 0
    elseif species ==  "Togetic" then
        return 0
    elseif species ==  "Natu" then
        return 0
    elseif species ==  "Xatu" then
        return 0
    elseif species ==  "Mareep" then
        return 0
    elseif species ==  "Flaaffy" then
        return 0
    elseif species ==  "Ampharos" then
        return 0
    elseif species ==  "Bellossom" then
        return 0
    elseif species ==  "Marill" then
        return 0
    elseif species ==  "Azumarill" then
        return 0
    elseif species ==  "Sudowoodo" then
        return 0
    elseif species ==  "Politoed" then
        return 0
    elseif species ==  "Hoppip" then
        return 0
    elseif species ==  "Skiploom" then
        return 0
    elseif species ==  "Jumpluff" then
        return 0
    elseif species ==  "Aipom" then
        return 0
    elseif species ==  "Sunkern" then
        return 0
    elseif species ==  "Sunflora" then
        return 0
    elseif species ==  "Yanma" then
        return 0
    elseif species ==  "Wooper" then
        return 0
    elseif species ==  "Quagsire" then
        return 0
    elseif species ==  "Espeon" then
        return 0
    elseif species ==  "Umbreon" then
        return 0
    elseif species ==  "Murkrow" then
        return 0
    elseif species ==  "Slowking" then
        return 0
    elseif species ==  "Misdreavus" then
        return 0
    elseif species ==  "Unown" then
        return 0
    elseif species ==  "Wobbuffet" then
        return 0
    elseif species ==  "Girafarig" then
        return 0
    elseif species ==  "Pineco" then
        return 0
    elseif species ==  "Forretress" then
        return 0
    elseif species ==  "Dunsparce" then
        return 0
    elseif species ==  "Gligar" then
        return 0
    elseif species ==  "Steelix" then
        return 0
    elseif species ==  "Snubbull" then
        return 0
    elseif species ==  "Granbull" then
        return 0
    elseif species ==  "Qwilfish" then
        return 0
    elseif species ==  "Scizor" then
        return 0
    elseif species ==  "Shuckle" then
        return 0
    elseif species ==  "Heracross" then
        return 0
    elseif species ==  "Sneasel" then
        return 0
    elseif species ==  "Teddiursa" then
        return 0
    elseif species ==  "Ursaring" then
        return 0
    elseif species ==  "Slugma" then
        return 0
    elseif species ==  "Magcargo" then
        return 0
    elseif species ==  "Swinub" then
        return 0
    elseif species ==  "Piloswine" then
        return 0
    elseif species ==  "Corsola" then
        return 0
    elseif species ==  "Remoraid" then
        return 0
    elseif species ==  "Octillery" then
        return 0
    elseif species ==  "Delibird" then
        return 0
    elseif species ==  "Mantine" then
        return 0
    elseif species ==  "Skarmory" then
        return 0
    elseif species ==  "Houndour" then
        return 0
    elseif species ==  "Houndoom" then
        return 0
    elseif species ==  "Kingdra" then
        return 0
    elseif species ==  "Phanpy" then
        return 0
    elseif species ==  "Donphan" then
        return 0
    elseif species ==  "Porygon2" then
        return 0
    elseif species ==  "Stantler" then
        return 0
    elseif species ==  "Smeargle" then
        return 0
    elseif species ==  "Tyrogue" then
        return 0
    elseif species ==  "Hitmontop" then
        return 0
    elseif species ==  "Smoochum" then
        return 0
    elseif species ==  "Elekid" then
        return 0
    elseif species ==  "Magby" then
        return 0
    elseif species ==  "Miltank" then
        return 0
    elseif species ==  "Blissey" then
        return 0
    elseif species ==  "Raikou" then
        return 0
    elseif species ==  "Entei" then
        return 0
    elseif species ==  "Suicune" then
        return 0
    elseif species ==  "Larvitar" then
        return 0
    elseif species ==  "Pupitar" then
        return 0
    elseif species ==  "Tyranitar" then
        return 0
    elseif species ==  "Lugia" then
        return 0
    elseif species ==  "Ho-oh" then
        return 0
    elseif species ==  "Celebi" then
        return 0]]
    else
        return 0
    end
end
