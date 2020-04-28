local composer = require("composer")

local M = {}

function M.new(options)

	local scene = composer.getScene(composer.getSceneName("current"))
	local zombieSound1 = audio.loadStream( "zombie_sound1.wav")
	local zombieSound2 = audio.loadStream( "zombie_sound2.wav")
	local zombieSound3 = audio.loadStream( "zombie_sound3.wav")
	local zombieSound4 = audio.loadStream( "zombie_sound4.wav")
	
	local instance = {}
	
	local health = options.health or 500
	local points = options.points or 100
	
	instance = display.newImageRect("scene/game/img/redSquare.png", 75, 75)
	physics.addBody(instance, "dynamic", {bounce = 0.0, density = 2.0})
	instance.isFixedRotation = true
	
	instance.isDead = false
	local canMove = true
	local x, y = options.x or 0, options.y or 0
	
	--spawn points
	-- if room == 1 then x, y = math.random(3430, 3530), 730
	-- elseif room == 2 then x, y = math.random(1270, 3030), 1530
	-- elseif room == 3 then x, y = math.random(3450, 4100), 1530
	-- elseif room == 4 then x, y = math.random(50, 850), 2700
	-- elseif room == 5 then x, y = math.random(1500, 3000), 2700
	-- elseif room == 6 then x, y = math.random(3500, 4400), 2700
	-- elseif room == 7 then x, y = math.random(1150, 2700), 3600
	-- end
	
	instance.x, instance.y = x, y
	
	function instance:preCollision(event)
		local other = event.other
		local y1, y2 = self.y + 20, other.y - other.height/2
		if event.contact and (y1 > y2) then
			if other.isFloating then
				event.contact.isEnabled = false
			end
		end
	end
	
	function instance:collision(event)
		local randSound = 3
			if randSound == 1 then
				audio.play( zombieSound1 )
			elseif randSound == 2 then
				audio.play( zombieSound2 )
			elseif randSound == 3 then
				audio.play( zombieSound3 )
			elseif randSound == 4 then
				audio.play( zombieSound4 )
			end
		local phase = event.phase
		local other = event.other
		
		if (phase == "began" and other.myName == "laser") then
			if not currentGun.canPierce then
				display.remove(other)
			end
			self:damage()
		end	
		
		if (phase == "began" and other.name == "ladder") then
			local diff = display.contentCenterY - self.y
			if (diff < -700) then
				canMove = false
				self:setLinearVelocity(0, other.velo)
			end
		end
	end
	
	function instance:damage()
		local randSound = math.random(4)
			if randSound == 1 then
				audio.play( zombieSound1 )
			elseif randSound == 2 then
				audio.play( zombieSound2 )
			elseif randSound == 3 then
				audio.play( zombieSound3 )
			elseif randSound == 4 then
				audio.play( zombieSound4 )
			end
				
		health = health - currentGun.damage
		
		if (health < 1) then
			self:die()
		end
	end
	
	local function enterFrame()
	
		if (display.contentCenterY - instance.y > -500) then
			canMove = true
		end
		
		if canMove then
			local vx, vy = instance:getLinearVelocity()
			local x1 = display.contentCenterX
			if instance.x < x1 then
				instance:setLinearVelocity(250, vy)
			elseif instance.x > x1 then
				instance:setLinearVelocity(-250, vy)
			elseif instance.x == x1 then
				instance:setLinearVelocity(0, vy)
			end
		end
	end
	
	function instance:die()
		self.isDead = true
		scene.score:add(points)
		scene.score:killZombie()
		self:removeSelf()
		self:finalize()
	end
	
	function instance:finalize(event)
		Runtime:removeEventListener("enterFrame", enterFrame)
		instance = nil
	end
	
	instance:addEventListener("preCollision", preCollision)
	instance:addEventListener("collision")
	Runtime:addEventListener("enterFrame", enterFrame)
	instance:addEventListener("finalize")
	
	instance.name = "zombie"
	instance.type = "zombie"
	
	return instance
end

return M