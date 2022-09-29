function onCreate()
	makeLuaSprite('damn', 'IHY/damnit', 270, 400);
	addLuaSprite('damn', true);
    setObjectCamera('damn','other')
	scaleObject('damn',0.3,0.3);
	setProperty('damn.alpha', 0)

	makeLuaSprite('hate', 'IHY/hate', 270, 400);
	addLuaSprite('hate', true);
    setObjectCamera('hate','other')
	scaleObject('hate',0.3,0.3);
	setProperty('hate.alpha', 0)

	makeLuaSprite('die', 'IHY/die', 0, 0);
	addLuaSprite('die', true);
    setObjectCamera('die','other')
	setProperty('die.antialiasing', false);
	
	setProperty('die.x', (screenWidth/2) - (getProperty('die.width') / 2))
	setProperty('die.y', (screenHeight/2) - (getProperty('die.height') / 2))
	scaleObject('die', 0, 0);

    makeLuaText('itText', '',  1150, 3, 600);
    setTextSize('itText', 32);
	setTextColor('itText', 'ffffff')
    addLuaText('itText');
	setObjectCamera('itText', 'other');
	setTextString('itText', "IT");
	setTextFont('itText', 'Super-Mario-World.ttf')
	setProperty('itText.alpha', 0)

    makeLuaText('burnText', '',  1400, 3, 600);
    setTextSize('burnText', 32);
	setTextColor('burnText', 'fc0303')
    addLuaText('burnText');
	setObjectCamera('burnText', 'other');
    setTextFont('burnText', 'Super-Mario-World.ttf')
	setProperty('burnText.alpha', 0)
	setTextString('burnText', "BURNS!"); 
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
	if curStep == 603 then	
		setProperty('BridgeOfDeath.visible',true);
		setProperty('broke.visible', false);
	end
	if curStep == 616 then
		doTweenAlpha('hate', 'hate', 1, 2, linear);
	end
	if curStep == 655 then
		doTweenAlpha('hate', 'hate', 0, 0.1, linear);
	end
	if curStep == 1799 then
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