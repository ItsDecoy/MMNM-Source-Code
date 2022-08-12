local dadScaleX = 1
local dadScaleY = 1

function onCreate()
	local location = 'hallway/'
	
	makeAnimatedLuaSprite('hall', location..'Hallway', -500, 180);
	addAnimationByPrefix('hall', 'idle', 'Hallway idle', 60, true)
	setScrollFactor('hall', 0.9, 0.9);
	objectPlayAnimation('hall', 'idle')
	scaleObject('hall', 1.6, 1.6)
	
	addLuaSprite('hall')
end

function onCreatePost()
	dadScaleX = getProperty('dad.scale.x')
	dadScaleY = getProperty('dad.scale.y')
	
	setObjectOrder('gfGroup', 5)
end

function onMoveCamera(focus)
	if focus == 'dad' then
		setProperty('defaultCamZoom', 0.85)
	else
		setProperty('defaultCamZoom', 0.7)
	end
end

function onUpdate()
	local dist = 1 - getProperty('health')
	setProperty('dad.scale.x', dadScaleX + (dist))
	setProperty('dad.scale.y', dadScaleY + (dist))
end