function onBeatHit()
	if curBeat % 2 == 0 then
		setProperty('iconP1.angle', 10)
		setProperty('iconP2.angle', -10)
	else
		setProperty('iconP1.angle', -10)
		setProperty('iconP2.angle', 10)
	end
end