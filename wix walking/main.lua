-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local sheetData = 
{	width = 250,
	height = 558,
	numFrames=3,
	sheetContentWidth=250,
	sheetContentHeight= 1674
}

local background = display.newImageRect("pixel background.png", 1700, 2500)

local mySheet = graphics.newImageSheet( "wix walking.png", sheetData)

local sequenceData = {
	{name = "walk", frames={1,2,3}, time= 300}
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

local function walkPerson(event)
	
		while (event.keyName == 'd' and event.phase == 'down') do
			for i = 1, 1, 1 do
			animation.x = animation.x + 15
			animation:play()
			end
		return true
		end
		while (event.keyName == 'd' and event.phase == 'up') do
			animation.x = animation.x + 15
			animation:pause()
		return true
		end
		while (event.keyName == 'a' and event.phase == 'down') do
			animation.x = animation.x - 15
			animation:play()
		return true
		end
		while (event.keyName == 'a' and event.phase == 'up') do
			animation.x = animation.x - 15
			animation:pause()
		return true
		end
		while (event.keyName == 'w' and event.phase == 'down') do
			animation.y = animation.y - 15
			animation:play()
		return true
		end
		while (event.keyName == 'w' and event.phase == 'up') do
			animation.y = animation.y - 15
			animation:pause()
		return true
		end
		while (event.keyName == 's' and event.phase == 'down') do
			animation.y = animation.y + 15
			animation:play()
		return true
		end
		while (event.keyName == 's' and event.phase == 'up') do
			animation.y = animation.y + 15
			animation:pause()
		return true
		end
	
end
Runtime:addEventListener ("key", walkPerson)

local mouseCircle = display.newCircle(0, 0, display.contentWidth / 10)
mouseCircle:setFillColor(1, 1, 1)
mouseCircle.isVisible = false

--[[local function onMouseEvent(event)
	print("Mouse Event: " .. " Position(" .. tostring(event.x) .. "," .. tostring(event.y) .. ") Buttons(" .. tostring(event.isPrimaryButtonDown) .. "," .. tostring(event.isMiddleButtonDown) .. "," .. tostring(event.isSecondaryButtonDown) .. ")")
	mouseCircle.x = event.x 
	mouseCircle.y = event.y
	if (event.isPrimaryButtonDown or event.isMiddleButtonDown or event.isSecondaryButtonDown) then
		mouseCircle:setFillColor(0, 0, 0)
	else
		mouseCircle:setFillColor(0, 210, 255)
	end
	mouseCircle.isVisible = true
end
if (system.hasEventSource("mouse")) then
	Runtime:addEventListener("mouse", onMouseEvent)
else
	print("Mouse events not supported on this platform.")
end]]--









