local composer = require("composer")
local gunData = require("scene.game.lib.gunData")

local M = {}

function M.new(instance, options)


	options = options or {}
	
	instance.isVisible = false
	local parent = instance.parent
	local x, y = instance.x, instance.y
	local gun = currentGun.name
		
	local sheetData = {width = 90, height = 250, numFrames=20, sheetContentWidth = 450, sheetContentHeight = 1000}
	local sheet1 = graphics.newImageSheet( "scene/game/img/250x sprite mc.png", sheetData )
	
	local sequenceData = {
			{name = "walk right", sheet = sheet1, frames={ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, time = 1000},
			{name = "walk left", sheet = sheet1, frames={ 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}, time = 1000}
			}
			
	instance = display.newSprite(sheet1, sequenceData)
	instance.x, instance.y = x, y
	instance.isDead = false

	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0, radius = 45})
	instance.isFixedRotation = true
	instance.anchorY = 0.82
	
	local gunInHandLeft = "scene/game/img/gunsInHand/left/".. gun ..".png"
	local gunInHandRight = "scene/game/img/gunsInHand/right/".. gun ..".png"
	local leftHand = display.newImage(gunInHandLeft)
	local rightHand = display.newImage(gunInHandRight)
	leftHand.x, leftHand.y = instance.x - 3 , instance.y - 32
	rightHand.x, rightHand.y = instance.x + 3 , instance.y - 32
	leftHand.isVisible = false
	rightHand.isVisible = true


	local max, acceleration, left, right = 700, 8500, 0, 0
	local lastEvent = {}

	local function key(event)

		local phase = event.phase
		local name = event.keyName

		if ( phase == lastEvent.phase ) and ( name == lastEvent.keyName ) then return false end

		if (phase == "down") then
			if (name == "a") then
				left = -acceleration
				aIsPressed = true
				instance:setSequence("walk left")
				leftHand.isVisible = true
				rightHand.isVisible = false
			elseif (name == "d") then
				right = acceleration
				dIsPressed = true
				instance:setSequence("walk right")
				leftHand.isVisible = false
				rightHand.isVisible = true
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
			if (name == "a") then 
			left = 0 
			aIsPressed = false
			end
			if (name == "d") then 
			right = 0 
			IsPressed = false
			end
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
			instance:play()
			instance:applyForce( dx or 0, 0, instance.x, instance.y )
		end
		if (left == 0 and right == 0 and vy == 0) then
			instance:setLinearVelocity(0, 0)
			instance:pause()
		end
	end

	function instance:die()
		self.isDead = true
		instance:pause()
		leftHand.isVisible = false
		rightHand.isVisible = false
		self:finalize()
		composer.gotoScene( "scene.HighScore", { time=1800, effect="crossFade" } )
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
