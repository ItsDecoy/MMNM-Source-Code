function onCreatePost()
	addCharacterToList('bf-dead-mx', 'bf')
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead-mx')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_mx')
end

function onGameOverStart()
	cameraFlash('camHUD', 'ff0000', '1')
	
	makeLuaSprite('gameOverBlack', '', -1000, -1000)
	makeGraphic('gameOverBlack', 3000, 3000, '000000')
	setScrollFactor('gameOverBlack', 0, 0)
	addLuaSprite('gameOverBlack', true)
	runTimer('ohhello', 1)
end

function onUpdatePost(elapsed)
	if inGameOver then
		setProperty('updateCamera', false)
		setProperty('camFollowPos.x', getProperty('camFollow.x') - 160)
		setProperty('camFollowPos.y', getProperty('camFollow.y') - 60)
	end
end

function onTimerCompleted(tag)
	if tag == 'ohhello' then
		doTweenAlpha('gameOverBlack', 'gameOverBlack', 0, 2, 'linear')
	end
end