local composer = require("composer")

local scene = composer.newScene()

local startText, bg

local function key(event)
	if event.phase == "up" and event.keyName == "escape" then
		if not (composer.getSceneName("current") == "scene.menu") then
			composer.gotoScene("scene.menu")
		end
	end
end

function scene:create(event)

	local sceneGroup = self.view
	
	bg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentHeight, display.contentWidth)
	bg:setFillColor(1, 0, 0)
	startText = display.newText("Start", display.contentCenterX, display.contentCenterY, 
	native.systemFont, 64)
	
	function bg:tap()
		composer.gotoScene("scene.game", {params = {}})
	end
	
	sceneGroup:insert(bg)
	sceneGroup:insert(startText)
	
	Runtime:addEventListener("key", key)
end

local function enterFrame(event)
	local elapsed = event.time
end

function scene:show(event)
	
	local phase = event.phase
	
	if (phase == "will") then
		Runtime:addEventListener("enterFrame", enterFrame)
	elseif (phase == "did") then
		bg:addEventListener("tap")
	end
end

function scene:hide(event)
	
	local phase = event.phase
	
	if (phase == "will") then
		bg:removeEventListener("tap")
	elseif (phase == "did") then
		Runtime:removeEventListener("enterFrame", enterFrame)
	end
end

function scene:destroy(event)
	Runtime:removeEventListener("key", key)
end


scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene