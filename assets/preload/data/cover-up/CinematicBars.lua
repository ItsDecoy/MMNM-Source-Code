loc = 'misc/mafio/'

function onCreate()
	makeLuaSprite('UpperBar', loc..'CinematicUpperBar', 0, 800);
	addLuaSprite('UpperBar');
	setObjectCamera('UpperBar', 'other');
	scaleObject('UpperBar', 0.9, 0.9);

	makeLuaSprite('DownBar', loc..'CinematicDownerBar', 0, -200);
	addLuaSprite('DownBar');
	setObjectCamera('DownBar', 'other');
	scaleObject('DownBar', 0.9, 0.9);

	precacheImage(loc..'text1');
	makeAnimatedLuaSprite('mafiotext',loc..'text1',400, 750);
	addAnimationByPrefix('mafiotext','you','youText',24,false);
	addAnimationByPrefix('mafiotext','youtried','youtriedText',24,false);
	addAnimationByPrefix('mafiotext','youtriedto','youtriedtoText',24,false);
	addAnimationByPrefix('mafiotext','youtriedtofuck','youtriedtofuckText',24,false);
	addAnimationByPrefix('mafiotext','youtriedtofuckme','youtriedtofuckmeText',24,false);
	addLuaSprite('mafiotext');
	setObjectCamera('mafiotext', 'other');
	scaleObject('mafiotext', 0.45, 0.45);

	precacheImage(loc..'text2');
	makeAnimatedLuaSprite('mafiotextSECOND',loc..'text2',420, 600);
	addAnimationByPrefix('mafiotextSECOND','goodbye','goodbyeText',24,false);
	addAnimationByPrefix('mafiotextSECOND','goodbyeold','goodbyeoldText',24,false);
	addAnimationByPrefix('mafiotextSECOND','goodbyeoldfriend','goodbyeoldfriendText',24,false);
	setObjectCamera('mafiotextSECOND', 'other');
	scaleObject('mafiotextSECOND', 0.45, 0.45);
end

function onStepHit()
	if curStep == 297 then
		doTweenY('UpperBarTween', 'UpperBar', 550, 1, 'cubeInOut');
		doTweenY('DownBarTween', 'DownBar', -30, 1, 'cubeInOut');
		noteTweenAlpha('NoteFade0', 0, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade1', 1, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade2', 2, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade3', 3, 0, 0.5, 'linear');
		setProperty('defaultCamZoom', 1.3);
		doTweenY('mafiotextTween', 'mafiotext', 600, 1, 'cubeInOut');
		objectPlayAnimation('mafiotext','you', false)
	end
	if curStep == 302 then
		objectPlayAnimation('mafiotext','youtried', false)
	end
	if curStep == 308 then
		objectPlayAnimation('mafiotext','youtriedto', false)
	end
	if curStep == 310 then
		objectPlayAnimation('mafiotext','youtriedtofuck', false)
	end
	if curStep == 315 then
		objectPlayAnimation('mafiotext','youtriedtofuckme', false)
	end
	if curStep == 320 then
		removeLuaSprite('mafiotext');
	end
	if curStep == 323 then
		addLuaSprite('mafiotextSECOND');
		objectPlayAnimation('mafiotextSECOND','goodbye', false)
	end
	if curStep == 333 then
		objectPlayAnimation('mafiotextSECOND','goodbyeold', false)
	end
	if curStep == 340 then
		objectPlayAnimation('mafiotextSECOND','goodbyeoldfriend', false)
	end
    if curStep == 348 then
		doTweenY('UpperBarTween', 'UpperBar', 800, 1, 'cubeInOut');
		doTweenY('DownBarTween', 'DownBar', -300, 1, 'cubeInOut');
		noteTweenAlpha('NoteFade0', 0, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade1', 1, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade2', 2, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade3', 3, 1, 0.5, 'linear');
		doTweenY('mafiotextSECONDTween', 'mafiotextSECOND', 900, 1, 'cubeInOut');
		setProperty('defaultCamZoom', 0.7);
	end
	if curStep == 370 then
		removeLuaSprite('mafiotextSECOND');
		removeLuaSprite('UpperBar');
		removeLuaSprite('DownBar');
	end
end