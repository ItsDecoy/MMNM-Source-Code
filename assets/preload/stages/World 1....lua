local i = 0

function onCreate()
	local location = 'stages/falsehero/'

	makeLuaSprite('Backdrop', location..'mxfalse_hero_bg_sky', -600, -300);	
	addLuaSprite('Backdrop',false);
	
	makeLuaSprite('Sir Strife',location..'Mr.Strife',350,300);
	addLuaSprite('Sir Strife',false)
	scaleObject('Sir Strife',0.8,0.8)
	setScrollFactor('Sir Strife',0.8,0.8)
	
	makeLuaSprite('Sir Strife1',location..'Mr.Strife',1050,300);
	addLuaSprite('Sir Strife1',false)
	scaleObject('Sir Strife1',0.8,0.8)
	setScrollFactor('Sir Strife1',0.8,0.8)
	
	makeLuaSprite('Sir Strife2',location..'Mr.Strife',-300,250);
	addLuaSprite('Sir Strife2',false)
	scaleObject('Sir Strife2',0.8,0.8)
	setScrollFactor('Sir Strife2',0.8,0.8)
	
	makeLuaSprite('Hills',location..'mxfalse_hero_bg_hills',-600,150);
	addLuaSprite('Hills',false);
	scaleObject('Hills',0.55,0.55);
	setScrollFactor('Hills',0.9,0.9)

	makeLuaSprite('Bushes',location..'mxfalse_hero_bg_bushes',-500,58);
	addLuaSprite('Bushes',false);	
	scaleObject('Bushes',0.6,0.6);
	setScrollFactor('Bushes',0.95,0.95);

	makeLuaSprite('Floor',location..'mxfalse_hero_bg_floor',-500,65);
	addLuaSprite('Floor',false);
	scaleObject('Floor',0.6,0.6);
	setScrollFactor('Floor',0.95,0.95)

	makeLuaSprite('Shadow1',location..'mxfalse_hero_bg_shador',-210,160);
	addLuaSprite('Shadow1',false);
	scaleObject('Shadow1',0.53,0.53);

	makeLuaSprite('Shadow2',location..'mxfalse_hero_bg_shador2',-730,-120);
	addLuaSprite('Shadow2',false);
	scaleObject('Shadow2',0.7,0.7);

	makeLuaSprite('DeadToadAlert',location..'mxfalse_hero_bg_pole',-1200,-350);
	addLuaSprite('DeadToadAlert',false);
	scaleObject('DeadToadAlert',0.9,0.9)
	setScrollFactor('DeadToadAlert',0.9,0.9);
	
   	makeLuaSprite('DeadToadAlert2',location..'mxfalse_hero_bg_wall',-200,-170);
	addLuaSprite('DeadToadAlert2',false);
	scaleObject('DeadToadAlert2',0.8,0.8);

	makeAnimatedLuaSprite('Lucas',location..'Lucas_FalseH', -100, 500);
	addAnimationByPrefix('Lucas','idle','Lucas Dance',24,false);
	addLuaSprite('Lucas', false);
	scaleObject('Lucas', 0.8, 0.8);
end

function onUpdate(elapsed) 
	i = i + elapsed
	
	setProperty('Sir Strife.y', (math.sin(i/2)*30) + 300)
	setProperty('Sir Strife1.x', (math.sin(0.3 + i/2)*65) + 1400);
	setProperty('Sir Strife2.y', (math.sin(0.5 + i/2)*30) + 500)
end

function onCountdownTick(counter)
	objectPlayAnimation('Lucas', 'idle', true)
end

function onBeatHit()
	objectPlayAnimation('Lucas', 'idle', true)
end