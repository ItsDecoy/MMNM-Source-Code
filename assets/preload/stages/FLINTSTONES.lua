local i = 0
function onCreate()
	local folder = 'grandDad/'

	makeLuaSprite('Sky', folder..'Grand_Dad_BG2_7', -250, -225);
	addLuaSprite('Sky', false);
	scaleObject('Sky',0.6,0.6);
	setScrollFactor('Sky',0.3,0.3);

	makeLuaSprite('Trees', folder..'Grand_Dad_BG2_6', -210, -300);
	addLuaSprite('Trees', false);
	scaleObject('Trees',0.9,0.9);
	setScrollFactor('Trees',0.5,0.5);

	makeLuaSprite('Tree', folder..'Grand_Dad_BG2_5', -210, -150);
	addLuaSprite('Tree', false);
	scaleObject('Tree',0.7,0.7);
	setScrollFactor('Tree',0.6,0.6);

	makeLuaSprite('Bushes', folder..'Grand_Dad_BG2_4', 360, -90);
	addLuaSprite('Bushes', false);
	scaleObject('Bushes',0.6,0.6);
	setScrollFactor('Bushes',0.77,0.77);

	makeLuaSprite('House', folder..'Grand_Dad_BG2_3', 350, -130);
	addLuaSprite('House', false);
	scaleObject('House',0.6,0.6);
	setScrollFactor('House',0.8,0.8);

	makeLuaSprite('Bushes2', folder..'Grand_Dad_BG2_2', 350, -140);
	addLuaSprite('Bushes2', false);
	scaleObject('Bushes2',0.6,0.6);
	setScrollFactor('Bushes2',0.85,0.85);
	
	makeLuaSprite('Floor', folder..'Grand_Dad_BG2_1', -365, -445);
	addLuaSprite('Floor', false);
	scaleObject('Floor',0.95,0.95);
	
	makeAnimatedLuaSprite('WEEGEE SANIC', folder..'Sanic_and_Weegee_boppers',-220,50)
    addAnimationByPrefix('WEEGEE SANIC','WS Idle','sanic_weegee_boppers',24,false);
	addLuaSprite('WEEGEE SANIC',false);
	scaleObject('WEEGEE SANIC',0.65,0.65);

	makeAnimatedLuaSprite('Troll', folder..'Troll_Bopper',1300,130);
    addAnimationByPrefix('Troll','Troll Idle','troll_bopper',24,false);
	addLuaSprite('Troll',false);
	scaleObject('Troll',0.65,0.65);

	makeAnimatedLuaSprite('Nana', folder..'Nana_Bopper',1500,200);
    addAnimationByPrefix('Nana','Nana Idle','nana_bopper',24,false);
	addLuaSprite('Nana',false);
	scaleObject('Nana',0.65,0.65);

	makeAnimatedLuaSprite('Nyan', folder..'NyanCat_Bopper',1200,-150);
    addAnimationByPrefix('Nyan','Nyan Idle','NyanCat_bopper',24,false);
	addLuaSprite('Nyan',false);
	scaleObject('Nyan',0.65,0.65);

	makeAnimatedLuaSprite('Varg', folder..'Vinesauce_Bopper',-150,-150);
    addAnimationByPrefix('Varg','Varg Idle','Vinesauce_Bopper',24,false);
	addLuaSprite('Varg',false);
	scaleObject('Varg',0.65,0.65);

	

end

function onCountdownTick(counter)
	boppersLol()
end

function onBeatHit()
	boppersLol()
end

function boppersLol()
	objectPlayAnimation('WEEGEE SANIC', 'WS Idle', true)
	objectPlayAnimation('Troll', 'Troll Idle', true)
	objectPlayAnimation('Nana', 'Nana Idle', true)
	objectPlayAnimation('Nyan', 'Nyan Idle', true)
	objectPlayAnimation('Varg', 'Varg Idle', true)
end
