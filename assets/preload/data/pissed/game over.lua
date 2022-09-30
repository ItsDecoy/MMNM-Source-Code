function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'Mario Pissin'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
end

function onUpdatePost()
	if inGameOver then
		setProperty('updateCamera', false)
		screenCenter('boyfriend')
	end
end