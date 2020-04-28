local composer = require("composer")

local M = {}

function M.new(instance, options)
	
	
	options = options or {}
	
	local parent = instance.parent
	local x, y = instance.x, instance.y
	
	instance = display.newImageRect("scene/game/img/square.png", 75, 75)
	instance.x, instance.y = x, y
	instance.isDead = false
	
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	local max, acceleration, left, right = 700, 8500, 0, 0
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
	local vx, vy = self:getLinearVelocity()
		if not self.jumping then
			self:applyLinearImpulse(0, -304)
			self.jumping = true
		elseif self.jumping and not self.doubleJump then
			self:setLinearVelocity(vx, -640)
			self.doubleJump = true
		end
	end
	
	function instance:collision(event)
		local phase = event.phase
		local other = event.other
		local vx, vy = self:getLinearVelocity()
	
		if (other.name == "zombie") then
			self:die()
		end
		
		if (phase == "began") and not (other.name == "ladder") then
			if (self.jumping and vy > 0) then
				self.jumping = false
				self.doubleJump = false
			end
		end
	end
	
	function instance:preCollision(event)
		local other = event.other
		local y1, y2 = self.y + 20, other.y - other.height/2
		if event.contact and (y1 > y2) then
			if other.isFloating then
				event.contact.isEnabled = false
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
	
	function instance:die()
		self.isDead = true
		self:finalize()
	end
	
	function instance:start()
		Runtime:addEventListener("key", key)
		Runtime:addEventListener("enterFrame", enterFrame)
	end
	
	function instance:pause()
		Runtime:removeEventListener("key", key)
		Runtime:removeEventListener("enterFrame", enterFrame)
	end
	
	function instance:finalize()
		instance:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame", enterFrame)
		Runtime:removeEventListener("key", key)	
	end
	
	instance:addEventListener("preCollision")
	instance:addEventListener("collision")
	instance:addEventListener("finalize")
	
	instance.name = "player"
	instance.type = "player"
	return instance
end

return M
	