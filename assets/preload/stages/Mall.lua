function onCreate()
	local folder = 'stages/mall/'

	makeLuaSprite('Sky', folder..'BG2', -170, -120);
	addLuaSprite('Sky', false);
	setScrollFactor('Sky', 0.7, 0.7)
	scaleObject('Sky', 1.5, 1.5)
			
makeAnimatedLuaSprite('Vic', folder..'VicEye',-310,-350)
    addAnimationByPrefix('Vic','VicEyeDance','crackers norm',24,false);
	addAnimationByPrefix('Vic','VicEyeShockDance','crackers crust',24,false);
	scaleObject('Vic', 1.5, 1.5)
	addLuaSprite('Vic',false);

	makeLuaSprite('Floor(to piss on)', folder..'Poles', -470, -300);
	addLuaSprite('Floor(to piss on)', false);
	setScrollFactor('Floor(to piss on)', 0.7,0.7)
	scaleObject('Floor(to piss on)', 1.5, 1.5)

	makeLuaSprite('Cloud', folder..'Tree', -470, -300);
	addLuaSprite('Cloud', false);
	setScrollFactor('Cloud', 0.7, 0.7)
scaleObject('Cloud', 1.5, 1.5)	
	
	
	makeLuaSprite('Grr', folder..'grr', 510, 450);
	addLuaSprite('Grr', true);
	scaleObject('Grr', 0.55, 0.55)
	setObjectCamera('Grr','other')
	
	makeLuaSprite('Job', folder..'job', 270, 450);
	addLuaSprite('Job', true);
		scaleObject('Job', 0.55, 0.55)
	setObjectCamera('Job','other')

		makeLuaSprite('You', folder..'you', 800, 400);
	addLuaSprite('You', true);
		scaleObject('You', 0.35, 0.35)
	setObjectCamera('You','hud')
	
		makeAnimatedLuaSprite('People', folder..'BGcpeachnimated',450,-150)
    addAnimationByPrefix('People','Sad Mario Dance','peach norm',24,false);
	   addAnimationByPrefix('People','Shocked Mario Dance','peach crust',24,false);
	scaleObject('People', 1.3, 1.3)
	addLuaSprite('People',false);


	
	close(true)
end