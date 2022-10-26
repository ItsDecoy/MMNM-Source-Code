function onCreate()
	local folder = 'stages/coronation/'
	
	makeLuaSprite('Sky', folder..'coronation_bg_sky', -650, -325);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);

	makeLuaSprite('Mist1', folder..'coronation_bg_mist1', -250, 0);
	addLuaSprite('Mist1', true);	
	scaleObject('Mist1',1.7,1.7)
	setScrollFactor('Mist1',1.2,1.2);

	makeLuaSprite('Hill2', folder..'coronation_bg_hills2', -510, 200);
	addLuaSprite('Hill2', false);
	scaleObject('Hill2',1.4,1.4);
	setScrollFactor('Hill2',0.5,0.5);

	makeLuaSprite('Hill1', folder..'coronation_bg_hills1', 0, 350);
	addLuaSprite('Hill1', false);
	scaleObject('Hill1',1.4,1.4)
	setScrollFactor('Hill1',0.6,0.6);

	makeLuaSprite('aqua', folder..'coronation_bg_water', -300, 150);
	addLuaSprite('aqua', false);
	scaleObject('aqua',1.6,1.6)
	setScrollFactor('aqua',0.9,0.9);

	makeLuaSprite('Mist2SonOfMist', folder..'coronation_bg_mist2', 200, 700);
	addLuaSprite('Mist2SonOfMist', false);
	scaleObject('Mist2SonOfMist',1.7,1.7)
	setScrollFactor('Mist2SonOfMist',0.9,0.9);
	
	makeLuaSprite('Trees', folder..'coronation_bg_trees', -430, -100);
	addLuaSprite('Trees', false);
	scaleObject('Trees',1.50,1.50)
	setScrollFactor('Trees',0.7,0.7);
	
	makeLuaSprite('Floor', folder..'coronation_bg_bridge', -425, 150);
	addLuaSprite('Floor', false);
	scaleObject('Floor',1.55,1.55)

	makeAnimatedLuaSprite('Mario', folder..'sad_plumber',100,850)
    addAnimationByPrefix('Mario','Sad Mario Dance','SadMario_Idle',24,false);
	addLuaSprite('Mario',false);
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('Mario', 'Sad Mario Dance', true);
	end
end