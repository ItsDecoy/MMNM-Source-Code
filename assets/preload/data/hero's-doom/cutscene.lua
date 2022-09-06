local allowCountdown = false

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('Heros_Doom_Cutscene');
		triggerEvent('Camera Fade', '0', '0')
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end