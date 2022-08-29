local barScale = 1
local slamHealthGain = 1

function onCreatePost()
	slamHealthGain = getProperty('healthGain')
	if slamHealthGain > 1 then
		slamHealthGain = 1
	end
	for i=0,3 do
		setPropertyFromGroup('opponentStrums', i, 'x', -500)
	end
	setProperty('healthGain', getProperty('healthGain') * 0.5)
	setProperty('camHUD.alpha', 0)
end

function onUpdatePost()
	if curBeat >= 30 and curBeat < 32 then
		barScale = barScale + (1.7 - barScale) * 0.065
		
		setProperty('healthBarBG.scale.x', barScale)
		setProperty('healthBar.scale.x', barScale)
	
		updateHitbox('healthBarBG')
		updateHitbox('healthBar')
	end	
	
	setProperty('healthBarBG.x', (screenWidth * 0.5) - (getProperty('healthBarBG.width') * 0.5))
	setProperty('healthBar.x', (screenWidth * 0.5) - (getProperty('healthBar.width') * 0.5))
end