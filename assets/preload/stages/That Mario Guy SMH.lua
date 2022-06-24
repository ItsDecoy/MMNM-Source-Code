function onCreate()

	makeLuaSprite('Smoke', 'stageassets/coughcough', -800, -100);
	addLuaSprite('Smoke', false);
	
	makeLuaSprite('ManInTheMirror', 'stageassets/TheWallsHaveEYes', -800, -150);
	addLuaSprite('ManInTheMirror', false);
	scaleObject('ManInTheMirror',0.65,0.65);
	 
	makeLuaSprite('Backdrop', 'stageassets/In the back walls', -550, -150);
	addLuaSprite('Backdrop', false);
	scaleObject('Backdrop',0.55,0.55);

	makeLuaSprite('BridgeOfDeath', 'stageassets/IHYourBridge', -550, -150);
	addLuaSprite('BridgeOfDeath', false);
	scaleObject('BridgeOfDeath',0.55,0.55);



	makeAnimatedLuaSprite('FlameMD','stageassets/fire',-130,325);
	addAnimationByPrefix('FlameMD', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD','fireanime',true);
	addLuaSprite('FlameMD',false);
	scaleObject('FlameMD',0.65,0.65);
	
	makeAnimatedLuaSprite('FlameMD1','stageassets/fire',525,323);
	addAnimationByPrefix('FlameMD1', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD1','fireanime',true);
	addLuaSprite('FlameMD1',false);
	scaleObject('FlameMD1',0.65,0.65);

	makeAnimatedLuaSprite('FlameMD2','stageassets/fire',1175,317);
	addAnimationByPrefix('FlameMD2', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD2','fireanime',true);
	addLuaSprite('FlameMD2',false);
	scaleObject('FlameMD2',0.65,0.65);


	
	
	
end