local physics
local platform
local ceiling
local player
local reticle
local laser
local hook
local aIsPressed 
local dIsPressed 
local spaceIsPressed 
local inAir
local isFiring


physics = require("physics")
physics.start()
physics.setGravity(0,15)

platform = display.newImageRect("platform.png", 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

ceiling = display.newImageRect("platform.png", 300, 50)
ceiling.x = display.contentCenterX
ceiling.y = 25

player = display.newImageRect("square.png", 50, 50)
player.x = display.contentCenterX
player.y = display.contentCenterY

reticle = display.newImageRect("reticle.png", 50, 50)
reticle.x = display.contentCenterX
reticle.y = display.contentCenterY

hook = display.newImageRect("hook.png", 25, 25)
hook.x = player.x
hook.y = player.y
hook.isVisible = false

physics.addBody(player, "dynamic", {bounce = 0.0})
physics.addBody(platform, "static", {bounce = 0.0})
physics.addBody(ceiling, "static", {bounce = 0.0})

physics.addBody(hook, "dynamic")
hook.isBodyActive = false
hook.isSensor = true
hook.isBullet = true

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
	
	hook.x = player.x
	hook.y = player.y
	
	if (isFiring) then
		fireLaser()
	end
end

local function onMouseAction(event)
	reticle.x = event.x
	reticle.y = event.y
	
	if event.isPrimaryButtonDown then
		isFiring = true
	else 
		isFiring = false
	end
end

function fireLaser()
    local newLaser = display.newImageRect("laser.png", 15, 40)
    newLaser.isBullet = true
    newLaser.myName = "laser"

    newLaser.x = player.x
    newLaser.y = player.y
    newLaser:toBack()
	
	local y1 = player.y
	local x1 = player.x
	
      local length = math.sqrt((reticle.x-x1)^2+(reticle.y-y1)^2)
      local degrees = math.deg(math.atan(math.abs(reticle.y-y1)/math.abs(reticle.x-x1)))
      if (reticle.y<y1) then
        if(reticle.x>x1) then
          newLaser.rotation = 180-degrees+90
        else
          newLaser.rotation = degrees+90
        end
      end
      if (reticle.y>=y1) then
        if(reticle.x>x1) then
          newLaser.rotation = degrees+90
        else
          newLaser.rotation = 360-degrees+90
        end
      end

      local x2 = (5*reticle.x-(4*x1))/(1)
      local y2 = (5*reticle.y-(4*y1))/(1)
      transition.to( newLaser, {x=x2, y=y2, time=length*2,
          onComplete = function()display.remove(newLaser)end
      })
end

local function fireHook()
	hook.isVisible = true
	hook.isBodyActive = true
	transition.to(hook, {x = reticle.x, y = reticle.y, time = 300,
		onComplete = function() hook.isVisible = false
		hook.isBodyActive = false
		end
	})
end

local function onHookCollision(event)
	if (not (event.other == player)) then
		transition.to(player, {x = event.target.x, y = event.target.y, time = 300})
	end
end

local function onLanding(event)	 
	if(event.phase == "began") then
		inAir = false
	elseif(event.phase == "ended") then
		inAir = true
	end
end

aIsPressed = false
dIsPressed = false
spaceIsPressed = false
local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "d") then
			player.deltaPerFrame = {3.5, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			player.deltaPerFrame = {-3.5, 0}
			aIsPressed = true
		elseif (event.keyName == "space" and not inAir) then
			player:applyLinearImpulse(0, -0.2, player.x, player.y)
			spaceIsPressed = true
		elseif (event.keyName == "e") then
			fireHook()
		end
	end
	if (event.phase == "up") then
		if (event.keyName == "d") then
			dIsPressed = false
		elseif (event.keyName == "a") then
			aIsPressed = false
		end
	end
	if not(dIsPressed or aIsPressed) then
		player.deltaPerFrame = {0, 0}
	end
end
  
Runtime:addEventListener("enterFrame", frameUpdate)
Runtime:addEventListener("key", movePlayer)
Runtime:addEventListener("mouse", onMouseAction)
hook:addEventListener("collision", onHookCollision)
player:addEventListener("collision", onLanding)
		