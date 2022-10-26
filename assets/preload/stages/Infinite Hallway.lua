local dadScaleX = 1
local dadScaleY = 1

function onCreate()
	local location = 'stages/hallway/'
	
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
--Middle Scroll Code
	noteTweenX('goodybearrow1', 0, -200, 0.01, 'linear')
        noteTweenX('goodybearrow2', 1, -200, 0.01, 'linear')
        noteTweenX('goodybearrow3', 2, -200, 0.01, 'linear')
        noteTweenX('goodybearrow4', 3, -200, 0.01, 'linear')
--Middle
	noteTweenX('Moved1', 4, 414, 0.01, 'linear')
        noteTweenX('Moved2', 5, 527, 0.01, 'linear')
        noteTweenX('Moved3', 6, 637, 0.01, 'linear')
        noteTweenX('Moved4', 7, 750, 0.01, 'linear')
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