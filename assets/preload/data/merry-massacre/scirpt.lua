shakyThings = {}
local angleshit = 1;
local anglevar = 1;
local xOffset = 0;
function onCreate()
	setProperty('Grr.alpha', 0)
	setProperty('Job.alpha', 0)
	addShake('Grr', 2)
	addShake('Job', 2)
	

end
function onCreatePost()
	triggerEvent('Alternate Icons', 'gf', 'bf')
	setProperty('camZooming', true)
	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)

end

function onSongStart()

	setProperty('timeBarBG.visible', true)
	setProperty('timeBar.visible', true)
	
end

function addShake(spr, shakeIntensity)
	table.insert(shakyThings, {spr, getProperty(spr..'.x'), getProperty(spr..'.y'), shakeIntensity})
end

function onUpdate(elapsed)
	for i = 1,#shakyThings do
		local leSh = shakyThings[i][4]
		setProperty(shakyThings[i][1]..'.x', shakyThings[i][2] + getRandomFloat(-leSh, leSh))
		setProperty(shakyThings[i][1]..'.y', shakyThings[i][3] + getRandomFloat(-leSh, leSh))
		doTweenColor('timeBar', 'timeBar', '00ff00', 0.01, 'linear');
        doTweenColor('timeTxt', 'timeTxt', 'ff0000', 0.01, 'linear');
	end
end

function onStepHit()
	if curStep == 574 then
				doTweenAlpha('Grr', 'Grr', 1, 0.5, linear);		
end
	if curStep == 602 then
				doTweenAlpha('Grr', 'Grr', 0, 0.5, linear);			
end
	if curStep == 607 then
				doTweenAlpha('Job', 'Job', 1, 0.5, linear);
end
	if curStep == 639 then
				doTweenAlpha('Job', 'Job', 0, 0.5, linear);
end

	if curStep >= 1024 and curStep <= 1088 then
			 		if curStep % 4 == 0 then
		objectPlayAnimation('People', 'Shocked Mario Dance', true);
		objectPlayAnimation('Vic', 'VicEyeShockDance', true);
				end
end
function onBeatHit()
	 		if curBeat % 2 == 0 then
		objectPlayAnimation('People', 'Sad Mario Dance', true);
		objectPlayAnimation('Vic', 'VicEyeDance', true);
		setProperty('iconP1.angle', 10)
		setProperty('iconP2.angle', -10)
	else
		setProperty('iconP1.angle', -10)
		setProperty('iconP2.angle', 10)
end
	if curBeat >= 368 and curBeat <= 399 or curBeat >= 112 and curBeat <= 142 then
		if curBeat % 2 == 0 then
			angleshit = anglevar;
		else
			angleshit = -anglevar;
		end
		setProperty('camHUD.angle',angleshit*3)
		doTweenAngle('hudSwing', 'camHUD', angleshit, stepCrochet*0.004, 'circOut')
		xOffset = angleshit*18
	else
		cancelTween('hudSwing')
		setProperty('camHUD.angle',0)
		setProperty('camGame.angle',0)
		xOffset = 0
	end

	if curBeat >= 0 and curBeat<= 10 then
		if curBeat % 2 == 0 then
			setProperty('You.alpha', 0);
		else 
			setProperty('You.alpha', 1);

end
end
end
end



