function onCreate()
        makeLuaText('runTxt', "RAP!", 530, 400, 330);
        setTextSize('runTxt', 50);
        addLuaText('runTxt');
        setTextColor('runTxt', 'ffffff');
	setObjectCamera('runTxt', 'hud');
	setProperty('runTxt.visible', false);
end

function onCreatePost()
        setTextFont('runTxt', 'Pixel_NES.otf')

        setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
        setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)
        setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)
        setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)
        setPropertyFromGroup('playerStrums', 4, 'x', defaultOpponentStrumX4)

        setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0 + 0)
        setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1 + 0)
        setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2 + 0)
        setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3 + 0)
        setPropertyFromGroup('opponentStrums', 4, 'x', defaultPlayerStrumX4 + 0)
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