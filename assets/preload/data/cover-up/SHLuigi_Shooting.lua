--variables
activated = false
canDodge = false

spacePressed = false
dodgeTimer = 0

spaceFlashSpeed = 0.05

loc = 'misc/mafio/'

function onCreate()
	getPropertyFromClass('Controls', 'var DODGE')
end

function onEvent(name, value1, value2)
    if name == "SHLuigi Shooting" then		
		--Get Dodge time
		local dodgeTime = (crochet / 1000) * 1
		if not (value1 == '') then
			dodgeTime = (crochet / 1000) * tonumber(value1)
		end
		
		-- if this event was triggered previously and still active, Luigi shoots automatically
		if activated then
			removeLuaSprite('spacebar', true);
			cancelTimer('Died')
			loogiShoot()
		end
	
		--Set values so you can dodge
		activated = true
		canDodge = true
		spacePressed = false
		
		makeLuaSprite('spacebar', loc..'DodgeMechs', 400, 480)
		setObjectCamera('spacebar', 'other');
		scaleObject('spacebar', 0.58, 0.58);
		addLuaSprite('spacebar', true)
		screenCenter('spacebar', 'x')
		setProperty('spacebar.visible', not botPlay)

		runTimer('Died', dodgeTime);
	end
end

function onUpdate(elapsed)
    if canDodge and not botPlay then
		if keyJustPressed('space') and not spacePressed then -- This code is where you are successful to dodge
			playSound('switch', 0.6)
			setProperty('spacebar.visible', false)
			runTimer('spaceBlinkIn', spaceFlashSpeed)
			dodgeTimer = 0

			spacePressed = true
		end

		if spacePressed then
			dodgeTimer = dodgeTimer + elapsed
		end
    end
end

function hit() -- This is code where you are unsuccessful to dodge
	setProperty('health', getProperty('health') -0.7); -- change the -0.5 if you want to change the amount of damage you take
	addScore(-1000)

	setProperty('boyfriend.specialAnim', false)
	characterPlayAnim('boyfriend', 'hurt', true);
	setProperty('boyfriend.specialAnim', true);
	triggerEvent('Camera Flash', 'red, 0.5', '0.3')
end

function dodge()
	setProperty('boyfriend.specialAnim', false)
	characterPlayAnim('boyfriend', 'dodge', true);
	setProperty('boyfriend.specialAnim', true);
end

function loogiShoot()
	playSound('gunshot', 0.8)
	setProperty('SecretLoog.y', 375);
	objectPlayAnimation('SecretLoog', 'Shoot', true)
	runTimer('Dance', 0.5);

	if not botPlay then
		if spacePressed then
			if dodgeTimer < 0.1 then
				addScore(5000)
				playSound('coin-special', 0.8)
				runTimer('bfHey', 0.3);
				
				makeAnimatedLuaSprite('superSprite', loc..'super', getProperty('boyfriend.x') - 150, getProperty('boyfriend.y')-60)
				addAnimationByPrefix('superSprite','super','super', 14, true);
				scaleObject('superSprite', 6, 6)
				updateHitbox('superSprite')
				setProperty('superSprite.antialiasing', false)
				setProperty('superSprite.acceleration.y', 1300)
				setProperty('superSprite.velocity.y', -400)
				setObjectOrder('superSprite', getObjectOrder('boyfriendGroup'))
				doTweenAlpha('superSpriteAlpha', 'superSprite', 0, 0.6, 'easeIn')
				addLuaSprite('superSprite', true)
			end
			dodge()

			setProperty('gf.specialAnim', false)
			characterPlayAnim('gf', 'cheer', true)
			setProperty('gf.specialAnim', true)
			setProperty('gf.heyTimer', 0.6)
			
			makeLuaSprite('dodgedSprite', loc..'dodged', getProperty('boyfriend.x') - 150, getProperty('boyfriend.y'))
			scaleObject('dodgedSprite', 6, 6)
			updateHitbox('dodgedSprite')
			setProperty('dodgedSprite.antialiasing', false)
			setProperty('dodgedSprite.acceleration.y', 1300)
			setProperty('dodgedSprite.velocity.y', -300)
			setObjectOrder('dodgedSprite', getObjectOrder('boyfriendGroup'))
			doTweenAlpha('dodgedSpriteAlpha', 'dodgedSprite', 0, 1, 'easeIn')
			addLuaSprite('dodgedSprite', true)
		else
			setProperty('gf.specialAnim', false)
			characterPlayAnim('gf', 'sad', true)
			setProperty('gf.specialAnim', true)
			hit()
		end
	else
		dodge()
	end

	canDodge = false
	spacePressed = false
	dodgeTimer = 0

	cameraShake('camGame', 0.01, 0.04)
	cameraShake('camHUD', 0.01, 0.04)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Died' then
		cancelTimer('spaceBlinkIn')
		cancelTimer('spaceBlinkOut')
		removeLuaSprite('spacebar', true);
		loogiShoot()
		activated = false
	end

    if tag == 'Dance' then
	 	objectPlayAnimation('SecretLoog', 'Idle', true)
	 	setProperty('SecretLoog.y', 445);
    end

    if tag == 'spaceBlinkIn' then
		setProperty('spacebar.visible', true)
		runTimer('spaceBlinkOut', spaceFlashSpeed)
    end
    if tag == 'spaceBlinkOut' then
		setProperty('spacebar.visible', false)
		runTimer('spaceBlinkIn', spaceFlashSpeed)
    end
    if tag == 'bfHey' then
		setProperty('boyfriend.specialAnim', false)
		characterPlayAnim('boyfriend', 'hey', true)
		setProperty('boyfriend.specialAnim', true)
		setProperty('boyfriend.heyTimer', 0.6)
    end
end

function onTweenCompleted(tag)
	if tag == 'superSpriteAlpha' then
		removeLuaSprite('superSprite', true)
	end
	if tag == 'dodgedSpriteAlpha' then
		removeLuaSprite('dodgedSprite', true)
	end
end

function onCountdownTick(counter)
	if counter % 2 == 0 then
		objectPlayAnimation('SecretLoog', 'Idle', false)
	end
end

function onBeatHit()
	if curBeat % 2 == 0 and getProperty('SecretLoog.animation.curAnim.name') == 'Idle' then
		objectPlayAnimation('SecretLoog', 'Idle', false)
	end
end