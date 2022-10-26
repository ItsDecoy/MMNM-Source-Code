local mxLines = {'Boyfriend', 'rapping', 'doesnt', 'get', 'you', 'Far'}
local camActivated = false

function onCreatePost()
	triggerEvent('Camera Fade', '0', '0')
	triggerEvent('HUD Fade', '0', '0')
	
	for i=1,#mxLines do
		makeLuaSprite('mxLine'..i,'misc/mx/'..mxLines[i],225,100);
		addLuaSprite('mxLine'..i,true);
		scaleObject('mxLine'..i,1,1);
		setObjectCamera('mxLine'..i,'other');
		setProperty('mxLine'..i..'.alpha', 0)
	end
end

function lineVisible(line, fadeTime)
	setProperty(line..'.alpha', 1)
	doTweenAlpha(line..'AlphaTween', line, 0, fadeTime, linear);
end

function onSongStart() -- 'BOYFRIEND' Done separate because onBeatHit() isn't triggered in beat 0 :(
	-- BOYFRIEND
	lineVisible('mxLine1', 3.5)
end

function onBeatHit()
	-- RAPPING
	if curBeat == 16 then
		lineVisible('mxLine2', 1)
	end

	-- DOESN'T
	if curBeat == 20 then
		lineVisible('mxLine3', 1)
	end
	
	-- GET
	if curBeat == 24 then
		lineVisible('mxLine4', 1)
	end
	
	-- YOU
	if curBeat == 25 then
		lineVisible('mxLine5', 1)
	end
	
	-- FAR
	if curBeat == 28 then
		lineVisible('mxLine6', 1)
	end
end