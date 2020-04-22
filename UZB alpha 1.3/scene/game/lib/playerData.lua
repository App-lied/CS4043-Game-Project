local composer = require("composer")

local M = {}

function M.new(instance, options)
	
	
	options = options or {}
	
	local parent = instance.parent
	local x, y = instance.x, instance.y
	
	local doubleJump = 1
	
	instance = display.newImage("scene/game/img/right/mc.png")
	instance.x, instance.y = x, y
	instance.isVisible = false
	
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	local sheetData = {width = 150, height = 418, numFrames=20, sheetContentWidth = 750, sheetContentHeight = 1672}
	local sheet1 = graphics.newImageSheet( "scene/game/img/sprite sheet mc.png", sheetData )
	
	local sequenceData = {
			{name = "walk right", sheet = sheet1, frames={ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, time = 1000},
			{name = "walk left", sheet = sheet1, frames={ 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}, time = 1000}
			}
			
	local animation = display.newSprite(sheet1, sequenceData)
	animation.x, animation.y = instance.x, instance.y
	
	local gunInHandRight = display.newImage("scene/game/img/right/ruger.png")
	gunInHandRight.x, gunInHandRight.y = instance.x + 25, instance.y - 80
	gunInHandRight.isVisible = true
	local gunInHandLeft = display.newImage("scene/game/img/left/ruger.png")
	gunInHandLeft.x, gunInHandLeft.y = instance.x - 25, instance.y - 80
	gunInHandLeft.isVisible = false
	
	local function key(event)
		local phase = event.phase
		local name = event.keyName
		
			
		if (phase == "down") then
			if (name == "a") then
				instance:setLinearVelocity(-900, 0)
				aIsPressed = true
				animation:setSequence("walk left")
				animation:play()
				gunInHandRight.isVisible = false
				gunInHandLeft.isVisible = true
			elseif (name == "d") then
				instance:setLinearVelocity(900, 0)
				dIsPressed = true
				animation:setSequence("walk right")
				animation:play()
				gunInHandRight.isVisible = true
				gunInHandLeft.isVisible = false
			elseif (name == "w" ) then
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
		animation:pause()
		end
		
	end


	function instance:jump()
		local vx, vy = instance:getLinearVelocity()
		if doubleJump ~= 0 then
			if ( vx == 0) then
			doubleJump = doubleJump - 1
			self:applyLinearImpulse(0, -3000)
			else
			doubleJump = doubleJump - 1
			self:applyLinearImpulse(0, -1500)
			end
		end
	end

	
	function instance:collision(event)
		local phase = event.phase
		local other = event.other
		local vx, vy = self:getLinearVelocity()
		if (other.name == "zombie") then
			self:die()
		end
		if not (self.jumping) then
			doubleJump = 1
		end
	end
	
	
	function instance:die()
		self.isDead = true
		self:finalize()
	end
	
	function instance:start()
		Runtime:addEventListener("key", key)
	end
	
	function instance:pause()
		Runtime:removeEventListener("key", key)
	end
	
	function instance:finalize()
		instance:removeEventListener("collision")
		Runtime:removeEventListener("key", key)	
	end
	
	instance:addEventListener("collision")
	instance:addEventListener("finalize")
	
	instance.name = "player"
	instance.type = "player"
	return instance
end

return M
	