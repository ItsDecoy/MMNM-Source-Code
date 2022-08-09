function onEvent(name, value1, value2)
	if name == 'HUD Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('camHUD.alpha', targetAlpha);
		else
			doTweenAlpha('HUDFadeEventTween', 'camHUD', targetAlpha, duration, 'linear');
		end
	end
end