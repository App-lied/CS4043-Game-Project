local M = {}

function M.new(options)
	
	local x, y = options.x or 0, options.y or 0
	local width, height = options.width or 0, options.height or 0
	
	local instance = display.newRect(x, y, width, height)
	instance:setFillColor(0, 1, 0)
	
	function instance:randomSpawnPoint()
		return math.random(self.x - (width/2), self.x + (width/2))
	end
	
	return instance
end

return M