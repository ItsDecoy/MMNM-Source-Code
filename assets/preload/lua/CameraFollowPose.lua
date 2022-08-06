function onUpdatePost()
	local curAnim = getProperty('dad.animation.curAnim.name')
	local followX = 0
	local followY = 0
	
	if gfSection then
		curAnim = getProperty('gf.animation.curAnim.name')
	elseif mustHitSection then
		curAnim = getProperty('boyfriend.animation.curAnim.name')
	end
	
	if curAnim == 'singLEFT' or curAnim == 'singLEFT-alt' then
		followX = -1
	elseif curAnim == 'singDOWN' or curAnim == 'singDOWN-alt' then
		followY = 1
	elseif curAnim == 'singUP' or curAnim == 'singUP-alt' then
		followY = -1
	elseif curAnim == 'singRIGHT' or curAnim == 'singRIGHT-alt' then
		followX = 1
	end
	
	local move = 0.1
	
	setProperty('camFollowPos.x', getProperty('camFollowPos.x') + followX * move);
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') + followY * move);
end