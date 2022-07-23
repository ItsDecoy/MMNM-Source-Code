local i =0
function onCreate()

	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1280,720,'000000')
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setLuaSpriteScrollFactor('black',0,0)
	addLuaSprite('black', true);
    
	doTweenAlpha('iconfade', 'iconP2', 0, 0.1, linear);

          setProperty("camGame.zoom",1.4) 
end

function onUpdate(elapsed) 

	daElapsed = elapsed * 30
	i = i + daElapsed
	
	setProperty('dad.y', (math.sin(i/30)*65) + 300)
	yy = (math.sin(i/30)*75) - 300
end

function onStepHit()
if curStep == 384 then
        setProperty("defaultCamZoom",0.55)
end 
if curStep == 64 then
    	doTweenAlpha('blackfade', 'black', 0, 0.7, linear);
end 
if curStep == 280 then
    	doTweenAlpha('blackfade', 'black', 1, 0.7, linear);
end 
if curStep == 384 then
	doTweenAlpha('iconfade', 'iconP2', 1, 0.7, linear);
    	doTweenAlpha('blackfade', 'black', 0, 0.7, linear);
end 
end