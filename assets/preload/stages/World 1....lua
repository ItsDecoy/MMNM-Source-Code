function onCreate()

	makeLuaSprite('Backdrop', 'stageassets/mxfalse_hero_bg_sky', -600, -300);	
		addLuaSprite('Backdrop',false);
	
	makeLuaSprite('Sir Strife','stageassets/Mr.Strife',350,300);
		addLuaSprite('Sir Strife',false)
		scaleObject('Sir Strife',0.8,0.8)
		setScrollFactor('Sir Strife',0.8,0.8)

	
	makeLuaSprite('Sir Strife1','stageassets/Mr.Strife',1250,500);
		addLuaSprite('Sir Strife1',false)
		scaleObject('Sir Strife1',0.8,0.8)
		setScrollFactor('Sir Strife1',0.8,0.8)

	
	makeLuaSprite('Sir Strife2','stageassets/Mr.Strife',-300,250);
		addLuaSprite('Sir Strife2',false)
		scaleObject('Sir Strife2',0.8,0.8)
		setScrollFactor('Sir Strife2',0.8,0.8)
	
		makeLuaSprite('Hills','stageassets/mxfalse_hero_bg_hills',-600,150);
		addLuaSprite('Hills',false);
		scaleObject('Hills',0.55,0.55);
		setScrollFactor('Hills',0.9,0.9)

		makeLuaSprite('Bushes','stageassets/mxfalse_hero_bg_bushes',-500,58);
		addLuaSprite('Bushes',false);	
		scaleObject('Bushes',0.6,0.6);
		setScrollFactor('Bushes',0.95,0.95);

	makeLuaSprite('Floor','stageassets/mxfalse_hero_bg_floor',-500,65);
		addLuaSprite('Floor',false);
		scaleObject('Floor',0.6,0.6);
		setScrollFactor('Floor',0.95,0.95)



	
	
	close(true);
end