-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local sheetData = 
{	width = 352,
	height = 600,
	numFrames=10,
	sheetContentWidth=1760,
	sheetContentHeight= 1200
}

local background = display.newImageRect("background blue.png", 1400, 1000)
background.x = display.contentCenterX
background.y = display.contentCenterY

local mySheet = graphics.newImageSheet( "charsprite.png", sheetData)

local sequenceData = {
	{name = "walk", frames={1,2,3,4,5,6,7,8,9,10}, time= 1000}
}

local animation = display.newSprite (mySheet, sequenceData)
animation.x = display.contentCenterX
animation.y = display.contentCenterY


local function onTouch(event)
	if(event.phase == "ended") then
	transition.to(animation, {x=event.x, y=event.y})
	end
end
Runtime: addEventListener("touch", onTouch)

local physics
local player
local aIsPressed 
local dIsPressed 
local spaceIsPressed 

physics = require("physics")
physics.start()
physics.setGravity(0,15)

platform = display.newImageRect("line.png", 4000, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

player = animation

physics.addBody(player, "dynamic", {bounce = 0.0})

physics.addBody(platform, "static", {bounce = 0.0})

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
end

aIsPressed = false
dIsPressed = false
spaceIsPressed = false
local function movePlayer(event)
	if (event.phase == "down") then
		animation:play()
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
		animation:pause()     
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