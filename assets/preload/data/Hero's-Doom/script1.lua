function onCreate()
        makeLuaText('runTxt', "RAP!", 530, 400, 330);
        setTextSize('runTxt', 50);
        addLuaText('runTxt');
        setTextColor('runTxt', 'ffffff');
	setObjectCamera('runTxt', 'hud');
	setProperty('runTxt.visible', false);
	
	addLuaScript('lua/reverseStrum')
end

function onCreatePost()
    setTextFont('runTxt', 'Pixel_NES.otf')
end

function onStepHit()
	if curStep == 2200 then
                doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
        end
	if curStep == 2204 then
                doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);	
        end
	if curStep == 2208 then
                doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
        end

	if curStep == 2212 then
                doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
        end

	if curStep == 2216 then
                doTweenColor('timeBar', 'timeBar', 'fc0303', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'fc0303', 0.3, linear);
        end

	if curStep == 2220 then
                doTweenColor('timeBar', 'timeBar', 'ffffff', 0.3, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'ffffff', 0.3, linear);
        end

	if curStep == 2224 then
                doTweenColor('timeBar', 'timeBar', 'fc0303', 1.2, 'linear');
	        doTweenColor('timeTxt', 'timeTxt', 'fc0303', 1.2, linear);
        end

	if curStep == 2624 then
	        setProperty('runTxt.visible', true);
        end

	if curStep == 2752 then
		setProperty('runTxt.visible', false);
        end
end