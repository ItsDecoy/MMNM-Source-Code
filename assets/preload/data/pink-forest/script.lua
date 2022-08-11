local i = 0
local getReal = false

function onCreatePost()
	setProperty('iconP1.visible', false);
	setProperty('iconP2.visible', false);
	setProperty('healthBar.visible', false);
	setProperty('healthBarBG.visible', false);
	setProperty('scoreTxt.visible', false);
	
	triggerEvent('Camera Fade', '0', '0')
	triggerEvent('HUD Fade', '0', '0')
	
	makeLuaSprite('love','Coronation/love', 360, 400);
	addLuaSprite('love', false);
	scaleObject('love',0.3,0.3)
    setObjectCamera('love','other')
	
	makeLuaSprite('red','Coronation/red', 360, 400);
	addLuaSprite('red', false);
	scaleObject('red',0.3,0.3)
    setObjectCamera('red','other')
	
	setProperty('dad.visible',false);
end

function onSongStart()
	-- Putting this outside onCreatePost just in case
	for i = 0,3 do
		setPropertyFromGroup('opponentStrums', i, 'visible', false);
	end
end

function onUpdate(elapsed)
	i = i + elapsed
	setProperty('dad.y', (math.sin(i * 1.2)*80) + 320)
	
	if curStep >= 320 and not getReal then
		if not hideHud then
			setProperty('iconP1.visible', true);
			setProperty('iconP2.visible', true);
			setProperty('healthBar.visible', true);
			setProperty('healthBarBG.visible', true);
			setProperty('scoreTxt.visible', true);
			setProperty('opponentStrums.visible', true);
			for i = 0,3 do
				setPropertyFromGroup('opponentStrums', i, 'visible', true);
			end
		end
		setProperty('dad.visible',true);
		getReal = true
	end
end

function onStepHit()
	-- She loves...
	if curStep == 292 then
		doTweenY('lovey', 'love', 0, 0.5, 'sineOut')
	end
	
	-- RED.
	if curStep == 308 then
		doTweenY('redy', 'red', 0, 0.9, 'sineOut')
	end
	
	-- Text goes away (also Peach is visible now)
	if curStep == 320 then
		doTweenY('redy', 'red', 400, 0.9, 'sineOut')
		doTweenY('lovey', 'love', 400, 0.9, 'sineOut')
	end
end