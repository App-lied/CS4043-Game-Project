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
audio.reserveChannels( 1 )
audio.setVolume( 0.25, { channel=1 } )
local ping2 = audio.loadStream( "ping.wav")
local gameTest = 0

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
local musicStop=0
local xScale = 2.5
local yScale = 2.5
local xpush = 200
local ypush = 300
local HighScore
local pressHighsScore
local ping = audio.loadStream("pistol_reload.wav")

function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --took the arcade machine from https://dlpng.com/png/6398993
    background = display.newImageRect(backGroup, "scene/game/img/Arcade.png", 792, 644)
    background.x = 128+xpush
    background.y = 236+ypush
    background:scale( xScale, yScale )
    sceneGroup:insert(background)

    screen = display.newImageRect(backGroup, "scene/game/img/thumbnail.png", 536, 400)
    screen.x = 135+xpush
    screen.y = 150+ypush
    screen.alpha = 0.75
    screen:scale( xScale, yScale )
    sceneGroup:insert(screen)

    PressStart = display.newText(text, "PRESS START", 200+xpush, 340+ypush, 500, 400, "Helvetica", 44)
    PressStart:setFillColor(1, 1, 0)
    sceneGroup:insert(PressStart)

    pressStartButton = display.newRoundedRect(text, 100+xpush, 163+ypush, 175, 35, 15)
    pressStartButton:setFillColor(0.5, 0, 1)
    pressStartButton.alpha = 0.75
    pressStartButton:scale( xScale, yScale )
    sceneGroup:insert(pressStartButton)
    pressStartButton:addEventListener( "tap", gotoDifficulty )

    Settings = display.newText(text, "SETTINGS", -155+xpush, 339+ypush, 200, 100, "Helvetica", 32)
    Settings:setFillColor(1, 1, 0)
    sceneGroup:insert(Settings)

    pressSettings = display.newRoundedRect(text, -175+xpush, 305+ypush, 90, 20, 25)
    pressSettings:setFillColor(0.5, 0, 1)
    pressSettings.alpha = 0.75
    pressSettings:scale( xScale, yScale )
    sceneGroup:insert(pressSettings)
    pressSettings:addEventListener( "tap", gotoSettings )

    HighScore = display.newText(text, "HIGHSCORE", 355+xpush, 339+ypush, 200, 100, "Helvetica", 32)
    HighScore:setFillColor(1, 1, 0)
    sceneGroup:insert(HighScore)

    pressHighScore = display.newRoundedRect(text, 350+xpush, 305+ypush, 90, 20, 25)
    pressHighScore:setFillColor(0.5, 0, 1)
    pressHighScore.alpha = 0.75
    pressHighScore:scale( xScale, yScale )
    sceneGroup:insert(pressHighScore)
    pressHighScore:addEventListener( "tap", gotoHighScore )


    Coin = display.newText(text, "INSERT COIN", 115+xpush, 50+ypush, 300, 100, "Helvetica", 44)
    Coin:setFillColor(1, 1, 0)
    local test = 1
    sceneGroup:insert(Coin)

    pressStartButton:toBack()
    pressSettings:toBack()
    pressHighScore:toBack()
    screen:toBack()
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --START MUSIC
        local backgroundMusic1 = audio.loadStream( "try out 2.wav" )
      --if(musicStop==0) then
        --audio.play( backgroundMusic1, { channel=1, loops=-1 } )
      --end
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

function gotoSettings()
  audio.play(ping)
  composer.gotoScene( "scene.Settings", {time=0, effect="fade"} )
end

function gotoDifficulty()
  composer.gotoScene( "scene.game", {time=100, effect="crossFade"} )
  DifficultyTest = 1
  audio.play(ping2)
  --easy
end

function gotoHighScore()
  audio.play(ping)
  composer.gotoScene( "scene.HighScoreMenu", {time=0, effect="fade"} )
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
