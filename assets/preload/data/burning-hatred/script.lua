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
	addLuaSprite('die', false);
    setObjectCamera('die','camHUD')
	setProperty('die.antialiasing', false);
	screenCenter('die')
	setProperty('die.scale.x', 0)
	setProperty('die.scale.y', 0)

    makeLuaText('itText', '',  1100, 3, 600);
    setTextSize('itText', 32);
	setTextColor('itText', 'ffffff')
    addLuaText('itText');
	setObjectCamera('itText', 'other');
	setTextString('itText', "IT");
	setTextFont('itText', 'Super-Mario-World.ttf')
	setProperty('itText.alpha', 0)
	screenCenter('itText', 'y')
	setTextBorder('itText', getTextSize('itText') / 10, '000000')

    makeLuaText('burnText', '',  1400, 3, 600);
    setTextSize('burnText', 32);
	setTextColor('burnText', 'fc0303')
    addLuaText('burnText');
	setObjectCamera('burnText', 'other');
    setTextFont('burnText', 'Super-Mario-World.ttf')
	setProperty('burnText.alpha', 0)
	setTextString('burnText', "BURNS!"); 
	screenCenter('burnText', 'y')
	setTextBorder('burnText', getTextSize('burnText') / 10, '000000')
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curBeat >= 450 then
		addHealth(-0.009)
		if getHealth() < 0.01 then
			setHealth(0.01)
		end
	end
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
	doTweenY('dadJumpBackY', 'dad', defaultBoyfriendY + 1650, 0.5, 'cubeIn')
	--doTweenY('dadJumpY', 'dad', defaultBoyfriendY - 200, 0.3, 'cubeOut')
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
		doTweenAlpha('burnText', 'burnText', 0, 3.2, linear);
		doTweenAlpha('itText', 'itText', 0, 3.2, linear);
	end
end

function onEvent(name, value1, value2)
	if name == 'Trigger Podoboos' then
		if value1 == '35' then
			makeLuaSprite('light', '', 0, 0);
			makeGraphic('light',1280,720,'FF6A00')
			setProperty('light.scale.x',4)
			setProperty('light.scale.y',4)
			setLuaSpriteScrollFactor('light',0,0)
			addLuaSprite('light', false);
			setObjectOrder('light', getObjectOrder('torchHot')+1);
			setBlendMode('light', 'lighten')
			setProperty('light.alpha', 0)
			
			doTweenColor('dadColor', 'dad', '000000', 0.5, 'linear')
			doTweenColor('bfColor', 'boyfriend', '000000', 0.5, 'linear')
			doTweenColor('gfColor', 'gf', '000000', 0.5, 'linear')
			doTweenColor('BridgeOfDeathColor', 'BridgeOfDeath', '000000', 0.5, 'linear')
			doTweenColor('BackdropColor', 'Backdrop', '404040', 0.5, 'linear')
			doTweenColor('torchHotColor', 'torchHot', '404040', 0.5, 'linear')
			doTweenAlpha('lightColor', 'light', '1', 0.5, 'linear')
			setProperty('podobooSpawnMinX', -300)
			setProperty('podobooSpawnMaxX', 800)
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'lightColor' then
		doTweenAlpha('lightColor2', 'light', '0', 5, 'linear')
	end
end