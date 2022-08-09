function onEvent(name, value1, value2)
	if name == 'Wario Slam' then
		cameraShake('game', 0.02, 0.1);
		cameraShake('hud', 0.01, 0.1);
		
		drain = tonumber(value1);
		setProperty('health', getProperty('health') - drain)
	end
end