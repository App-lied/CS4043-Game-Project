-----------------------------------------------------------------------------------------
--
-- Start-Up.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
--sceneTest=1
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
local backGroup = display.newGroup()
local text = display.newGroup()
local background
local screen
local PressStart
local pressStartButton
local Settings
local pressSettings
local Coin

function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --took the arcade machine from https://dlpng.com/png/6398993
    background = display.newImageRect(backGroup, "Arcade.png", 792, 944)
    background.x = 128
    background.y = 236
    sceneGroup:insert(background)

    screen = display.newImageRect(backGroup, "thumbnail.png", 436, 300)
    screen.x = 135
    screen.y = 160
    screen.alpha = 0.75
    sceneGroup:insert(screen)

    PressStart = display.newText(text, "PRESS START", 150, 250, 200, 100, "Helvetica", 24)
    PressStart:setFillColor(1, 1, 0)
    sceneGroup:insert(PressStart)

    pressStartButton = display.newRoundedRect(text, 130, 213, 175, 35, 15)
    pressStartButton:setFillColor(0.5, 0, 1)
    sceneGroup:insert(pressStartButton)

    Settings = display.newText(text, "SETTINGS", 69, 309, 200, 100, "Helvetica", 12)
    Settings:setFillColor(1, 1, 0)
    sceneGroup:insert(Settings)

    pressSettings = display.newRoundedRect(text, 0, 265, 90, 20, 25)
    pressSettings:setFillColor(0.5, 0, 1)
    sceneGroup:insert(pressSettings)

    Coin = display.newText(text, "INSERT COIN", 155, 190, 200, 100, "Helvetica", 24)
    Coin:setFillColor(1, 1, 0)
    local test = 1
    sceneGroup:insert(Coin)

    pressStartButton:toBack()
    pressSettings:toBack()
    screen:toBack()
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --START MUSIC
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        sceneTest=1
        timer.performWithDelay( 1000, EnterCoin, -1)
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --STOP MUSIC
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

local function EnterCoin()
    if(test == 2) then
      Coin = display.newText(text, "INSERT COIN", 155, 190, 200, 100, "Helvetica", 24)
      Coin:setFillColor(1, 1, 0)
      test = 1
    else if(test == 1) then
      display.remove(Coin)
      test = 2
    end
  end
end

local function mouse(event)
  print(event.x.." "..event.y)
  if (event.isPrimaryButtonDown) then
    if (event.x<=207 and event.x>=47 and event.y>=200 and event.y<=227 and sceneTest==1) then
          composer.gotoScene( "Difficulty", {time=0, effect="fade"} )
    end
    if (event.x<=38 and event.x>=-42 and event.y>=257 and event.y<=272) then
          if(sceneTest==1) then
            print("nnananan ")
            composer.gotoScene( "Settings", {time=0, effect="fade"} )
          end
          if(sceneTest==2 or sceneTest==3) then
            composer.gotoScene( "Start-Up", {time=0, effect="fade"} )
          end
    end
    if (event.x<=204 and event.x>=30 and event.y>=60 and event.y<=84 and sceneTest==3) then
      --Sound ON/OFF
      print("MUTE")
    end
    if (event.x<=204 and event.x>=30 and event.y>=100 and event.y<=124 and sceneTest==3) then
      --Music ON/OFF
      print("NO TUNES BOI")
    end
  end
end

Runtime:addEventListener("mouse", mouse)
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
