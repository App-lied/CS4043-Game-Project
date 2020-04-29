-----------------------------------------------------------------------------------------
--
-- Difficulty.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local DifficultyScene = composer.newScene()
local backGroup = display.newGroup()
local text = display.newGroup()
sceneTest=2
local ping = audio.loadStream("pistol_reload.wav")
local ping2 = audio.loadStream( "ping.wav")
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
local xScale = 2.5
local yScale = 2.5
local xpush = 200
local ypush = 300
local DifficultyTest = 0

function DifficultyScene:create( event )

    local DifficultySceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background = display.newImageRect(backGroup, "scene/game/img/Arcade.png", 792, 644)
    background.x = 128+xpush
    background.y = 236+ypush
    background:scale( xScale, yScale )
    DifficultySceneGroup:insert(background)

    screen = display.newImageRect(backGroup, "scene/game/img/thumbnail.png", 536, 400)
    screen.x = 135+xpush
    screen.y = 150+ypush
    screen.alpha = 0.75
    screen:scale( xScale, yScale )
    DifficultySceneGroup:insert(screen)

    normal = display.newText(text, "NORMAL", 130+xpush, 30+ypush, 200, 100, "Helvetica", 44)
    normal:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(normal)

    pressNormal = display.newRoundedRect(text, 118+xpush, 0+ypush, 120, 30, 25)
    pressNormal:setFillColor(0.5, 0, 1)
    pressNormal.alpha = 0.75
    pressNormal:scale( xScale+0.5, yScale+0.5 )
    pressNormal:addEventListener( "tap", gotoNormal )
    DifficultySceneGroup:insert(pressNormal)

    easy = display.newText(text, "EASY", 165+xpush, -125+ypush, 200, 100, "Helvetica", 44)
    easy:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(easy)

    pressEasy = display.newRoundedRect(text, 118+xpush, -150+ypush, 120, 30, 25)
    pressEasy:setFillColor(0.5, 0, 1)
    pressEasy.alpha = 0.75
    pressEasy:scale( xScale+0.5, yScale+0.5 )
    pressEasy:addEventListener( "tap", gotoEasy )
    DifficultySceneGroup:insert(pressEasy)

    hard = display.newText(text, "HARD", 155+xpush, 170+ypush, 200, 100, "Helvetica", 44)
    hard:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(hard)

    pressHard = display.newRoundedRect(text, 118+xpush, 142+ypush, 120, 30, 25)
    pressHard:setFillColor(0.5, 0, 1)
    pressHard.alpha = 0.75
    pressHard:scale( xScale+0.5, yScale+0.5 )
    pressHard:addEventListener( "tap", gotoHard )
    DifficultySceneGroup:insert(pressHard)

    local GoBack = display.newText(text, "GO BACK", -150+xpush, 339+ypush, 200, 100, "Helvetica", 32)
    GoBack:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(GoBack)

    local pressGoBack = display.newRoundedRect(text, -175+xpush, 305+ypush, 90, 20, 25)
    pressGoBack:setFillColor(0.5, 0, 1)
    pressGoBack.alpha = 0.75
    pressGoBack:scale( xScale, yScale )
    pressGoBack:addEventListener( "tap", gotoStartUp )
    DifficultySceneGroup:insert(pressGoBack)

    pressEasy:toBack()
    pressHard:toBack()
    pressNormal:toBack()
    pressGoBack:toBack()
    screen:toBack()
end


-- show()
function DifficultyScene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        sceneTest=2
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end


-- hide()
function DifficultyScene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
function DifficultyScene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

function gotoEasy()
  composer.gotoScene( "scene.game", {time=100, effect="crossFade"} )
  DifficultyTest = 1
  audio.play(ping2)
  --easy
end

function gotoNormal()
  composer.gotoScene( "scene.game", {time=100, effect="crossFade"} )
  DifficultyTest = 2
  audio.play(ping2)
  --normal
  print("normal")
end

function gotoHard()
  composer.gotoScene( "scene.game", {time=100, effect="crossFade"} )
  DifficultyTest = 3
  audio.play(ping2)
  --hard
  print("hard")
end

function gotoStartUp()
  audio.play(ping)
  composer.gotoScene( "scene.Start-Up", {time=0, effect="fade"} )
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
DifficultyScene:addEventListener( "create", DifficultyScene )
DifficultyScene:addEventListener( "show", DifficultyScene )
DifficultyScene:addEventListener( "hide", DifficultyScene )
DifficultyScene:addEventListener( "destroy", DifficultyScene )
-- -----------------------------------------------------------------------------------

return DifficultyScene
