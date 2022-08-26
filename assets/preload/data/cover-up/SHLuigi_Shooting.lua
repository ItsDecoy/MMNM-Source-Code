function onCreate()
    --variables
	Dodged = false;
    canDodge = false;
    DodgeTime = 0;
	precacheImage('mafio/DodgeMechs');
	getPropertyFromClass('Controls', 'var DODGE')

	makeAnimatedLuaSprite('SecretLoog','mafio/LuigiMafia',200,450);
	addAnimationByPrefix('SecretLoog','Idle','Loogi Idle',24,true);
	addAnimationByPrefix('SecretLoog','Shoot','Loogi Shoot',24,false);
	addLuaSprite('SecretLoog',true);
	scaleObject('SecretLoog',0.65,0.65);

end

function onEvent(name, value1, value2)
    if name == "SHLuigi Shooting" then
	cancelTimer('shoot')
    --Get Dodge time
    DodgeTime = (value1);
	
	--Set values so you can dodge
	canDodge = true;
	runTimer('Died', 0.5);
    runTimer('Dance', 0.8);
	makeAnimatedLuaSprite('spacebar', 'mafio/DodgeMechs', 400, 450)
    setObjectCamera('spacebar', 'other');
    scaleObject('spacebar', 0.58, 0.58);
	addLuaSprite('spacebar', true)
	end
end
	
function onUpdate()
   if canDodge == true and keyPressed('space') then -- This code is where you are successful to dodge
   
   removeLuaSprite('spacebar');
   Dodged = true;
   objectPlayAnimation('SecretLoog', 'Shoot', false)
   characterPlayAnim('boyfriend', 'dodge', true);
   setProperty('boyfriend.specialAnim', true);
   setProperty('SecretLoog.y', 375);
   canDodge = false
   setProperty('health', getProperty('health'), 0.5);
   playSound('gunshot', 0.8)
   end
end

function onTimerCompleted(tag, loops, loopsLeft) -- This is code where you are unsuccessful to dodge
   if tag == 'Died' and Dodged == false then
   setProperty('health', getProperty('health') -0.7); -- change the -0.5 if you want to change the amount of damage you take
   characterPlayAnim('boyfriend', 'hurt', true);
   setProperty('boyfriend.specialAnim', true);
   setProperty('SecretLoog.y', 375);
   objectPlayAnimation('SecretLoog', 'Shoot', false)
   canDodge = false
   removeLuaSprite('spacebar');
   playSound('gunshot', 0.8);
   runTimer('Dance', 0.5);
   
   elseif tag == 'Died' and Dodged == true then
   Dodged = false

   elseif tag == 'Dance' then
    objectPlayAnimation('SecretLoog', 'Idle', true)
    setProperty('SecretLoog.y', 445);
    
   end
end