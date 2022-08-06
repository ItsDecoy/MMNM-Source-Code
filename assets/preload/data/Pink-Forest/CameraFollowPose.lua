function onUpdatePost()
	local curAnim = getProperty('dad.animation.curAnim.name')
	local followX = 0
	local followY = 0
	
	if gfSection then
		curAnim = getProperty('gf.animation.curAnim.name')
	elseif mustHitSection then
		curAnim = getProperty('boyfriend.animation.curAnim.name')
	end
	
	if curAnim == 'singLEFT' then
		followX = -1
	elseif curAnim == 'singDOWN' then
		followY = 1
	elseif curAnim == 'singUP' then
		followY = -1
	elseif curAnim == 'singRIGHT' then
		followX = 1
	end
	setProperty('camFollowPos.x', getProperty('camFollowPos.x') + followX * 0.3);
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') + followY * 0.3);
end