flamesIsMyBestie = {{-80,321}, {575,318}, {1225,313}}

function onCreate()
	local folder = 'IHY/'

	makeLuaSprite('Smoke', folder..'coughcough', -750, -100);
	addLuaSprite('Smoke', false);
	setScrollFactor('Smoke', 0.5, 0.5)
	
	makeLuaSprite('ManInTheMirror', folder..'TheWallsHaveEYes', -750, -150);
	addLuaSprite('ManInTheMirror', false);
	scaleObject('ManInTheMirror',0.65,0.65);
	setScrollFactor('ManInTheMirror', 0.7, 0.7)
	 
	makeLuaSprite('Backdrop', folder..'In the back walls', -500, -150);
	addLuaSprite('Backdrop', false);
	scaleObject('Backdrop',0.55,0.55);
	setScrollFactor('Backdrop', 0.7, 0.7)

	makeLuaSprite('BridgeOfDeath', folder..'IHYourBridge', -500, -150);
	addLuaSprite('BridgeOfDeath', false);
	scaleObject('BridgeOfDeath',0.55,0.55);

	makeLuaSprite('cracked', folder..'bridgeCrack', -500, -150);
	addLuaSprite('cracked', false);
	scaleObject('cracked',0.55,0.55);
	setProperty('cracked.visible', false);

	makeLuaSprite('broke', folder..'bridgeBroken', -500, -150);
	addLuaSprite('broke', false);
	scaleObject('broke',0.55,0.55);
	setProperty('broke.visible', false);

	for i=1,#flamesIsMyBestie do
		makeAnimatedLuaSprite('FlameMD'..i, folder..'fire',flamesIsMyBestie[i][1],flamesIsMyBestie[i][2]);
		addAnimationByPrefix('FlameMD'..i, 'fireanim','penis', 24,true);
		objectPlayAnimation('FlameMD'..i,'fireanime',true);
		addLuaSprite('FlameMD'..i,false);
		scaleObject('FlameMD'..i,0.65,0.65);
		setScrollFactor('FlameMD'..i, 0.7, 0.7)
	end	
end
