function onCreate()

	makeLuaSprite('Sky','mafio/Mafia_BG5', -350, -55);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1,1);
	setScrollFactor('Sky',0.8,0.8);

	makeLuaSprite('Outside','mafio/Mafia_BG4', -210, -50);
	addLuaSprite('Outside', false);
	scaleObject('Outside', 0.9,0.9);
	setScrollFactor('Outside',0.8,0.8);

	makeLuaSprite('Room','mafio/Mafia_BG3',-480, -120);
	addLuaSprite('Room', false);
	scaleObject('Room',1,1);
	setScrollFactor('Room',0.95,0.95);	
	
	makeLuaSprite('Desk','mafio/Mafia_BG2', -320, 80);
	addLuaSprite('Desk', false);
	scaleObject('Desk',0.75,0.75);	

	makeLuaSprite('Block','mafio/Mafia_BG1', -500, -130);
	addLuaSprite('Block', false);
	scaleObject('Block',1,1);
	setScrollFactor('Block',0.95,0.95);
	
	makeAnimatedLuaSprite('SecretLoog','mafio/LuigiMafia',200,450);
	addAnimationByPrefix('SecretLoog','Idle','Loogi Idle',24,true);
	addLuaSprite('SecretLoog',true);
	scaleObject('SecretLoog',0.65,0.65);
	addAnimationByPrefix('SecretLoog','Shoot','Loogi Shoot',24,false);
	

	close(true)

end