function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-64'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'wario_game_over');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'WarioLoss');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
end