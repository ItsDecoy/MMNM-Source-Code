onStompFrame = false

function onUpdatePost(elapsed)
    if getProperty('dad.curCharacter') == 'mx'
	and getProperty('dad.animation.curAnim.name') == 'Stomp'
	and getProperty('dad.animation.curAnim.curFrame') == 10 then
        if not onStompFrame then
            stomp()
            onStompFrame = true;
        end
    else onStompFrame = false end
end

function stomp() -- Mx Stomps
    playSound('ANGRY_TEXT_BOX', 0.5)
	cameraShake('camHUD', 0.03, 0.06)
	cameraShake('camGame', 0.03, 0.06)
end