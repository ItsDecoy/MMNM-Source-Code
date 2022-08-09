local defaultZoom

function onCreatePost()
	defaultZoom = getProperty('defaultCamZoom')
end

function onEvent(name, value1, value2)
	if name == 'Set Default Camera Zoom' then
		if value1 == '' then
			setProperty('defaultCamZoom', defaultZoom)
		else
			setProperty('defaultCamZoom', defaultZoom * value1)
		end
	end
end