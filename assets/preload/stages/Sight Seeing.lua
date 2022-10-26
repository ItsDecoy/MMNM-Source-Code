function onCreate()
	local folder = 'stages/daiseye/'

	for i=1,2 do
		fix = ''
		sfix = ''
		if i == 2 then
			fix = '_Evil'
			sfix = 'evil/'
		end
		
		makeLuaSprite('Sky'..fix, folder..sfix..'sky', -1050, -450);
		scaleObject('Sky'..fix,1.8,1.8);
		setScrollFactor('Sky'..fix,0.02,0.02);

		makeLuaSprite('Planetoid'..fix, folder..sfix..'planet', -500, -350);
		scaleObject('Planetoid'..fix,1.2,1.2);
		setScrollFactor('Planetoid'..fix,0.04,0.04);
		setBlendMode('Planetoid'..fix, 'lighten')
		
		makeLuaSprite('Cloud'..fix, folder..sfix..'clouds', -720, -450);
		scaleObject('Cloud'..fix,1.45,1.45);
		setScrollFactor('Cloud'..fix,0.3,0.3);

		makeLuaSprite('Platforms'..fix, folder..sfix..'platforms', -580, -250);
		scaleObject('Platforms'..fix, 1.25,1.25);
		
		addLuaSprite('Sky'..fix, false);
		addLuaSprite('Planetoid'..fix, false);
		
		if i == 2 then -- Makes the eye sprite
			makeLuaSprite('Eye', folder..sfix..'eye', getProperty('Planetoid.x'), getProperty('Planetoid.y'));
			scaleObject('Eye', getProperty('Planetoid.scale.x'), getProperty('Planetoid.scale.y'));
			addLuaSprite('Eye',false);
			setScrollFactor('Eye',0.04,0.04);
			
			setProperty('Eye.visible',false);
		end

		if i == 2 then --Makes the eyeball
			makeAnimatedLuaSprite('Ball', folder..sfix..'eyeea', 550, 50);
		
			addAnimationByPrefix('Ball','stare','sxasxAZ', 24, true);
			addLuaSprite('Ball',false);
			setScrollFactor('Ball', 0.03, 0.03);

			setProperty('Ball.visible',false);
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
			setProperty('Ball.visible', isGood);
		end
	end
end