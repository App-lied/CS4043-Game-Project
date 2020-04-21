

local M = {}

function M.new(instance, options)
	
	
	options = options or {}
	
	local parent = instance.parent
	local x, y = instance.x, instance.y
	local doubleJump = 1
	
	instance = display.newImageRect("scene/game/img/square.png", 50, 50)
	instance.x, instance.y = x, y
	instance.isVisible = true
	
	instance2 = display.newImage("scene/game/img/left/mc.png")
	instance2.isVisible = false
	
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	
	aIsPressed = false
	dIsPressed = false
	
	local function key(event)
		
		local phase = event.phase
		local name = event.keyName
		
			
		if (phase == "down") then
			if (name == "a") then
				instance:setLinearVelocity(-900, 0)
				aIsPressed = true
				instance2.isVisible = true
				instance.isVisible = false
				instance2.x, instance2.y = instance.x, instance.y
			elseif (name == "d") then
				instance:setLinearVelocity(900, 0)
				dIsPressed = true
				instance2.isVisible = false
				instance.isVisible = true
				instance2.x, instance2.y = instance.x, instance.y
			elseif (event.keyName == "w" ) then
				instance:jump()
			end
		return true
		end
		if (phase == "up") then
			if (name == "a") then 
			aIsPressed = false
			end
			if (name == "d") then 
			dIsPressed = false
			end
		end
		if not(dIsPressed or aIsPressed ) then
		instance:setLinearVelocity(0, 0)
		end
		
	end


	function instance:jump()
		local vx, vy = instance:getLinearVelocity()
		if doubleJump ~= 0 then
			if ( vx == 0) then
			doubleJump = doubleJump - 1
			self:applyLinearImpulse(0, -7000)
			else
			doubleJump = doubleJump - 1
			self:applyLinearImpulse(0, -3500)
			end
		end
	end
	
	function instance:collision(event)
		local phase = event.phase
		local other = event.other
		local vx, vy = self:getLinearVelocity()
	
		if (phase == "began") then
			if (self.jumping and vy > 0) then
				self.jumping = false
			end
		end
	end
	

	Runtime:addEventListener("key", key)
	instance:addEventListener("collision")
	
	instance.name = "player"
	instance.type = "player"
	return instance
end

return M
	
