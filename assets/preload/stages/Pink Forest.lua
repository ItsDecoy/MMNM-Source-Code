function onCreate()

	makeLuaSprite('Sky','stageassets/coronation_bg_sky', -650, -325);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);

	makeLuaSprite('Mist1','stageassets/coronation_bg_mist1', -300, -150);
	addLuaSprite('Mist1', true);	
	scaleObject('Mist1',1.7,1.7)
	


	makeLuaSprite('Hill2','stageassets/coronation_bg_hills2', -510, 200);
	addLuaSprite('Hill2', false);
	scaleObject('Hill2',2,2);
	setScrollFactor('Hil2',0.8,0.8);

	makeLuaSprite('Hill1','stageassets/coronation_bg_hills1', 550, 350);
	addLuaSprite('Hill1', false);
	scaleObject('Hills1',2,2)
	setScrollFactor('Hil2',0.85,0.85);
	

	makeLuaSprite('aqua','stageassets/coronation_bg_water', -300, 150);
	addLuaSprite('aqua', false);
	scaleObject('aqua',1.6,1.6)

	makeLuaSprite('Mist2SonOfMist','stageassets/coronation_bg_mist2', 200, 700);
	addLuaSprite('Mist2SonOfMist', false);
	scaleObject('Mist2',1.7,1.7)
	
	makeLuaSprite('Trees','stageassets/coronation_bg_trees', -425, -5);
	addLuaSprite('Trees', false);
	scaleObject('Trees',1.55,1.55)
	setScrollFactor('Trees',0.96,0.96);
	
	
	
	makeLuaSprite('Floor','stageassets/coronation_bg_bridge', -425, 150);
	addLuaSprite('Floor', false);
	scaleObject('Floor',1.55,1.55)

	makeAnimatedLuaSprite('Mario','stageassets/sad_plumber',100,850)
      addAnimationByPrefix('Mario','Sad Mario Dance','SadMario_Idle',24,true);
	addLuaSprite('Mario',false);
	


	close(true)


end