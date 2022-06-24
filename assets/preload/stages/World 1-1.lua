function onCreate()

	makeLuaSprite('Backdrop', 'stageassets/mxbgmmnm_sky', -600, -300);	
		addLuaSprite('Backdrop',false);
	
	makeLuaSprite('Sir Strife','stageassets/Mr.Strife Alive',350,300);
		addAnimationByPrefix('Sir Strife','wiggle','Scary_Cloud',24,true);
		addLuaSprite('Sir Strife',false);
		scaleObject('Sir Strife',1.3,1.3);
		setScrollFactor('Sir Strife',0.8,0.8);
	
	makeAnimatedLuaSprite('Hills','stageassets/bushanim',-600,150);
		addAnimationByPrefix('Hills','Blink','blink',8,true);
		addLuaSprite('Hills',false);
		scaleObject('Hills',0.98,0.98);
		setScrollFactor('Hills',0.9,0.9);

	makeLuaSprite('Bushes','stageassets/mxbgmmnm_bushes',-500,58);
		addLuaSprite('Bushes',false);	
		scaleObject('Bushes',0.98,0.98);
		setScrollFactor('Bushes',0.95,0.95);

	makeLuaSprite('Floor','stageassets/mxbgmmnm_floor',-500,0);
		addLuaSprite('Floor',false);
		
		setScrollFactor('Floor',0.95,0.95);
	
	makeLuaSprite('DeadToadAlert','stageassets/mxbgmmnm_props',-900,-20);
		addLuaSprite('DeadToadAlert',false);
		scaleObject('DeadToadAlert',1.1,1.1);

	
	
	close(true);
end