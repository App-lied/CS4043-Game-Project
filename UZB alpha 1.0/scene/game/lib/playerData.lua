

local M = {}

function M.new(instance, options)
	
	
	options = options or {}
	
	local parent = instance.parent
	local x, y = instance.x, instance.y
	
	local doubleJump = 1
	
	instance = display.newImage("scene/game/img/right/mc.png")
	instance.x, instance.y = x, y
	instance.isVisible = true
	
	instance2 = display.newImage("scene/game/img/left/mc.png")
	instance2.isVisible = false
	
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	local sheetData1 = {width = 150, height = 418, numFrames=10, sheetContentWidth = 750, sheetContentHeight = 836}
	local sheet1 = graphics.newImageSheet("scene/game/img/right/right sprite.png", sheetData1)
	local sheetData2 = {width = 150, height = 418, numFrames=10, sheetContentWidth = 750, sheetContentHeight = 836}
	local sheet2 = graphics.newImageSheet("scene/game/img/left/left sprite.png", sheetData2)
	
	local sequenceData = {
			{name = "walk right", sheet = sheet1, frames={ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, time = 1000},
			{name = "walk left", sheet = sheet2, frames={ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, time = 1000}
			}
			
	local animationLeft = display.newSprite(sheet2, sequenceData)
	local animationRight = display.newSprite(sheet1, sequenceData)
	animationLeft.isVisible = false
	animationRight.isVisible = false
	aIsPressed = false
	dIsPressed = false
	
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
				instance:setLinearVelocity(-9000, 0)
				aIsPressed = true
				instance2.isVisible = false
				instance.isVisible = false
				animationLeft:play()
				animationRight:pause()
				animationLeft.isVisible = true
				animationRight.isVisible = false
				instance2.x, instance2.y = instance.x, instance.y
				animationLeft.x, animationLeft.y = instance.x, instance.y
				gunInHandRight.isVisible = false
				gunInHandLeft.isVisible = true
			elseif (name == "d") then
				instance:setLinearVelocity(9000, 0)
				dIsPressed = true
				instance2.isVisible = false
				instance.isVisible = false
				animationRight:play()
				animationLeft:pause()
				animationLeft.isVisible = false
				animationRight.isVisible = true
				instance2.x, instance2.y = instance.x, instance.y
				animationRight.x, animationRight.y = instance.x, instance.y
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
			animationRight:pause()
			animationLeft:pause()
			end
			if (name == "d") then 
			dIsPressed = false
			animationRight:pause()
			animationLeft:pause()
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
		if not (self.jumping) then
			doubleJump = 1
		end
	end
	

	Runtime:addEventListener("key", key)
	instance:addEventListener("collision")
	
	instance.name = "player"
	instance.type = "player"
	return instance
end

return M
