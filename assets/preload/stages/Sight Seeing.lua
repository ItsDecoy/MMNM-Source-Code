function onCreate()

makeLuaSprite('Sky','daiseye/daiseyebgsky', -850, -325);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);

makeLuaSprite('Cloud','daiseye/daiseyebgclouds', -700, -450);
	addLuaSprite('Cloud', false);	
	scaleObject('Cloud',1.4,1.4);
	setScrollFactor('Cloud',0.8,0.8);

makeLuaSprite('Planetoid','daiseye/daiseyebgplanert', -350, -200);
	addLuaSprite('Planetoid', false);
	setScrollFactor('Planetoid',0.9,0.9);

makeLuaSprite('Platforms','daiseye/daiseyebgplatforms', -450, -150);
	addLuaSprite('Platforms', false);
	scaleObject('Platforms', 1.1,1.1);

makeLuaSprite('Sky2','daiseye/daiseyebg2sky', -850, -325);
	addLuaSprite('Sky2', false);
	scaleObject('Sky2',1.8,1.8);

makeLuaSprite('Cloud2','daiseye/daiseyebg2clouds', -700, -450);
	addLuaSprite('Cloud2', false);	
	scaleObject('Cloud2',1.4,1.4);
	setScrollFactor('Cloud2',0.95,0.95);

makeLuaSprite('Planetoid2','daiseye/daiseyebg2plnaert', -350, -200);
	addLuaSprite('Planetoid2', false);
	setScrollFactor('Planetoid2',0.9,0.9);

makeLuaSprite('Platforms2','daiseye/daiseyebg2platforms', -450, -150);
	addLuaSprite('Platforms2', false);
	scaleObject('Platforms2', 1.1,1.1);

makeLuaSprite('Eye','daiseye/daiseyebg2eye',-350,-200);
	addLuaSprite('Eye',false);
	setScrollFactor('Eye',0.9,0.9);

setProperty('Sky.visible',true);
setProperty('Sky2.visible',false);
setProperty('Cloud.visible',true);
setProperty('Cloud2.visible',false);
setProperty('Planetoid.visible',true);
setProperty('Planetoid2.visible',false);
setProperty('Platforms.visible',true);
setProperty('Platforms2.visible',false);
setProperty('Eye.visible',false);

	close(true)

end