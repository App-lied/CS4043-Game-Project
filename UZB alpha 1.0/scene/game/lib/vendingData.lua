local M = {}

function M.new(gun, options) 
	
	local instance = {}
	
	local x, y = options.x, options.y
	
	if options.name then
		
		local name = options.name
	else
		
		instance = display.newRect(x, y, 50, 100)
		
		local font = "scene/game/font/Equalize.ttf"
		instance.text = display.newText("[F]"..gun.name, x, y + 75, font, 22)
		
	end
	
end