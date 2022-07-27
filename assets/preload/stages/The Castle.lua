function onCreate()

	makeLuaSprite('Sky','mafio/Mafia_BG5', -750, -55);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.7,1.7);

	makeLuaSprite('Floor(to piss on)','mafio/Mafia_BG4', -500, -100);
	addLuaSprite('Floor(to piss on)', false);
	scaleObject('Floor(to piss on)', 1.4,1.4)

	makeLuaSprite('Cloud','mafio/Mafia_BG3',-480, -120);
	addLuaSprite('Cloud', false);
	scaleObject('Cloud',1.4,1.4)	
	
	makeLuaSprite('GoobShad','mafio/Mafia_BG2', -120, 80);
	addLuaSprite('GoobShad', false);
	scaleObject('GoobShad',1.2,1.2)	

	makeLuaSprite('MarShad','mafio/Mafia_BG1', -320, 50);
	addLuaSprite('MarShad', false);
	scaleObject('MarShad',1.2,1.2)
	
	makeAnimatedLuaSprite('SecretLoog','mafio/LuigiMafia',200,500);
	addAnimationByPrefix('SecretLoog','Idle','Loogi Idle',24,true);
	addLuaSprite('SecretLoog')
	scaleObject('SecretLoog',0.6,0.6)
	addAnimationByPrefix('SecretLoog','Shoot','Loogi Shoot',24,false)
	

	close(true)

end