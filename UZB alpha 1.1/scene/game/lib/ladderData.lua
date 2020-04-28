local M = {}

function M.new(options)
	
	local instance = {}
	local x, y, width, height
	
	x = options.x or 0
	y = options.y or 0
	width = options.width or 0
	height = options.height or 0
	
	instance = display.newRect(x, y, width, height)
	
	physics.addBody(instance, "static", {isSensor = true})
	
	instance.velo = options.velo or -1400
	instance.always = options.always or false
	
	instance.name = "ladder"
	instance.type = "ladder"
	
	return instance
end

return M