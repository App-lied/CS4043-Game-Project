local M = {}

function M.new(options)

	local instance = {}
	instance.health = options.health or 500
	local room = options.room or math.random(9)
	
	instance = display.newImageRect("scene/game/img/redSquare.png", 50, 50)
	physics.addBody(instance, "dynamic", {bounce = 0.0})
	
	local x, y
	
	--spawn points
	if room == 1 then x, y = math.random(3500, 4500), 100
	elseif room == 2 then x, y = math.random(1500, 3000), 900
	elseif room == 3 then x, y = math.random(3500, 4500), 900
	elseif room == 4 then x, y = math.random(-100, 500), 1650
	elseif room == 5 then x, y = math.random(1500, 3000), 1850
	elseif room == 6 then x, y = math.random(3500, 3750), 1650
	elseif room == 7 then x, y = math.random(3500, 4500), 3750
	elseif room == 8 then x, y = math.random(1500, 3000), 3750
	elseif room == 9 then x, y = math.random(1000), 3750
	end
	
	instance.x, instance.y = x, y
	
	function instance:collision(event)
		local phase = event.phase
		local other = event.other
		
		if (other.myName == "laser") then
			self:damage()
		end	
	end
	
	function instance:damage()
		self.health = self.health - currentGun:getDamage()
		
		if (self.health < 1) then
			self:die()
		end
	end
	
	function instance:die()
		self:removeSelf()
	end
	
	function instance:finalize(event)
		instance = nil
	end
	
	instance:addEventListener("finalize")
	instance:addEventListener("collision")
	
	instance.name = "zombie"
	instance.type = "zombie"
	
	return instance
end

return M