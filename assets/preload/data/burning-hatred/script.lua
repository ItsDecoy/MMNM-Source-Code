shakyThings = {}

function onCreate()
	makeLuaSprite('damn', 'IHY/damnit', 270, 400);
	addLuaSprite('damn', true);
    setObjectCamera('damn','other')
	scaleObject('damn',0.3,0.3);
	setProperty('damn.alpha', 0)

	-- I HATE YOU.
    makeText('I', 470, 600, 32)
    makeText('HATE', 508, 590, 50)
    makeText('YOU!!', 700, 600, 32)
	setTextColor('HATE', 'ff0000')
	setProperty('I.alpha', 0)
	setProperty('HATE.alpha', 0)
	setProperty('YOU!!.alpha', 0)
	table.insert(shakyThings, {'I', getProperty('I.x'), getProperty('I.y')})
	table.insert(shakyThings, {'HATE', getProperty('HATE.x'), getProperty('HATE.y')})
	table.insert(shakyThings, {'YOU!!', getProperty('YOU!!.x'), getProperty('YOU!!.y')})

	-- DIE
	makeLuaSprite('die', 'IHY/die', 0, 0);
	addLuaSprite('die', false);
    setObjectCamera('die','camHUD')
	setProperty('die.antialiasing', false);
	screenCenter('die')
	setProperty('die.scale.x', 0)
	setProperty('die.scale.y', 0)

	-- IT BURNS
	makeText('IT', 500, 600, 32)
	setTextColor('IT', 'ffffff')
	screenCenter('IT', 'y')
	
	makeText('BURNS', 600, 600, 40)
	setTextColor('BURNS', 'fc0303')
	screenCenter('BURNS', 'y')
	
	setProperty('IT.alpha', 0)
	setProperty('BURNS.alpha', 0)
	
	table.insert(shakyThings, {'IT', getProperty('IT.x'), getProperty('IT.y')})
	table.insert(shakyThings, {'BURNS', getProperty('BURNS.x'), getProperty('BURNS.y')})
end

function makeText(text, x, y, size)
    makeLuaText(text, '',  0, x, y);
    setTextSize(text, size);
	setTextColor(text, 'ffffff')
    addLuaText(text);
	setObjectCamera(text, 'other');
	setTextString(text, text);
	setTextFont(text, 'Super-Mario-World.ttf')
	setTextBorder(text, getTextSize(text) / 10, '000000')
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if curBeat >= 450 then
		addHealth(-0.009)
		if getHealth() < 0.01 then
			setHealth(0.01)
		end
	end
end

function onUpdate(elapsed)
	for i = 1,#shakyThings do
		setProperty(shakyThings[i][1]..'.x', shakyThings[i][2] + getRandomFloat(-4, 4))
		setProperty(shakyThings[i][1]..'.y', shakyThings[i][3] + getRandomFloat(-4, 4))
	end
end

-- I copied step hit functions structure from Singstar Challenge LMAO
-- Ighby

stepHitFuncs = {
	[512] = function()
		doTweenAlpha('damnfade', 'damn', 1, 0.3, linear);
	end,
	
	[537] = function()
		setProperty('BridgeOfDeath.visible', false);
		doTweenAlpha('damnfade', 'damn', 0, 0.3, linear);
		setProperty('cracked.visible', true);
	end,
	
	[560] = function()
		setProperty('cracked.visible', false);
		setProperty('broke.visible', true);
		doTweenY('dadJumpBackY', 'dad', defaultBoyfriendY + 1650, 0.5, 'cubeIn')
		
		local ttime = 0.2
		local ease = 'sineInOut'
		local clor = '000000'
		doTweenColor('dadColor', 'dad', clor, ttime, ease)
		doTweenColor('bfColor', 'boyfriend', clor, ttime, ease)
		doTweenColor('gfColor', 'gf', clor, ttime, ease)
		doTweenColor('brokeColor', 'broke', clor, ttime, ease)
		doTweenColor('BridgeOfDeathColor', 'BridgeOfDeath', clor, ttime, ease)
		
		makeLuaSprite('red', '', 0, 0);
		makeGraphic('red',1280,720,'FF0000')
		setProperty('red.scale.x',4)
		setProperty('red.scale.y',4)
		setLuaSpriteScrollFactor('red',0,0)
		addLuaSprite('red', false);
		setObjectOrder('red', getObjectOrder('torchHot')+1);
		setProperty('red.alpha', 0)
		doTweenAlpha('redAlpha', 'red', '1', ttime, ease)
	end,
	
	[598] = function()
		setProperty('dad.color', getColorFromHex('000000'))
	end,
	
	-- I
	[615] = function()
		setProperty('I.alpha', 1)
	end,
	
	-- HATE
	[624] = function()
		setProperty('HATE.alpha', 1)
	end,
	
	-- YOU
	[632] = function()
		setProperty('YOU!!.alpha', 1)
	end,
	
	[655] = function()
		local ttime = 0.2
		local ease = 'sineInOut'
		local clor = 'ffffff'
		doTweenColor('dadColor', 'dad', clor, ttime, ease)
		doTweenColor('bfColor', 'boyfriend', clor, ttime, ease)
		doTweenColor('gfColor', 'gf', clor, ttime, ease)
		doTweenColor('brokeColor', 'broke', clor, ttime, ease)
		doTweenColor('BridgeOfDeathColor', 'BridgeOfDeath', clor, ttime, ease)
		doTweenColor('BackdropColor', 'Backdrop', clor, 10, ease)
		doTweenColor('torchHotColor', 'torchHot', clor, 10, ease)
		removeLuaSprite('red', true)
		doTweenAlpha('I', 'I', 0, 0.1, linear);
		doTweenAlpha('HATE', 'HATE', 0, 0.1, linear);
		doTweenAlpha('YOU!!', 'YOU!!', 0, 0.1, linear);
	end,
	
	[1799] = function()
		doTweenX('scaleTweenX', 'die.scale', 0.5, 0.1, 'sineIn');
		doTweenY('scaleTweenY', 'die.scale', 0.5, 0.1, 'sineIn');
	end,
	
	[1808] = function()
		doTweenX('scaleTweenX', 'die.scale', 0, 0.1, 'sineOut');
		doTweenY('scaleTweenY', 'die.scale', 0, 0.1, 'sineOut');
	end,
	
	[2112] = function()
		doTweenAlpha('itText', 'IT', 1, 0.5, linear);
	end,
	
	[2122] = function()
		doTweenAlpha('burnText', 'BURNS', 1, 1.2, linear);
	end,
	
	[2160] = function()
		doTweenAlpha('burnText', 'IT', 0, 3.2, linear);
		doTweenAlpha('itText', 'BURNS', 0, 3.2, linear);
	end,
}

function onStepHit()
	if stepHitFuncs[curStep] then 
		stepHitFuncs[curStep]() -- Executes function at curStep in stepHitFuncs
	end
	
	if curStep >= 592 and curStep <= 598 then	
		setProperty('BridgeOfDeath.visible', curStep % 2 == 0);
		setProperty('broke.visible', curStep % 2 == 1);
	end
end

function onEvent(name, value1, value2)
	if name == 'Play Animation' then
		if value1 == 'death' then
			local ttime = 2
			local ease = 'sineInOut'
			local clor = '404040'
			doTweenColor('bfColor', 'boyfriend', clor, ttime, ease)
			doTweenColor('gfColor', 'gf', clor, ttime, ease)
			doTweenColor('BackdropColor', 'Backdrop', clor, ttime, ease)
			doTweenColor('torchHotColor', 'torchHot', clor, ttime, ease)
			triggerEvent('Camera Follow Pos', getProperty('camFollow.x'), getProperty('camFollow.y'))
		end
	elseif name == 'Trigger Podoboos' then
		if value1 == '35' then
			makeLuaSprite('light', '', 0, 0);
			makeGraphic('light',1280,720,'FF6A00')
			setProperty('light.scale.x',4)
			setProperty('light.scale.y',4)
			setLuaSpriteScrollFactor('light',0,0)
			addLuaSprite('light', false);
			setObjectOrder('light', getObjectOrder('torchHot')+1);
			setBlendMode('light', 'lighten')
			setProperty('light.alpha', 0)
			
			doTweenColor('dadColor', 'dad', '000000', 0.5, 'linear')
			doTweenColor('bfColor', 'boyfriend', '000000', 0.5, 'linear')
			doTweenColor('gfColor', 'gf', '000000', 0.5, 'linear')
			doTweenColor('BridgeOfDeathColor', 'BridgeOfDeath', '000000', 0.5, 'linear')
			doTweenColor('BackdropColor', 'Backdrop', '404040', 0.5, 'linear')
			doTweenColor('torchHotColor', 'torchHot', '404040', 0.5, 'linear')
			doTweenAlpha('lightColor', 'light', '1', 0.5, 'linear')
			setProperty('podobooSpawnMinX', -300)
			setProperty('podobooSpawnMaxX', 800)
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'lightColor' then
		doTweenAlpha('lightColor2', 'light', '0', 5, 'linear')
	end
end