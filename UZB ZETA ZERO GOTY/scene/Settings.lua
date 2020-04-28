-----------------------------------------------------------------------------------------
--
-- Settings.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()
local backGroup = display.newGroup()
local text = display.newGroup()
local mute = 0
local ping = audio.loadStream("pistol_reload.wav")
sceneTest=3
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
local background
local screen
local normal
local pressNormal
local easy
local pressEasy
local hard
local pressHard
local controls
local xScale = 2.5
local yScale = 2.5
local xpush = 200
local ypush = 300


function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
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

    normal = display.newText(text, " MUSIC ON/OFF", 125+xpush, -30+ypush, 350, 100, "Helvetica", 44)
    normal:setFillColor(1, 1, 0)
    sceneGroup:insert(normal)

    pressNormal = display.newRoundedRect(text, 118+xpush, -60+ypush, 190, 30, 25)
    pressNormal:setFillColor(0.5, 0, 1)
    pressNormal.alpha = 0.75
    pressNormal:scale( xScale, yScale )
    pressNormal:addEventListener( "tap", muteMusic )
    sceneGroup:insert(pressNormal)

    easy = display.newText(text, " MUTE  ON/OFF", 125+xpush, -130+ypush, 350, 100, "Helvetica", 44)
    easy:setFillColor(1, 1, 0)
    sceneGroup:insert(easy)

    pressEasy = display.newRoundedRect(text, 118+xpush, -160+ypush, 190, 30, 25)
    pressEasy:setFillColor(0.5, 0, 1)
    pressEasy.alpha = 0.75
    pressEasy:scale( xScale, yScale )
    pressEasy:addEventListener( "tap", Mute )
    sceneGroup:insert(pressEasy)

    hard = display.newText(text, "CONTROLS", 120+xpush, 70+ypush, 250, 100, "Helvetica", 44)
    hard:setFillColor(1, 1, 0)
    sceneGroup:insert(hard)

    controls = display.newText(text, "W/SPACE: jump/double jump \nA: left\nD: right\nMOUSE: Aim\nMOUSE LEFT CLICK: Shoot\n1 / 2: swap weapon" , 140+xpush, 230+ypush, 400, 300, "Helvetica", 28)
    controls:setFillColor(1, 1, 0)
    sceneGroup:insert(controls)

    pressHard = display.newRoundedRect(text, 118+xpush, 142+ypush, 190, 110, 25)
    pressHard:setFillColor(0.5, 0, 1)
    pressHard.alpha = 0.75
    pressHard:scale( xScale, yScale )
    sceneGroup:insert(pressHard)

    local GoBack = display.newText(text, "GO BACK", -150+xpush, 339+ypush, 200, 100, "Helvetica", 32)
    GoBack:setFillColor(1, 1, 0)
    sceneGroup:insert(GoBack)

    local pressGoBack = display.newRoundedRect(text, -175+xpush, 305+ypush, 90, 20, 25)
    pressGoBack:setFillColor(0.5, 0, 1)
    pressGoBack.alpha = 0.75
    pressGoBack:scale( xScale, yScale )
    pressGoBack:addEventListener( "tap", gotoStartUp )
    sceneGroup:insert(pressGoBack)

    pressEasy:toBack()
    pressHard:toBack()
    pressNormal:toBack()
    pressGoBack:toBack()
    screen:toBack()
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
sceneTest=3
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

function Mute()
  audio.play(ping)
  if (mute==0) then
    print("BRBRBRBRB")
    audio.setVolume(0)
    mute = 1
  else
    print("ALPHA")
    audio.setVolume(1)
    mute = 0
  end
end

function muteMusic()
  audio.play(ping)
  if (musicStop==0) then
    print(0)
    audio.stop( 1 )
    musicStop = 1
  else
    local backgroundMusic1 = audio.loadStream( "try out 2.wav" )
    audio.play( backgroundMusic1, { channel=1, loops=-1 } )
    print(1)
    audio.play( 1 )
    musicStop = 0
  end
end

function gotoStartUp()
  audio.play(ping)
  composer.gotoScene( "scene.Start-Up", {time=0, effect="fade"} )
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
