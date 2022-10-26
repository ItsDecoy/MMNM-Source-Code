local i = 0
function onCreatePost()
	triggerEvent('Camera Fade', '0', '0')
	triggerEvent('HUD Fade', '0', '0')
	
	makeLuaSprite('God', 'misc/coronation/God', 240, 200);
	addLuaSprite('God', true);
    setObjectCamera('God','other')
	scaleObject('God',0.7,0.7);
	setProperty('God.alpha', 0)

	makeLuaSprite('are', 'misc/coronation/are', 240, 200);
	addLuaSprite('are', true);
    setObjectCamera('are','other')
	scaleObject('are',0.7,0.7);
	setProperty('are.alpha', 0)

	makeLuaSprite('Iam', 'misc/coronation/Iam', 240, 200);
	addLuaSprite('Iam', true);
    setObjectCamera('Iam','other')
	scaleObject('Iam',0.7,0.7);
	setProperty('Iam.alpha', 0)

	makeAnimatedLuaSprite('Glitch', 'misc/coronation/glitch', 820, 400);
	addAnimationByPrefix('Glitch', 'text', 'glitch', 24, true )
	addLuaSprite('Glitch', true);
    setObjectCamera('Glitch','other')
	scaleObject('Glitch',1.7 ,1.7);
	setProperty('Glitch.alpha', 0)
	setProperty('Glitch.antialiasing', false)
end

function onUpdate(elapsed)
	i = i + elapsed
	setProperty('dad.y', (math.sin(i * 1.2)*80) + 320)
end

function onStepHit()
	if curStep == 1375 then
	doTweenAlpha('God', 'God', 1, 1, linear);
	end	
	if curStep == 1406 then
		doTweenAlpha('God', 'God', 0, 0.5, linear);
	end
	if curStep == 1424 then
	doTweenAlpha('are', 'are', 1, 0.5, linear);
	end
	if curStep == 1438 then
	doTweenAlpha('are', 'are', 0, 0.5, linear);
	end
	if curStep == 1451 then
		
		doTweenAlpha('Iam', 'Iam', 1, 0.5, linear);
		doTweenAlpha('Glitch', 'Glitch', 1, 0.5, linear);
end
	if curStep == 1488 then
		
		setProperty('Iam.visible', false);
		setProperty('Glitch.visible', false);
end
end