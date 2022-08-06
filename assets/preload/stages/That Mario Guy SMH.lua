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



	makeAnimatedLuaSprite('FlameMD','IHY/fire',-80,325);
	addAnimationByPrefix('FlameMD', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD','fireanime',true);
	addLuaSprite('FlameMD',false);
	scaleObject('FlameMD',0.65,0.65);
	
	makeAnimatedLuaSprite('FlameMD1','IHY/fire',575,323);
	addAnimationByPrefix('FlameMD1', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD1','fireanime',true);
	addLuaSprite('FlameMD1',false);
	scaleObject('FlameMD1',0.65,0.65);

	makeAnimatedLuaSprite('FlameMD2','IHY/fire',1225,317);
	addAnimationByPrefix('FlameMD2', 'fireanim','penis', 24,true);
	objectPlayAnimation('FlameMD2','fireanime',true);
	addLuaSprite('FlameMD2',false);
	scaleObject('FlameMD2',0.65,0.65);

	makeLuaSprite('damn', 'IHY/damnit', 270, 400);
	addLuaSprite('damn', true);
        setObjectCamera('damn','other')
	scaleObject('damn',0.3,0.3);
	doTweenAlpha('damnfade', 'damn', 0, 0.1, linear);

	makeLuaSprite('hate', 'IHY/hate', 270, 400);
	addLuaSprite('hate', true);
        setObjectCamera('hate','other')
	scaleObject('hate',0.3,0.3);
	doTweenAlpha('hate', 'hate', 0, 0.1, linear);

	makeLuaSprite('die', 'IHY/die', 0, -40);
	addLuaSprite('die', true);
        setObjectCamera('die','other')
	scaleObject('die',0.5,0.5);
	setProperty('die.antialiasing', false);

        makeLuaText('itText', '',  1150, 3, 600);
        setTextSize('itText', 32);
	setTextColor('itText', 'ffffff')
        addLuaText('itText');
	setObjectCamera('itText', 'other');
	doTweenAlpha('itText', 'itText', 0, 0.1, linear);

        makeLuaText('burnText', '',  1400, 3, 600);
        setTextSize('burnText', 32);
	setTextColor('burnText', 'fc0303')
        addLuaText('burnText');
	setObjectCamera('burnText', 'other');
	doTweenAlpha('burnText', 'burnText', 0, 0.1, linear);
	
end

function onUpdate()
        setTextString('itText', "IT");
        setTextString('burnText', "BURNS!"); 
end
function onCreatePost()
	doTweenX('scaleTweenX', 'die.scale', 0, 0.1, 'sineIn');
	doTweenY('scaleTweenY', 'die.scale', 0, 0.1, 'sineIn');
        setTextFont('itText', 'Super-Mario-World.ttf')
        setTextFont('burnText', 'Super-Mario-World.ttf')
end
function onStepHit()
 if curStep == 512 then
	doTweenAlpha('damnfade', 'damn', 1, 0.3, linear);
end
 if curStep == 537 then
	setProperty('BridgeOfDeath.visible', false);
	doTweenAlpha('damnfade', 'damn', 0, 0.3, linear);
	setProperty('cracked.visible', true);
end
 if curStep == 560 then
	setProperty('cracked.visible', false);
	setProperty('broke.visible', true);
end
 if curStep == 616 then
	doTweenAlpha('hate', 'hate', 1, 2, linear);
end
 if curStep == 655 then
	doTweenAlpha('hate', 'hate', 0, 0.1, linear);
end
if curStep == 1798 then
	doTweenX('scaleTweenX', 'die.scale', 0.5, 0.1, 'sineIn');
	doTweenY('scaleTweenY', 'die.scale', 0.5, 0.1, 'sineIn');
end
if curStep == 1808 then
	doTweenX('scaleTweenX', 'die.scale', 0, 0.1, 'sineOut');
	doTweenY('scaleTweenY', 'die.scale', 0, 0.1, 'sineOut');
end
 if curStep == 2112 then
	doTweenAlpha('itText', 'itText', 1, 0.5, linear);
end
 if curStep == 2122 then
	doTweenAlpha('burnText', 'burnText', 1, 1.2, linear);
end
 if curStep == 2160 then
	doTweenAlpha('burnText', 'burnText', 0, 1.2, linear);
	doTweenAlpha('itText', 'itText', 0, 1.2, linear);
end
end