local dadScaleX = 1
local dadScaleY = 1

function onCreate()
	local location = ''
	
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

function onUpdate()
	triggerEvent('Camera Follow Pos', 520, 780)
	
	local dist = 1 - getProperty('health')
	setProperty('dad.scale.x', dadScaleX + (dist))
	setProperty('dad.scale.y', dadScaleY + (dist))
	
	--[[
	if keyPressed('space') then
		if keyPressed('up') then
			setProperty('health', getProperty('health') + 0.005)
		end
		if keyPressed('down') then
			setProperty('health', getProperty('health') - 0.005)
		end
	end]]--
end