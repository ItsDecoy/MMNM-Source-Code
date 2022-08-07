flamesIsMyBestie = {{-80,321}, {575,319}, {1225,317}}

function onCreate()

	makeLuaSprite('Smoke', 'IHY/coughcough', -750, -100);
	addLuaSprite('Smoke', false);
	
	makeLuaSprite('ManInTheMirror', 'IHY/TheWallsHaveEYes', -750, -150);
	addLuaSprite('ManInTheMirror', false);
	scaleObject('ManInTheMirror',0.65,0.65);
	 
	makeLuaSprite('Backdrop', 'IHY/In the back walls', -500, -150);
	addLuaSprite('Backdrop', false);
	scaleObject('Backdrop',0.55,0.55);

	makeLuaSprite('BridgeOfDeath', 'IHY/IHYourBridge', -500, -150);
	addLuaSprite('BridgeOfDeath', false);
	scaleObject('BridgeOfDeath',0.55,0.55);

	makeLuaSprite('cracked', 'IHY/bridgeCrack', -500, -150);
	addLuaSprite('cracked', false);
	scaleObject('cracked',0.55,0.55);
	setProperty('cracked.visible', false);

	makeLuaSprite('broke', 'IHY/bridgeBroken', -500, -150);
	addLuaSprite('broke', false);
	scaleObject('broke',0.55,0.55);
	setProperty('broke.visible', false);

	for i=1,#flamesIsMyBestie do
		makeAnimatedLuaSprite('FlameMD'..i,'IHY/fire',flamesIsMyBestie[i][1],flamesIsMyBestie[i][2]);
		addAnimationByPrefix('FlameMD'..i, 'fireanim','penis', 24,true);
		objectPlayAnimation('FlameMD'..i,'fireanime',true);
		addLuaSprite('FlameMD'..i,false);
		scaleObject('FlameMD'..i,0.65,0.65);
	end	
end
