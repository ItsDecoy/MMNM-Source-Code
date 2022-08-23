function onCreate()
	precacheImage('UpperBar');
	makeLuaSprite('UpperBar', 'mafio/CinematicUpperBar', 0, 800);
	setScrollFactor('UpperBar', 0.50, 0.50);
	addLuaSprite('UpperBar');
	setObjectCamera('UpperBar', 'other');
	scaleObject('UpperBar', 0.9, 0.9);

	precacheImage('DownBar');
	makeLuaSprite('DownBar', 'mafio/CinematicDownerBar', 0, -200);
	setScrollFactor('DownBar', 0.50, 0.50);
	addLuaSprite('DownBar');
	setObjectCamera('DownBar', 'other');
	scaleObject('DownBar', 0.9, 0.9);

	precacheImage('mafiotext');
	makeAnimatedLuaSprite('mafiotext','mafio/text1',400, 750);
	addAnimationByPrefix('mafiotext','you','youText',24,false);
	addAnimationByPrefix('mafiotext','youtried','youtriedText',24,false);
	addAnimationByPrefix('mafiotext','youtriedto','youtriedtoText',24,false);
	addAnimationByPrefix('mafiotext','youtriedtofuck','youtriedtofuckText',24,false);
	addAnimationByPrefix('mafiotext','youtriedtofuckme','youtriedtofuckmeText',24,false);
	setScrollFactor('mafiotext', 0.50, 0.50);
	addLuaSprite('mafiotext');
	setObjectCamera('mafiotext', 'other');
	scaleObject('mafiotext', 0.45, 0.45);
end

function onStepHit()
	--if curStep == 20 then
	--	doTweenY('mafiotextTween', 'mafiotext', 500, 1, 'cubeInOut');
	--end
	if curStep == 297 then
		doTweenY('UpperBarTween', 'UpperBar', 550, 1, 'cubeInOut');
		doTweenY('DownBarTween', 'DownBar', -30, 1, 'cubeInOut');
		--doTweenAlpha('hud', 'camHUD', 0, 2.5, 'linear')
		noteTweenAlpha('NoteFade0', 0, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade1', 1, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade2', 2, 0, 0.5, 'linear');
		noteTweenAlpha('NoteFade3', 3, 0, 0.5, 'linear');
		setProperty('defaultCamZoom', 1.3);
		doTweenY('mafiotextTween', 'mafiotext', 600, 1, 'cubeInOut');
		objectPlayAnimation('mafiotext','you', false)
	end
	if curStep == 318 then
		removeLuaSprite('mafiotext');
	end
    if curStep == 348 then
		--doTweenAlpha('hud', 'camHUD', 1, 0.5, 'linear')
		doTweenY('UpperBarTween', 'UpperBar', 800, 1, 'cubeInOut');
		doTweenY('DownBarTween', 'DownBar', -300, 1, 'cubeInOut');
		noteTweenAlpha('NoteFade0', 0, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade1', 1, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade2', 2, 1, 0.5, 'linear');
		noteTweenAlpha('NoteFade3', 3, 1, 0.5, 'linear');
		setProperty('defaultCamZoom', 0.7);
	end
end