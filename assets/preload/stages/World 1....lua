local i = 25
function onCreate()

	makeLuaSprite('Backdrop', 'falseHero/mxfalse_hero_bg_sky', -600, -300);	
		addLuaSprite('Backdrop',false);
	
	makeLuaSprite('Sir Strife','falseHero/Mr.Strife',350,300);
		addLuaSprite('Sir Strife',false)
		scaleObject('Sir Strife',0.8,0.8)
		setScrollFactor('Sir Strife',0.8,0.8)

	
	makeLuaSprite('Sir Strife1','falseHero/Mr.Strife',1250,500);
		addLuaSprite('Sir Strife1',false)
		scaleObject('Sir Strife1',0.8,0.8)
		setScrollFactor('Sir Strife1',0.8,0.8)

	
	makeLuaSprite('Sir Strife2','falseHero/Mr.Strife',-300,250);
		addLuaSprite('Sir Strife2',false)
		scaleObject('Sir Strife2',0.8,0.8)
		setScrollFactor('Sir Strife2',0.8,0.8)
	
		makeLuaSprite('Hills','falseHero/mxfalse_hero_bg_hills',-600,150);
		addLuaSprite('Hills',false);
		scaleObject('Hills',0.55,0.55);
		setScrollFactor('Hills',0.9,0.9)

		makeLuaSprite('Bushes','falseHero/mxfalse_hero_bg_bushes',-500,58);
		addLuaSprite('Bushes',false);	
		scaleObject('Bushes',0.6,0.6);
		setScrollFactor('Bushes',0.95,0.95);

	makeLuaSprite('Floor','falseHero/mxfalse_hero_bg_floor',-500,65);
		addLuaSprite('Floor',false);
		scaleObject('Floor',0.6,0.6);
		setScrollFactor('Floor',0.95,0.95)

	makeLuaSprite('Shadow1','falseHero/mxfalse_hero_bg_shador',-200,220);
		addLuaSprite('Shadow1',false);
		scaleObject('Shadow1',0.5,0.5);
		

	makeLuaSprite('Shadow2','falseHero/mxfalse_hero_bg_shador2',-350,130);
		addLuaSprite('Shadow2',false);
		scaleObject('Shadow2',0.55,0.55);
		


	makeLuaSprite('DeadToadAlert','falseHero/mxfalse_hero_bg_pole',-1200,-350);
		addLuaSprite('DeadToadAlert',false);
		scaleObject('DeadToadAlert',0.9,0.9)
		setScrollFactor('DeadToadAlert',0.9,0.9);
				
   	makeLuaSprite('DeadToadAlert2','falseHero/mxfalse_hero_bg_wall',-420,-150);
		addLuaSprite('DeadToadAlert2',false);
		scaleObject('DeadToadAlert2',0.8,0.8)





end

function onUpdate(elapsed) 

	daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife.y', (math.sin(i/300)*65) + 300);
	yy = (math.sin(i/150)*15) - 300

daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife1.y', (math.sin(i/250)*65) + 400);
	yy = (math.sin(i/100)*45) - 400

daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('Sir Strife2.y', (math.sin(i/350)*65) + 500)
	yy = (math.sin(i/125)*35) - 500


	
          end

