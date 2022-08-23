function onCreate()
    --variables
	Dodged = false;
    canDodge = false;
    DodgeTime = 0;
	precacheImage('mafio/DodgeMechs');
	getPropertyFromClass('Controls', 'var DODGE')
end

function onEvent(name, value1, value2)
    if name == "SHLuigi Shooting" then
	cancelTimer('shoot')
    --Get Dodge time
    DodgeTime = (value1);
	
	--Set values so you can dodge
	canDodge = true;
	runTimer('timer', 0.4);
	makeAnimatedLuaSprite('bONES', 'mafio/DodgeMechs', 550, 325)
	addLuaSprite('bONES', true)
	end
end

	function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'timer' then
	
	runTimer('Died', DodgeTime);
	
function onUpdate()
   if canDodge == true and keyPressed('space') then -- This code is where you are successful to dodge
   
   removeLuaSprite('bONES', false)
   Dodged = true;
   characterPlayAnim('boyfriend', 'dodge', true);
   setProperty('boyfriend.specialAnim', true);
   canDodge = false
   makeAnimatedLuaSprite('DODGE', 'mafio/DodgeMechs', 550, 375);
   addLuaSprite('DODGE', true);
   luaSpriteAddAnimationByPrefix('DODGE', 'bon', 'Bones boi instance', 24, false);
   setProperty('health', getProperty('health'), 0.5);
   end
end

function onTimerCompleted(tag, loops, loopsLeft) -- This is code where you are unsuccessful to dodge
   if tag == 'Died' and Dodged == false then
   setProperty('health', getProperty('health') -0.6); -- change the -0.5 if you want to change the amount of damage you take
   characterPlayAnim('boyfriend', 'hurt', true);
   setProperty('boyfriend.specialAnim', true);
   canDodge = false
   makeAnimatedLuaSprite('DODGE', 'mafio/DodgeMechs', 550, 375)
   addLuaSprite('DODGE', true);
   luaSpriteAddAnimationByPrefix('DODGE', 'bon', 'Bones boi instance', 24, false);
   
   elseif tag == 'Died' and Dodged == true then
   Dodged = false
			end
		end
	end
end