function onCreatePost()
	addCharacterToList('lucasDeath', 'bf')
	setPropertyFromClass('GameOverSubstate', 'characterName', 'lucasDeath')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_mx')
end


function onUpdatePost(elapsed)
	if inGameOver then
		setProperty('updateCamera', false)
		setProperty('camFollowPos.x', getProperty('camFollow.x') - 80)
		setProperty('camFollowPos.y', getProperty('camFollow.y') - 120)
	end
end