function onCreate()
    makeLuaSprite('red', '', 0, 0);
    makeGraphic('red',1280,720,'ff0000')
    setProperty('red.scale.x',4)
    setProperty('red.scale.y',4)
    setLuaSpriteScrollFactor('red',0,0)
    addLuaSprite('red', false);
    setProperty('red.visible', false);
    setObjectOrder('red', 1);
end

function onCreatePost()
    makeLuaText('runTxt', "RAP!", 530, 400, 330);
    setTextSize('runTxt', 50);
    addLuaText('runTxt');
    setTextColor('runTxt', 'ffffff');
	setObjectCamera('runTxt', 'hud');
	setProperty('runTxt.visible', false)
    setTextFont('runTxt', 'Pixel_NES.otf')
    setTextBorder('runTxt', getTextSize('runTxt') / 10, '000000')
end

function onStepHit()
	if curStep == 2224 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end
	if curStep == 2228 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);	
    end
	if curStep == 2232 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end

	if curStep == 2236 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
    end

	if curStep == 2240 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
    end

	if curStep == 2244 then
        doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
    end

	if curStep == 2248 then
        doTweenColor('timeBar', 'timeBar', 'fc0303', 1.2, 'linear');
	    doTweenColor('timeTxt', 'timeTxt', 'fc0303', 1.2, linear);
    end

	if curStep == 2528 then
	    setProperty('runTxt.visible', true);
    end

	if curStep == 2656 then
		setProperty('runTxt.visible', false);
    end
	
    if (curStep >= 2528 and curStep < 2656) and flashingLights then
        setProperty('red.visible', curStep % 2 == 0)
    end 
	
    if curStep == 2656 then
        setProperty('rapTxt.visible', false);
        setProperty('red.visible', false);
    end
end