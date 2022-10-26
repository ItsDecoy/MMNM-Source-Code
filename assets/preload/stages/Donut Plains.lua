function onCreate()
	local location = 'stages/victim/'
	
	makeLuaSprite('Whole-Ah Castle', location..'mariobg', -550, -400);
	addLuaSprite('Whole-Ah Castle', false);
	scaleObject('Whole-Ah Castle', 0.7, 0.7);

	makeLuaSprite('Whole-Ah Castle2', location..'victimbg', -550, -400);
	addLuaSprite('Whole-Ah Castle2', false);
	scaleObject('Whole-Ah Castle2', 0.7, 0.7);
	
	setProperty('Whole-Ah Castle2.visible',false);
end

function onEvent(name, value1, value2)
	if name == 'Stage Phase' then
		local isEvil = tonumber(value1) > 0
		
		setProperty('Whole-Ah Castle.visible', not isEvil);
		setProperty('Whole-Ah Castle2.visible',isEvil);
	end
end