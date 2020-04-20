local M = {}

function M.new(gun, options) 
	
	local instance = {}
	
	local x, y = options.x, options.y
	local name, width, height = options.name or "", options.width, options.height
	
	if options.name then
		
		local name = options.name
		width, height = options.width, options.height
		local filename = "scene/game/img/"..name..".png"
		instance = display.newImageRect(filename, width, height)
		instance.x, instance.y = x, y
		
		local font = "scene/game/font/Equalize.ttf"
		instance.text = display.newText("[F] "..string.upper(gun.name), x, y, font, 22)
		instance.text.isVisible = false
		
	else
		
		width = 50
		height = 100
		instance = display.newRect(x, y, width, height)
		local colour = options.colour or {0, 0, 0}
		instance:setFillColor(unpack(colour))
		
		local font = "scene/game/font/Equalize.ttf"
		instance.text = display.newText("[F] "..gun.name, x, y - 75, font, 22)
		
	end
	
	local function mouse(event)
		
		local cornerX, cornerY = instance:localToContent(-width/2, -height/2)
		
		local bound1 = event.x > cornerX and event.x < cornerX + width
		local bound2 = event.y > cornerY and event.y < cornerY + height
		
		if (bound1 and bound2) then
			
			local x1, y1 = instance:localToContent(0, 0)
			instance.text.x = x1
			instance.text.y = y1 - 75
			instance.text.isVisible = true
		else
			instance.text.isVisible = false
		end
	end
	
	Runtime:addEventListener("mouse", mouse)
	
	return instance 
end

return M