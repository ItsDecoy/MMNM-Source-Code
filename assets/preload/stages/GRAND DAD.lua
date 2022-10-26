function onCreate()
	local folder = 'stages/granddad/'

	makeLuaSprite('Sky',folder..'Grand_Dad_BG1_2', -1450, -925);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);

	makeLuaSprite('GRAND','grandDad/Grand_Dad_BG1_1', -100, -300);
	addLuaSprite('GRAND', true);
	scaleObject('GRAND',0.6,0.6)

	makeAnimatedLuaSprite('WEEGEE SANIC',folder..'Sanic_and_Weegee_boppers',-520,260)
    addAnimationByPrefix('WEEGEE SANIC','WS Idle','sanic_weegee_boppers',24,true);
	addLuaSprite('WEEGEE SANIC',false);
	scaleObject('WEEGEE SANIC',0.65,0.65);

	makeAnimatedLuaSprite('Troll',folder..'Troll_Bopper',1300,380);
    addAnimationByPrefix('Troll','Troll Idle','troll_bopper',24,true);
	addLuaSprite('Troll',false);
	scaleObject('Troll',0.65,0.65);

	makeAnimatedLuaSprite('Nana',folder..'Nana_Bopper',1500,400);
    addAnimationByPrefix('Nana','Nana Idle','nana_bopper',24,true);
	addLuaSprite('Nana',false);
	scaleObject('Nana',0.65,0.65);

	makeAnimatedLuaSprite('Nyan',folder..'NyanCat_Bopper',1000,-50);
    addAnimationByPrefix('Nyan','Nyan Idle','NyanCat_bopper',24,true);
	addLuaSprite('Nyan',false);
	scaleObject('Nyan',0.65,0.65);
	
    makeAnimatedLuaSprite('Varg',folder..'Vinesauce_Bopper',-150,-150);
    addAnimationByPrefix('Varg','Varg Idle','Vinesauce_Bopper',24,true);
	addLuaSprite('Varg',false);
	scaleObject('Varg',0.65,0.65);

	close(true)
end