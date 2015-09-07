require("AnAL")
require("pokestats-conf")
require("pokestats_include")

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
imgGender = {}
    imgGender.male = love.graphics.newImage('status/GENDERMALE.gif')
    imgGender.female = love.graphics.newImage('status/GENDERFEMALE.gif')
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
pokemonGender = {}
pokemonEXPGroup = {}
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
                    pokemonEXPGroup[I] = expGroup[pokemon[I]]
                    pokemonEXPDif[I] = expNeeded(pokemonLevel[I], pokemonEXPGroup[I])
                    pokemonCurEXP[I] = pokemonCurEXP[I] - pokemonEXPDif[I]
                    pokemonMaxEXP[I] = (expNeeded((pokemonLevel[I] + 1), pokemonEXPGroup[I])) - pokemonEXPDif[I]
                    pokemonGender[I] = fileReader[57+(1*I)]
                else
                    pokemonNickname[I] = ""
                    pokemonHP[I] = 0
                    pokemonHPMax[I] = 0
                    pokemonLevel[I] = 0
                    pokemonStatus[I] = 0
                    pokemonPKRS[I] = 0
                    pokemonItem[I] = 0
                    pokemonCurEXP[I] = 0
                    pokemonEXPDif[I] = 0
                    pokemonMaxEXP[I] = 0
                    pokemonGender[I] = 0
                    pokemonEXPGroup[I] = 0
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
            if pokemon[I] ~= nil and pokemon[I] ~= "None" and pokemon[I] ~= "0" then
                drawPokemon(I)
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
			
			drawStatus(I * shifter + 72, 32, pokemonStatus[I], pokemonHP[I], pokemonPKRS[I])			
            
            --if pokemonPKRS[I] ~= nil and pokemonPKRS[I] ~= "0" then
            --    love.graphics.draw(imgStatus.PKRS, 92+(I*shifter), 30)
            --end
            
            if pokemonItem[I] ~= nil and pokemonItem[I] ~= "0" then
                love.graphics.draw(imgStatus.ITEM, 113+(I*shifter), 18)
                --love.graphics.print(pokemonItem[I], 80+(I*shifter), 45)
            end
            
            if tonumber(pokemonGender[I]) == 1 then
                love.graphics.draw(imgGender.male, 60+(I*shifter), 50)
            elseif tonumber(pokemonGender[I]) == 2 then
                love.graphics.draw(imgGender.female, 60+(I*shifter), 50)
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
            expQuads[I] = love.graphics.newQuad(0, 0, map(pokemonCurEXP[I], 0, pokemonMaxEXP[I], 0, 48), 4, imgEXPBarFrame:getDimensions())
            love.graphics.draw(imgEXPBarBlue, expQuads[I], 16+(I*shifter), 71)
            love.graphics.draw(imgEXPBarFrame, 0+(I*shifter), 70)
end

function drawStatus(x,y,statusFlagsIn,HP,hasPKRS)
	-- this function could be made much more compact by simply performing the drawings conditional to the checks.
	local isFNT, isPSN, isPKRS, isSLP, isBRN, isPAR, isFRZ = false,false,false,false,false,false,false
	local statusFlags = tonumber(statusFlagsIn)
	if tonumber(HP) == 0 then isFNT = true end
	if tonumber(hasPKRS) ~= 0 then isPKRS = true end
	if bit.band(0x07,statusFlags) ~= 0 then isSLP = true end
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
    --Slow, Medium Slow, Medium Fast, Fast, Erratic, Fluctuating
    if tonumber(expGroup) == 1 then
        return ((5 * (tonumber(curLevel) ^ 3)) / 4)
    elseif tonumber(expGroup) == 2 then
        return (1.2 * (tonumber(curLevel) ^ 3)) - (15 * (tonumber(curLevel) ^ 2)) + (100 * tonumber(curLevel)) - 140
    elseif tonumber(expGroup) == 3 then
        return (tonumber(curLevel) ^ 3)
    elseif tonumber(expGroup) == 4 then
        return ((4 * (tonumber(curLevel) ^ 3)) / 5)
    elseif tonumber(expGroup) == 5 then
        if tonumber(curLevel) < 50 then
            return (((tonumber(curLevel)^3)*(100-tonumber(curLevel)))/50)
        elseif tonumber(curLevel) < 68 then
            return (((tonumber(curLevel)^3)*(150-tonumber(curLevel)))/100)
        elseif tonumber(curLevel) < 98 then
            return (((tonumber(curLevel)^3)*((1911-10-tonumber(curLevel))/3))/500)
        else
            return (((tonumber(curLevel)^3)*(160-tonumber(curLevel)))/100)
        end
    elseif tonumber(expGroup) == 6 then
        if tonumber(curLevel) < 15 then
            return ((tonumber(curLevel)^3)*((((tonumber(curLevel)+1)/3)+24)/50))
        elseif tonumber(curLevel) < 36 then
            return ((tonumber(curLevel) ^ 3)*((tonumber(curLevel)+14)/50))
        else
            return ((tonumber(curLevel)^3)*(((tonumber(curLevel)/2)+32)/50))
        end
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
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function getFrames(species)
    return frameCount[species]
end
