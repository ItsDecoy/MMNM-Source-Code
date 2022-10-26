function onCreate()
	local folder = 'stages/piss/'

	makeLuaSprite('Sky', folder..'Bg-sky', -170, -120);
	addLuaSprite('Sky', false);
	setScrollFactor('Sky', 0, 0)

	makeLuaSprite('Floor(to piss on)', folder..'BG-groud', -300, 550);
	addLuaSprite('Floor(to piss on)', false);
	scaleObject('Floor(to piss on)', 1.2,1.2)

	makeLuaSprite('Cloud', folder..'BG-Clouds', -350, -270);
	addLuaSprite('Cloud', false);
	setScrollFactor('Cloud', 0.7, 0.7)
	
	makeLuaSprite('GoobShad', folder..'BG-Goombas-Shadow', 200, 720);
	addLuaSprite('GoobShad', false);

	makeLuaSprite('MarShad', folder..'BG-Mario-shadow', 705, 650);
	addLuaSprite('MarShad', false);
	
	close(true)
end