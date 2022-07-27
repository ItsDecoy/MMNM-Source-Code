function onUpdatePost()
	local curAnim = getProperty('dad.animation.curAnim.name')
	local followX = 0
	local followY = 0
	
	if gfSection then
		curAnim = getProperty('gf.animation.curAnim.name')
	elseif mustHitSection then
		curAnim = getProperty('boyfriend.animation.curAnim.name')
	end
	
	if curAnim == 'singLEFT' then
		followX = -1
	elseif curAnim == 'singDOWN' then
		followY = 1
	elseif curAnim == 'singUP' then
		followY = -1
	elseif curAnim == 'singRIGHT' then
		followX = 1
	end
	setProperty('camFollowPos.x', getProperty('camFollowPos.x') + followX * 0.3);
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') + followY * 0.3);
end
function onStepHit()
 if curStep == 384 then
        doTweenZoom('zoomtween', 'camGame', 1.2, 7, 'circOut')
end
 if curStep == 448 then
        setProperty("defaultCamZoom", 0.8) 
end
 if curStep == 512 then
	doTweenAlpha('HUDgone', 'camHUD', 0, 0.7, linear);
end
 if curStep == 560 then
        setProperty("defaultCamZoom", 0.76) 
end
 if curStep == 599 then
        setProperty("defaultCamZoom", 0.8) 
end
 if curStep == 639 then
	doTweenAlpha('HUDgone', 'camHUD', 1, 0.7, linear);
end
 if curStep == 655 then
	setProperty('cameraSpeed', 2)
	setProperty('camFollowPos.x', getProperty('camFollowPos.x') + followX * 2.5);
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') + followY * 2.5);
end
 if curStep == 1536 then
        setProperty("defaultCamZoom", 1.2) 
end
 if curStep == 1544 then
        setProperty("defaultCamZoom", 0.8) 
end
 if curStep == 1600 then
        setProperty("defaultCamZoom", 1.2) 
end
 if curStep == 1608 then
        setProperty("defaultCamZoom", 0.8) 
end
 if curStep == 1800 then
        setProperty("defaultCamZoom", 1.2) 
end
 if curStep == 1808 then
        setProperty("defaultCamZoom", 0.8) 
end
end
