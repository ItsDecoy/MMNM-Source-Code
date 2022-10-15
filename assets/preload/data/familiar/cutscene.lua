local allowCountdown = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('Familiar_Cutscene');
		triggerEvent('Camera Fade', '0', '0')
		allowCountdown = true;
		return Function_Stop;
	end
	triggerEvent('Camera Fade', '1', '1')
	return Function_Continue;
end