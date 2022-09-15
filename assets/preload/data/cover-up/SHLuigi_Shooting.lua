--variables
activated = false
canDodge = false

function onCreate()
	precacheImage('mafio/DodgeMechs');
	getPropertyFromClass('Controls', 'var DODGE')

	makeAnimatedLuaSprite('SecretLoog','mafio/LuigiMafia', 200, 450);
	addAnimationByPrefix('SecretLoog','Idle','Loogi Idle', 34,false);
	addAnimationByPrefix('SecretLoog','Shoot','Loogi Shoot', 34,false);
	addLuaSprite('SecretLoog',true);
	scaleObject('SecretLoog',0.65,0.65);
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
		canDodge = true;
		runTimer('Died', dodgeTime);

		makeAnimatedLuaSprite('spacebar', 'mafio/DodgeMechs', 400, 450)
		setObjectCamera('spacebar', 'other');
		scaleObject('spacebar', 0.58, 0.58);
		addLuaSprite('spacebar', true)
		setProperty('spacebar.visible', not botPlay)
	end
end

function onUpdate()
    if canDodge and keyJustPressed('space') and not botPlay then -- This code is where you are successful to dodge
		playSound('switch', 0.6)
		dodge()
		
	    setProperty('spacebar.alpha', 0.4)
    end
end

function hit() -- This is code where you are unsuccessful to dodge
	setProperty('health', getProperty('health') -0.7); -- change the -0.5 if you want to change the amount of damage you take
	characterPlayAnim('boyfriend', 'hurt', true);
	setProperty('boyfriend.specialAnim', true);
end

function dodge()
	characterPlayAnim('boyfriend', 'dodge', true);
	setProperty('boyfriend.specialAnim', true);
	canDodge = false
end

function loogiShoot()
	playSound('gunshot', 0.8)
	setProperty('SecretLoog.y', 375);
	objectPlayAnimation('SecretLoog', 'Shoot', true)
	runTimer('Dance', 0.5);

	if botPlay then
		dodge()
	else
		if canDodge then
			hit()
		end
	end
	canDodge = false
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Died' then
		removeLuaSprite('spacebar', true);
		loogiShoot()
		activated = false

    elseif tag == 'Dance' then
	 	objectPlayAnimation('SecretLoog', 'Idle', true)
	 	setProperty('SecretLoog.y', 445);
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