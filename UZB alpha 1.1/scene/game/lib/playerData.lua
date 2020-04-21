local composer = require("composer")

local M = {}

function M.new(instance, options)
	
	
	options = options or {}
	
	local parent = instance.parent
	local x, y = instance.x, instance.y
	
	instance = display.newImageRect("scene/game/img/square.png", 50, 50)
	instance.x, instance.y = x, y
	
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	local max, acceleration, left, right = 1000, 800, 0, 0
	local lastEvent = {}
	
	local function key(event)
		
		local phase = event.phase
		local name = event.keyName
		
		if ( phase == lastEvent.phase ) and ( name == lastEvent.keyName ) then return false end
			
		if (phase == "down") then
			if (name == "a") then
				left = -acceleration
			elseif (name == "d") then
				right = acceleration
			elseif (event.keyName == "w") then
				instance:jump()
			elseif (event.keyName == "r") then
				currentGun:reload()
			elseif (event.keyName == "1") then
				currentGun:hide()
				currentGun = gunN1
				currentGun:show()
			elseif (event.keyName == "2") then
				currentGun:hide()
				currentGun = gunN2
				currentGun:show()
			end
		elseif (phase == "up") then
			if (name == "a") then left = 0 end
			if (name == "d") then right = 0 end
		end
		
		lastEvent = event
	end


	function instance:jump()
		if not self.jumping then
			self:applyLinearImpulse(0, -100)
			self.jumping = true
		end
	end
	
	function instance:collision(event)
		local phase = event.phase
		local other = event.other
		local vx, vy = self:getLinearVelocity()
	
		if (other.name == "zombie") then
			self:die()
		end
		
		if (phase == "began") then
			if (self.jumping and vy > 0) then
				self.jumping = false
			end
		end
	end
	

	local function enterFrame()
		local vx, vy = instance:getLinearVelocity()
		local dx = left + right
		if instance.jumping then dx = dx / 4 end
		if ( dx < 0 and vx > -max ) or ( dx > 0 and vx < max ) then
			instance:applyForce( dx or 0, 0, instance.x, instance.y )
		end
		if (left == 0 and right == 0 and vy == 0) then
			instance:setLinearVelocity(0, 0)
		end
	end
	
	function instance:start()
		Runtime:addEventListener("key", key)
	end
	
	function instance:pause()
		Runtime:removeEventListener("key", key)
	end
	
	function instance:finalize()
		instance:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame", enterFrame)
		Runtime:removeEventListener("key", key)	
	end
	
	Runtime:addEventListener("enterFrame", enterFrame)
	instance:addEventListener("collision")
	instance:addEventListener("finalize")
	
	instance.name = "player"
	instance.type = "player"
	return instance
end

return M
	