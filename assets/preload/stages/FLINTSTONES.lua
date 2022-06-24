function onCreate()

	makeLuaSprite('Sky','stageassets/Grand_Dad_BG1_2', -650, -325);
		addLuaSprite('Sky', false);
		scaleObject('Sky',1.8,1.8);

	makeLuaSprite('GRAND','stageassets/Grand_Dad_BG1_1', -200, 250);
		addLuaSprite('GRAND', true);
		scaleObject('GRAND',0.6,0.6)

	

	close(true)

end