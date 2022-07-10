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
		scaleObject('Bushes',0.98,0.98);
		setScrollFactor('Bushes',0.9,0.9);

	makeLuaSprite('Floor','MX/mxbgmmnm_floor',-500,0);
		addLuaSprite('Floor',false);
		
		setScrollFactor('Floor',0.95,0.95);
	
	makeLuaSprite('DeadToadAlert','MX/mxbgmmnm_pole',-750,50);
		addLuaSprite('DeadToadAlert',false);
		

		makeLuaSprite('Dead','MX/mxbgmmnm_wall',-420,100);
		addLuaSprite('Dead',false);
		scaleObject('Dead',1,1);
		setScrollFactor('Dead',0.95,0.95)
		

	
	

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

end