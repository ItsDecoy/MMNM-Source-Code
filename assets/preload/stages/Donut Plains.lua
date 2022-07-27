function onCreate()
	-- background shit
	makeLuaSprite('Whole-Ah Castle', 'victim/mariobg', -550, -400);
	addLuaSprite('Whole-Ah Castle', false);
	scaleObject('Whole-Ah Castle', 0.7, 0.7);

	makeLuaSprite('Whole-Ah Castle2', 'victim/victimbg', -550, -400);
	addLuaSprite('Whole-Ah Castle2', false);
	scaleObject('Whole-Ah Castle2', 0.7, 0.7);
	
	
	setProperty('Whole-Ah Castle2.visible',true);


	


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end