function onCreate()
	local folder = 'daiseye/'

	makeLuaSprite('Sky', folder..'daiseyebgsky', -1050, -385);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);
	setScrollFactor('Sky',0.05,0.05);

	makeLuaSprite('Planetoid', folder..'daiseyebgplanert', -340, -250);
	addLuaSprite('Planetoid', false);
	setScrollFactor('Planetoid',0.1,0.1);
	setBlendMode('Planetoid', 'lighten')
	
	makeLuaSprite('Cloud', folder..'daiseyebgclouds', -700, -450);
	addLuaSprite('Cloud', false);	
	scaleObject('Cloud',1.4,1.4);
	setScrollFactor('Cloud',0.3,0.3);

	makeLuaSprite('Platforms', folder..'daiseyebgplatforms', -450, -150);
	addLuaSprite('Platforms', false);
	scaleObject('Platforms', 1.1,1.1);
	
	-- Evilness

	makeLuaSprite('Sky_Evil', folder..'daiseyebg2sky', -1050, -385);
	addLuaSprite('Sky_Evil', false);
	scaleObject('Sky_Evil',1.8,1.8);
	setScrollFactor('Sky_Evil',0.05,0.05);
	
	makeLuaSprite('Planetoid_Evil', folder..'daiseyebg2plnaert', -340, -250);
	addLuaSprite('Planetoid_Evil', false);
	setScrollFactor('Planetoid_Evil',0.1,0.1);
	setBlendMode('Planetoid_Evil', 'lighten')

	makeLuaSprite('Eye', folder..'daiseyebg2eye', -340, -250);
	addLuaSprite('Eye',false);
	setScrollFactor('Eye',0.12,0.12);
	
	makeLuaSprite('Cloud_Evil', folder..'daiseyebg2clouds', -700, -450);
	addLuaSprite('Cloud_Evil', false);	
	scaleObject('Cloud_Evil',1.4,1.4);
	setScrollFactor('Cloud_Evil',0.3,0.3);

	makeLuaSprite('Platforms_Evil', folder..'daiseyebg2platforms', -450, -150);
	addLuaSprite('Platforms_Evil', false);
	scaleObject('Platforms_Evil', 1.1,1.1);

	setProperty('Sky_Evil.visible',false);
	setProperty('Cloud_Evil.visible',false);
	setProperty('Planetoid_Evil.visible',false);
	setProperty('Platforms_Evil.visible',false);
	setProperty('Eye.visible',false);
end

function onEvent(name, value1, value2)
	if name == 'Stage Switch' then
		local isEvil = tonumber(value1) > 0
		
		setProperty('Sky.visible', not isEvil);
		setProperty('Cloud.visible', not isEvil);
		setProperty('Planetoid.visible', not isEvil);
		setProperty('Platforms.visible', not isEvil);
		
		setProperty('Sky_Evil.visible',isEvil);
		setProperty('Cloud_Evil.visible',isEvil);
		setProperty('Planetoid_Evil.visible',isEvil);
		setProperty('Platforms_Evil.visible',isEvil);
		setProperty('Eye.visible',isEvil);
	end
end