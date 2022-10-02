function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'vicdead'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'VICTIM_2');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', '');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
end

function onUpdatePost()
	if inGameOver then
		setProperty('updateCamera', false)
		screenCenter('boyfriend')
	end
end