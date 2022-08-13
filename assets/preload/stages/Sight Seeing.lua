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

	makeLuaSprite('Sky2', folder..'daiseyebg2sky', -1050, -385);
	addLuaSprite('Sky2', false);
	scaleObject('Sky2',1.8,1.8);
	setScrollFactor('Sky2',0.05,0.05);
	
	makeLuaSprite('Planetoid2', folder..'daiseyebg2plnaert', -340, -250);
	addLuaSprite('Planetoid2', false);
	setScrollFactor('Planetoid2',0.1,0.1);
	setBlendMode('Planetoid2', 'lighten')

	makeLuaSprite('Eye', folder..'daiseyebg2eye', -340, -250);
	addLuaSprite('Eye',false);
	setScrollFactor('Eye',0.1,0.1);
	
	makeLuaSprite('Cloud2', folder..'daiseyebg2clouds', -700, -450);
	addLuaSprite('Cloud2', false);	
	scaleObject('Cloud2',1.4,1.4);
	setScrollFactor('Cloud2',0.3,0.3);

	makeLuaSprite('Platforms2', folder..'daiseyebg2platforms', -450, -150);
	addLuaSprite('Platforms2', false);
	scaleObject('Platforms2', 1.1,1.1);


	setProperty('Sky2.visible',false);
	setProperty('Cloud2.visible',false);
	setProperty('Planetoid2.visible',false);
	setProperty('Platforms2.visible',false);
	setProperty('Eye.visible',false);

	close(true)
end