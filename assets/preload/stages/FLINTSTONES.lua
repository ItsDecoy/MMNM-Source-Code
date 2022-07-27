function onCreate()

	makeLuaSprite('Sky','grandDad/Grand_Dad_BG2_7', -250, -225);
		addLuaSprite('Sky', false);
		scaleObject('Sky',0.6,0.6);
		setScrollFactor('Sky',0.8,0.8);

	makeLuaSprite('Trees','grandDad/Grand_Dad_BG2_6', -210, -300);
		addLuaSprite('Trees', false);
		scaleObject('Trees',0.9,0.9);
		setScrollFactor('Trees',0.9,0.9);

	makeLuaSprite('Tree','grandDad/Grand_Dad_BG2_5', -210, -150);
		addLuaSprite('Tree', false);
		scaleObject('Tree',0.7,0.7);

	makeLuaSprite('Bushes','grandDad/Grand_Dad_BG2_4', 360, -120);
		addLuaSprite('Bushes', false);
		scaleObject('Bushes',0.6,0.6);
		setScrollFactor('Bushes',0.95,0.95);

	makeLuaSprite('House','grandDad/Grand_Dad_BG2_3', 350, -120);
		addLuaSprite('House', false);
		scaleObject('House',0.6,0.6);
		setScrollFactor('House',0.95,0.95);


	makeLuaSprite('Bushes2','grandDad/Grand_Dad_BG2_2', 350, -150);
		addLuaSprite('Bushes2', false);
		scaleObject('Bushes2',0.6,0.6);
		setScrollFactor('Bushes2',0.95,0.95);
	
	makeLuaSprite('Floor','grandDad/Grand_Dad_BG2_1', -325, -400);
		addLuaSprite('Floor', false);
		scaleObject('Floor',0.9,0.9);
	
	makeAnimatedLuaSprite('WEEGEE SANIC','grandDad/Sanic_and_Weegee_boppers',-220,50)
     		 addAnimationByPrefix('WEEGEE SANIC','WS Idle','sanic_weegee_boppers',24,true);
		 addLuaSprite('WEEGEE SANIC',false);
		scaleObject('WEEGEE SANIC',0.65,0.65);

	makeAnimatedLuaSprite('Troll','grandDad/Troll_Bopper',1300,180);
     		 addAnimationByPrefix('Troll','Troll Idle','troll_bopper',24,true);
		 addLuaSprite('Troll',false);
		 scaleObject('Troll',0.65,0.65);

	makeAnimatedLuaSprite('Nana','grandDad/Nana_Bopper',1500,200);
     		 addAnimationByPrefix('Nana','Nana Idle','nana_bopper',24,true);
		 addLuaSprite('Nana',false);
		 scaleObject('Nana',0.65,0.65);

	makeAnimatedLuaSprite('Nyan','grandDad/NyanCat_Bopper',1200,-150);
     		 addAnimationByPrefix('Nyan','Nyan Idle','NyanCat_bopper',24,true);
		 addLuaSprite('Nyan',false);
		 scaleObject('Nyan',0.65,0.65);

	makeAnimatedLuaSprite('Varg','grandDad/Vinesauce_Bopper',-150,-150);
     		 addAnimationByPrefix('Varg','Varg Idle','Vinesauce_Bopper',24,true);
		 addLuaSprite('Varg',false);
		 scaleObject('Varg',0.65,0.65);

	close(true)

end