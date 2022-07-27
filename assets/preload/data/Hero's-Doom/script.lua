function onCreatePost()
	doTweenAlpha('HUDgone', 'camHUD', 0, 0.1, linear);
end

function onStepHit()
	if curStep == 1 then
		doTweenAlpha('HUDgone', 'camHUD', 0, 0.1, linear);
	end
end

function onBeatHit()

	if curBeat == 32 then
		doTweenAlpha('HUDgone', 'camHUD', 1, 0.1, linear);
	end

	if curBeat == 32 then
		setProperty('DarkBox.visible', false);
	end
end