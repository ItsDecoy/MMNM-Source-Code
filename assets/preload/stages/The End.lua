function onCreate()

	makeLuaSprite('Sky','piss/Bg-sky', -650, -325);
	addLuaSprite('Sky', false);
	scaleObject('Sky',1.8,1.8);

	makeLuaSprite('Floor(to piss on)','piss/BG-Groud', -300, 550);
	addLuaSprite('Floor(to piss on)', false);
	scaleObject('Floor(to piss on)', 1.2,1.2)

	makeLuaSprite('Cloud','piss/Bg-Clouds', -300, -150);
	addLuaSprite('Cloud', false);	
	
	makeLuaSprite('GoobShad','piss/Bg-Goombas-Shadow', 200, 700);
	addLuaSprite('GoobShad', false);

	makeLuaSprite('MarShad','piss/Bg-Mario-shadow', 720, 650);
	addLuaSprite('MarShad', false);

	

	close(true)

end