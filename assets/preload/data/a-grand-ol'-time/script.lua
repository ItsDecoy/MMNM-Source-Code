local switched = false

function onBeatHit()
	if curBeat % 2 == 0 then
		setProperty('iconP1.angle', 10)
		setProperty('iconP2.angle', -10)
	else
		setProperty('iconP1.angle', -10)
		setProperty('iconP2.angle', 10)
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
	
	if curBeat == 254 then 
	setProperty('Virus.visible', true);
	
	end

	if curBeat == 264 then
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