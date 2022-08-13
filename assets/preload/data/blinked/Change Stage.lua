function onCreate()

	   makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'ff0000')
	      addLuaSprite('flash', true);
	      setLuaSpriteScrollFactor('flash',0,0)
	      setProperty('flash.scale.x',2)
	      setProperty('flash.scale.y',2)
	      setProperty('flash.alpha',0)
	setObjectCamera('burning', 'other');

end

function onStepHit()
	if curStep == 767 then
	      setProperty('flash.alpha',1)
	setProperty('Sky.visible',false);
setProperty('Sky2.visible',true);
setProperty('Cloud.visible',false);
setProperty('Cloud2.visible',true);
setProperty('Planetoid.visible',false);
setProperty('Planetoid2.visible',true);
setProperty('Platforms.visible',false);
setProperty('Platforms2.visible',true);
setProperty('Eye.visible',true);
		doTweenAlpha('guh','flash', 0, 0.4,'linear')
	
   end

end