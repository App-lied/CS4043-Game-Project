-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics
local platform
local player
local reticle
local aIsPressed 
local dIsPressed 
local spaceIsPressed 


physics = require("physics")
physics.start()
physics.setGravity(0,15)

platform = display.newImageRect("platform.png", 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

player = display.newImageRect("square.png", 50, 50)
player.x = display.contentCenterX
player.y = display.contentCenterY

reticle = display.newImageRect("reticle.png", 50, 50)
reticle.x = display.contentCenterX
reticle.y = display.contentCenterY

physics.addBody(player, "dynamic", {bounce = 0.0})
physics.addBody(platform, "static", {bounce = 0.0})

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
end

local function onMouseAction(event)
	reticle.x = event.x
	reticle.y = event.y
	
	if event.isPrimaryButtonDown then
		--code to fire bullet
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
		elseif (event.keyName == "space" and event.phase == "down") then
			player:applyLinearImpulse(0, -0.2, player.x, player.y)
			spaceIsPressed = true
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

		