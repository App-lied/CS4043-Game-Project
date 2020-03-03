local background
local sheetData
local characterSheet
local sequenceData
local player
local animation
local platform
local physics
local aIsPressed 
local dIsPressed 
local spaceIsPressed
local inAir

background = display.newImageRect("background blue.png", 1400, 1000)
background.x = display.contentCenterX
background.y = display.contentCenterY

sheetData = 
{	width = 352,
	height = 600,
	numFrames=10,
	sheetContentWidth=1760,
	sheetContentHeight= 1200
}

characterSheet = graphics.newImageSheet("charsprite.png", sheetData)

sequenceData = {
	{name = "walk", frames={1,2,3,4,5,6,7,8,9,10}, time= 1000}
}

player = display.newImageRect("playerHurtbox.png", 100, 500)
player.x = display.contentCenterX
player.y = display.contentCenterY
player.isVisible = false

animation = display.newSprite (characterSheet, sequenceData)
animation.x = player.x
animation.y = player.y

platform = display.newImageRect("line.png", 4000, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

physics = require("physics")
physics.start()
physics.setGravity(0, 15)

physics.addBody(player, "dynamic", {bounce = 0.0})

physics.addBody(platform, "static", {bounce = 0.0})

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
	animation.x = player.x 
	animation.y = player.y
end

aIsPressed = false
dIsPressed = false
spaceIsPressed = false
local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "d") then
			animation:play()
			player.deltaPerFrame = {7, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			animation:play()
			player.deltaPerFrame = {-7, 0}
			aIsPressed = true
		elseif (event.keyName == "space" and not inAir) then
			player:applyLinearImpulse(0, -5, player.x, player.y)
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
		animation:pause()
	end
end

inAir = true
local function onGroundContact(event)
	if (event.phase == "began") then
		inAir = false
	elseif (event.phase == "ended") then
		inAir = true
	end
end
  
Runtime:addEventListener("enterFrame", frameUpdate)
Runtime:addEventListener("key", movePlayer)
player:addEventListener("collision", onGroundContact)