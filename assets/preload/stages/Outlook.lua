function onCreate()
	local location = 'stages/mafio/'

	makeLuaSprite('Sky',location..'Mafia_BG5', -350, -55);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1,1);
	setScrollFactor('Sky',0.8,0.8);

	makeLuaSprite('Outside',location..'Mafia_BG4', -210, -50);
	addLuaSprite('Outside', false);
	scaleObject('Outside', 0.9,0.9);
	setScrollFactor('Outside',0.8,0.8);

	makeLuaSprite('Room',location..'Mafia_BG3',-480, -120);
	addLuaSprite('Room', false);
	scaleObject('Room',1,1);
	setScrollFactor('Room',0.95,0.95);	
	
	makeLuaSprite('Block',location..'Mafia_BG1', -500, -100);
	addLuaSprite('Block', false);
	scaleObject('Block',1,1);
	setScrollFactor('Block',0.95,0.95);
	
	makeAnimatedLuaSprite('SecretLoog',location..'LuigiMafia', 200, 450);
	addAnimationByPrefix('SecretLoog','Idle','Loogi Idle', 34,false);
	addAnimationByPrefix('SecretLoog','Shoot','Loogi Shoot', 34,false);
	addLuaSprite('SecretLoog',true);
	scaleObject('SecretLoog',0.65,0.65);
	

	close(true)

end