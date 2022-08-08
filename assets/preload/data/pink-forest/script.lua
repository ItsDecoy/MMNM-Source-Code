local i = 0
local blacked = true

function onCreatePost()
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1280,720,'000000')
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setLuaSpriteScrollFactor('black',0,0)
	addLuaSprite('black', true);
	doTweenAlpha('iconfade', 'iconP2', 0, 0.1, linear);
	
	makeLuaSprite('love','Coronation/love', 360, 400);
	addLuaSprite('love', false);
	scaleObject('love',0.3,0.3)
    setObjectCamera('love','other')
	
	makeLuaSprite('red','Coronation/red', 360, 400);
	addLuaSprite('red', false);
	scaleObject('red',0.3,0.3)
    setObjectCamera('red','other')
	
	setProperty('dad.visible',false);
	
	--addLuaScript('lua/CameraFollowPos')
end

function onUpdate(elapsed)
	i = i + elapsed
	setProperty('dad.y', (math.sin(i * 1.2)*80) + 320)
	
	if blacked and curStep > 384 then
		setProperty('blackfade.visible',false);
		blacked = false
	end
end

function onStepHit()
	-- Black Fades.
	if curStep == 64 then
		doTweenAlpha('blackfade', 'black', 0, 0.7, linear);
	end
	
	-- Black Appears again.
	if curStep == 280 then
		doTweenAlpha('blackfade', 'black', 1, 0.7, linear);
	end 
	
	-- She loves...
	if curStep == 292 then
		doTweenY('lovey', 'love', 0, 0.5, 'sineOut')
	end
	
	-- RED.
	if curStep == 308 then
		doTweenY('redy', 'red', 0, 0.9, 'sineOut')
	end
	
	-- Text goes away (also Peach is visible now)
	if curStep == 320 then
		doTweenY('redy', 'red', 400, 0.9, 'sineOut')
		doTweenY('lovey', 'love', 400, 0.9, 'sineOut')
		setProperty('dad.visible',true);
	end

	-- Black Fades again and peach's icon becomes visible too.
	if curStep == 384 then
		blacked = false
		doTweenAlpha('iconfade', 'iconP2', 1, 0.7, linear);
		doTweenAlpha('blackfade', 'black', 0, 0.7, linear);
	end 
end