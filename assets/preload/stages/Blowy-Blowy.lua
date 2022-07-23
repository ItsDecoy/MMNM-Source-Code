function onCreate()
	-- background shit
	makeLuaSprite('Whole-Ah Castle', 'stageassets/mariobg', -550, -400);
	addLuaSprite('Whole-Ah Castle', false);
	scaleObject('Whole-Ah Castle', 0.75, 0.75);
	
	


	


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end