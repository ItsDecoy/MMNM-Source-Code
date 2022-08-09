function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'BF64'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'wario_game_over'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', ''); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', ''); --put in mods/music/
end