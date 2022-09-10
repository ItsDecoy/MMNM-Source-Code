local i = 0

function onCreate()
	makeLuaSprite('Backdrop', 'MX/mxbgmmnm_sky', -600, -300);	
	addLuaSprite('Backdrop',false);
	
	makeAnimatedLuaSprite('Sir Strife','MX/Mr.Strife Alive',-300,600);
	addAnimationByPrefix('Sir Strife','wiggle','Scary_Cloud',24,true);
	addLuaSprite('Sir Strife',false);
	scaleObject('Sir Strife',1.1,1.1);
	setScrollFactor('Sir Strife',0.8,0.8);

	makeAnimatedLuaSprite('Sir Strife1','MX/Mr.Strife Alive',2450,-100);
	addAnimationByPrefix('Sir Strife1','wiggle','Scary_Cloud',24,true);
	addLuaSprite('Sir Strife1',false);
	scaleObject('Sir Strife1',1.5,1.5);
	setScrollFactor('Sir Strife1',0.65,0.65);

	makeAnimatedLuaSprite('Sir Strife2','MX/Mr.Strife Alive',550,200);
	addAnimationByPrefix('Sir Strife2','wiggle','Scary_Cloud',24,true);
	addLuaSprite('Sir Strife2',false);
	scaleObject('Sir Strife2',1.3,1.3);
	setScrollFactor('Sir Strife2',0.8,0.8);
	
	makeAnimatedLuaSprite('Hills','MX/bushanim',-600,150);
	addAnimationByPrefix('Hills','Blink','blink',8,true);
	addLuaSprite('Hills',false);
	scaleObject('Hills',0.98,0.98);
	setScrollFactor('Hills',0.8,0.8);

	makeLuaSprite('Bushes','MX/mxbgmmnm_bushes',-500,58);
	addLuaSprite('Bushes',false);	
	scaleObject('Bushes',0.95,0.95);
	setScrollFactor('Bushes',0.9,0.9);

	makeLuaSprite('Floor','MX/mxbgmmnm_floor',-500,0);
	addLuaSprite('Floor',false);
	setScrollFactor('Floor',0.99,0.99);

	makeLuaSprite('Shadow2','falseHero/mxfalse_hero_bg_shador2',-2650,-1405);
	addLuaSprite('Shadow2',false);
	scaleObject('Shadow2',1.85,1.85);
	
	makeLuaSprite('DeadToadAlert','MX/mxbgmmnm_pole',-750,50);
	addLuaSprite('DeadToadAlert',false);

	makeLuaSprite('Toad','MX/deadtoad',1350, 750);
	addLuaSprite('Toad',false);
	scaleObject('Toad',1.1,1.1);

	makeAnimatedLuaSprite('Lucas', 'MX/Lucas_HerosDoom', -20, 910);
	addAnimationByPrefix('Lucas', 'idleScared','Lucas Scared sad', 24, true);
	addLuaSprite('Lucas',false);
	scaleObject('Lucas', 0.8,0.8)
	setScrollFactor('Lucas', 0.95, 0.95)
		
	makeLuaSprite('Dead','MX/mxbgmmnm_wall',-220,50);
	addLuaSprite('Dead',false);
	scaleObject('Dead',1,1);
	setScrollFactor('Dead',0.95,0.95)

	makeLuaSprite('Hand', 'MX/handofgod', -95, 750);
	addLuaSprite('Hand',false);
	scaleObject('Hand', 0.8, 0.8);
	setScrollFactor('Hand',0.95, 0.95 )
	

	makeLuaSprite('Shadow1','falseHero/mxfalse_hero_bg_shador',-100,780);
	addLuaSprite('Shadow1',false);
	scaleObject('Shadow1',0.58,0.58);

end
	
function onMoveCamera(MX)
	if MX == 'dad' then
		setProperty('defaultCamZoom',0.4);
	else
		setProperty('defaultCamZoom',0.7);
	end
end

function onUpdate(elapsed)
	i = i + elapsed
	
	setProperty('Sir Strife.y', (math.sin(i)*65) + 600)
	setProperty('Sir Strife2.y', (math.sin(i)*65) + 300)
	setProperty('Sir Strife2.x', (math.sin(i+0.5)*65) + 700)
	setProperty('Sir Strife1.x', (math.sin(i)*65) + 2300)
end