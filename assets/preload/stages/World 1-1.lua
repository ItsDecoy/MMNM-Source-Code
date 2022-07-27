local i = 25
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
		
	makeLuaSprite('Dead','MX/mxbgmmnm_wall',-420,100);
		addLuaSprite('Dead',false);
		scaleObject('Dead',1,1);
		setScrollFactor('Dead',0.95,0.95)

	makeLuaSprite('Shadow1','falseHero/mxfalse_hero_bg_shador',-100,780);
		addLuaSprite('Shadow1',false);
		scaleObject('Shadow1',0.58,0.58);
	

		


	makeLuaSprite('DarkBox','MX/mxbgmmnm_sky',-800,0);
		addLuaSprite('DarkBox',true);
		setObjectCamera('Darkbox','other');
		scaleObject('DarkBox',3,3)

		makeLuaSprite('Dark','MX/Boyfriend',225,100);
		addLuaSprite('Dark',true);
		scaleObject('Dark',1,1);
		setObjectCamera('Dark','other');
		doTweenAlpha('Dark','Dark',0,0.1,linear);
	
	makeLuaSprite('Dark1','MX/rapping',225,100);
		addLuaSprite('Dark1',true);
		scaleObject('Dark1',1,1);
		setObjectCamera('Dark1','other');
		doTweenAlpha('Dark1','Dark1',0,0.1,linear);

	makeLuaSprite('Dark2','MX/doesnt',225,100);
		addLuaSprite('Dark2',true);
		scaleObject('Dark2',1,1);
		setObjectCamera('Dark2','other');
		doTweenAlpha('Dark2','Dark2',0,0.1,linear);

	makeLuaSprite('Dark3','MX/get',225,100);
		addLuaSprite('Dark3',true);
		scaleObject('Dark3',1,1);
		setObjectCamera('Dark3','other');
		doTweenAlpha('Dark3','Dark3',0,0.1,linear);

	makeLuaSprite('Dark4','MX/you',225,100);
		addLuaSprite('Dark4',true);
		scaleObject('Dark4',1,1);
		setObjectCamera('Dark4','other');
		doTweenAlpha('Dark4','Dark4',0,0.1,linear);

	makeLuaSprite('Dark5','MX/Far',225,100);
		addLuaSprite('Dark5',true);
		scaleObject('Dark5',1,1);
		setObjectCamera('Dark5','other');
		doTweenAlpha('Dark5','Dark5',0,0.1,linear);
	
	
	

end
	

	function onMoveCamera(MX)

	if MX == 'dad' then
		setProperty('defaultCamZoom',0.4);
	else
		setProperty('defaultCamZoom',0.7);
	
end

function onUpdate(elapsed) 

	daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife.y', (math.sin(i/130)*65) + 600)
	yy = (math.sin(i/30)*15) - 300



daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife2.y', (math.sin(i/170)*65) + 300)
	yy = (math.sin(i/30)*35) - 300



daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife2.x', (math.sin(i/170)*65) + 700)
	xx = (math.sin(i/30)*35) - 700

daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife1.x', (math.sin(i/150)*65) + 2300)
	xx = (math.sin(i/30)*45) - 2300

end
	function onStepHit()	

	if curStep == 1 then
		doTweenAlpha('Dark','Dark',1, 0.001,linear);
end
	
	if curStep == 2 then
		doTweenAlpha('Dark', 'Dark', 0, 3.5,linear);

end

	if curStep == 64 then
		doTweenAlpha('Dark1', 'Dark1', 1, 0.001, linear);

end

	if curStep == 65 then 
		doTweenAlpha('Dark1', 'Dark1', 0, 1, linear);
end

	if curStep == 80 then
		doTweenAlpha('Dark2', 'Dark2', 1, 0.001, linear);

end

	if curStep == 81 then 
		doTweenAlpha('Dark2', 'Dark2', 0, 1, linear);
end
		
	if curStep == 96 then
		doTweenAlpha('Dark3', 'Dark3', 1, 0.001, linear);

end

	if curStep == 97 then 
		doTweenAlpha('Dark3', 'Dark3', 0, 1, linear);
end
		
	if curStep == 100 then
		doTweenAlpha('Dark4', 'Dark4', 1, 0.001, linear);

end

	if curStep == 101 then 
		doTweenAlpha('Dark4', 'Dark4', 0, 1, linear);
end
		if curStep == 112 then
		doTweenAlpha('Dark5', 'Dark5', 1, 0.001, linear);

end

	if curStep == 113 then 
		doTweenAlpha('Dark5', 'Dark5', 0, 1, linear);

end
end
end
