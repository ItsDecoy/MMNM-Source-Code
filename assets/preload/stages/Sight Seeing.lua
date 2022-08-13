function onCreate()
	local folder = 'daiseye/'

	for i=1,2 do
		fix = ''
		sfix = ''
		if i == 2 then
			fix = '_Evil'
			sfix = 'evil/'
		end
		
		makeLuaSprite('Sky'..fix, folder..sfix..'sky', -1050, -385);
		scaleObject('Sky'..fix,1.8,1.8);
		setScrollFactor('Sky'..fix,0.02,0.02);

		makeLuaSprite('Planetoid'..fix, folder..sfix..'planet', -340, -250);
		setScrollFactor('Planetoid'..fix,0.05,0.05);
		setBlendMode('Planetoid'..fix, 'lighten')
		
		makeLuaSprite('Cloud'..fix, folder..sfix..'clouds', -700, -450);
		scaleObject('Cloud'..fix,1.4,1.4);
		setScrollFactor('Cloud'..fix,0.3,0.3);

		makeLuaSprite('Platforms'..fix, folder..sfix..'platforms', -450, -150);
		scaleObject('Platforms'..fix, 1.1,1.1);
		
		addLuaSprite('Sky'..fix, false);
		addLuaSprite('Planetoid'..fix, false);
		
		if i == 2 then -- Makes the eye sprite
			makeLuaSprite('Eye', folder..sfix..'eye', -340, -250);
			addLuaSprite('Eye',false);
			setScrollFactor('Eye',0.05,0.05);
			
			setProperty('Eye.visible',false);
		end
		
		addLuaSprite('Cloud'..fix, false);	
		addLuaSprite('Platforms'..fix, false);
		
		setProperty('Sky'..fix..'.visible', i == 1);
		setProperty('Planetoid'..fix..'.visible', i == 1);
		setProperty('Cloud'..fix..'.visible', i == 1);
		setProperty('Platforms'..fix..'.visible', i == 1);
	end
end

function onEvent(name, value1, value2)
	if name == 'Stage Phase' then
		for i=1,2 do
			fix = ''
			isGood = tonumber(value1) < 1
			if i == 2 then
				fix = '_Evil'
				isGood = not isGood
			end
			
			setProperty('Sky'..fix..'.visible', isGood);
			setProperty('Cloud'..fix..'.visible', isGood);
			setProperty('Planetoid'..fix..'.visible', isGood);
			setProperty('Platforms'..fix..'.visible', isGood);
			setProperty('Eye.visible', isGood);
		end
	end
end