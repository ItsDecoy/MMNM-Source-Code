local switched = false
local allowCountdown = false

camX = 500
camY = 300
camX2 = 670
camY2 = 270

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		allowCountdown = true;
		runTimer('start', 2.5)
		runTimer('smashRevealMoment', 1.2)
		setProperty('inCutscene', true)
		
		-- Grand Dad shadow mode
		setProperty('dad.color', getColorFromHex('000000'))
		
		-- Camera shit
		triggerEvent('Camera Follow Pos', camX, camY)
		setProperty('camFollowPos.x', camX)
		setProperty('camFollowPos.y', camY)
		setProperty('camGame.zoom', 0.8)
		doTweenZoom('camGameZoom', 'camGame', 0.9, 1.5, 'cubeOut')
		setProperty('camHUD.visible', false)
		
		return Function_Stop;
	end
	return Function_Continue;
end

function onCreatePost()
	if isStoryMode and not seenCutscene then
		-- Background Dudes are gone
		local g = 700
		setProperty('Shoop.x', getProperty('Shoop.x') - g)
		setProperty('WeegeeSanic.x', getProperty('WeegeeSanic.x') - g)
		setProperty('Troll.x', getProperty('Troll.x') + g)
		setProperty('Nana.x', getProperty('Nana.x') + g)
		setProperty('Nyan.x', getProperty('Nyan.x') + g)
		setProperty('Varg.x', getProperty('Varg.x') - g)
		
		makeLuaSprite('blackbg', nil, -1000, -1000)
		makeGraphic('blackbg', 3000, 3000, '000000')
		addLuaSprite('blackbg', false)
		setProperty('blackbg.alpha', 0)
		
		makeLuaSprite('GRAND', 'misc/granddad/GRAND', 670, 130)
		scaleObject('GRAND', 7, 7)
		setProperty('GRAND.antialiasing', false)
		addLuaSprite('GRAND', true)
		
		makeLuaSprite('DAD', 'misc/granddad/DAD', 780, 250)
		scaleObject('DAD', 7, 7)
		setProperty('DAD.antialiasing', false)
		addLuaSprite('DAD', true)
		
		setObjectOrder('blackbg', getObjectOrder('dadGroup')-1)
		setObjectOrder('GRAND', getObjectOrder('dadGroup'))
		setObjectOrder('DAD', getObjectOrder('dadGroup'))
		
		setProperty('GRAND.x', getProperty('GRAND.x') + 800)
		setProperty('DAD.x', getProperty('DAD.x') + 800)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'smashRevealMoment' then
		doTweenZoom('camGameZoom', 'camGame', 1.1, 0.6, 'elasticOut')
		doTweenX('camFollowPosX', 'camFollowPos', camX2, 0.6, 'elasticOut')
		doTweenY('camFollowPosY', 'camFollowPos', camY2, 0.6, 'elasticOut')
		doTweenColor('dadColorTw', 'dad', 'ffffff', 0.1, 'sineIn')
		doTweenAlpha('bgColortw', 'blackbg', 0.5, 0.1, 'sineIn')
		triggerEvent('Camera Follow Pos', camX2, camY2)
		playSound('GRAND_DAD')
		
		doTweenX('GRANDTWEEN', 'GRAND', getProperty('GRAND.x') - 800, 0.2, 'sineIn')
		
		runTimer('DADTween', 0.5)
		runTimer('grandJump', 0.05)
	end
	if tag == 'grandJump' then
		characterPlayAnim('dad', 'singUP', true)
		setProperty('dad.holdTimer', -1)
	end
	if tag == 'DADTween' then
		doTweenX('DADTWEEN', 'DAD', getProperty('DAD.x') - 800, 0.2, 'sineIn')
	end
	if tag == 'start' then
		doTweenAlpha('bgColortw', 'blackbg', 0, 1, 'sineIn')
		doTweenY('GRANDTWEEN', 'GRAND', -2000, 1, 'sineIn')
		doTweenY('DADTWEEN', 'DAD', 2000, 1, 'sineIn')
		setProperty('skipCountdown', true)
		setProperty('camHUD.zoom', 5)
		setProperty('camHUD.visible', true)
		setProperty('camZooming', true)
		setProperty('inCutscene', false)
		triggerEvent('Camera Follow Pos', '', '')
		startCountdown()
	end
end

function onBeatHit()
	if curBeat % 2 == 0 then
		setProperty('iconP1.angle', 10)
		setProperty('iconP2.angle', -10)
	else
		setProperty('iconP1.angle', -10)
		setProperty('iconP2.angle', 10)
	end
	
	if curBeat == 65 and isStoryMode then
		local g = 700
		local timet = 0.45
		local ease = 'sineIn'
		doTweenX('Shoop', 'Shoop', getProperty('Shoop.x') + g, timet, ease)
		doTweenX('WeegeeSanic', 'WeegeeSanic', getProperty('WeegeeSanic.x') + g, timet, ease)
		doTweenX('Troll', 'Troll', getProperty('Troll.x') - g, timet, ease)
		doTweenX('Nana', 'Nana', getProperty('Nana.x') - g, timet, ease)
		doTweenX('Nyan', 'Nyan', getProperty('Nyan.x') - g, timet, ease)
		doTweenX('Varg', 'Varg', getProperty('Varg.x') + g, timet, ease)
	end
	
	if curBeat == 133 then
		cancelTween('camHUDangleTween')
		setProperty('camHUD.angle', 180)
		setProperty('camGame.angle', 180)
		switchStrums('opponentStrums', 180)
		switchStrums('playerStrums', 180)
		switched = true
	elseif curBeat == 141 then
		if switched then
			setProperty('camHUD.angle', 0)
			setProperty('camGame.angle', 0)
			switchStrums('opponentStrums', 0)
			switchStrums('playerStrums', 0)
		end
	end
	
	if (curBeat >= 66 and curBeat <= 95) or (curBeat >= 114 and curBeat <= 132) or (curBeat >= 214 and curBeat <= 249) then
		if curBeat % 2 == 0 then setProperty('camHUD.angle', -1.5)
		else setProperty('camHUD.angle', 1.5) end
		doTweenAngle('camHUDangleTween', 'camHUD', 0, crochet / 1000, 'expoIn')
	end
	
	if curBeat == 250 then 
		setProperty('Virus.visible', true);
	end

	if curBeat == 260 then
		setProperty('Virus.visible', false);
	end
	
end

function switchStrums(strums, angle)
	for i = 0, 1 do
		local oldX1 = getPropertyFromGroup(strums, 3 - i, 'x')
		setPropertyFromGroup(strums, 3 - i, 'x', getPropertyFromGroup(strums, i, 'x'))
		setPropertyFromGroup(strums, i, 'x', oldX1)
		setPropertyFromGroup(strums, i, 'angle', angle)
		setPropertyFromGroup(strums, 3 - i, 'angle', angle)
	end
end