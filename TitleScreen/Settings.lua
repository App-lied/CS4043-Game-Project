-----------------------------------------------------------------------------------------
--
-- Settings.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()
local backGroup = display.newGroup()
local text = display.newGroup()
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
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background = display.newImageRect(backGroup, "Arcade.png", 792, 944)
    background.x = 128
    background.y = 236
    sceneGroup:insert(background)

    screen = display.newImageRect(backGroup, "thumbnail.png", 436, 300)
    screen.x = 135
    screen.y = 160
    screen.alpha = 0.75
    sceneGroup:insert(screen)

    normal = display.newText(text, " MUSIC ON/OFF", 125, 150, 200, 100, "Helvetica", 24)
    normal:setFillColor(1, 1, 0)
    sceneGroup:insert(normal)

    pressNormal = display.newRoundedRect(text, 118, 115, 190, 30, 25)
    pressNormal:setFillColor(0.5, 0, 1)
    sceneGroup:insert(pressNormal)

    easy = display.newText(text, " MUTE  ON/OFF", 125, 110, 200, 100, "Helvetica", 24)
    easy:setFillColor(1, 1, 0)
    sceneGroup:insert(easy)

    pressEasy = display.newRoundedRect(text, 118, 75, 190, 30, 25)
    pressEasy:setFillColor(0.5, 0, 1)
    sceneGroup:insert(pressEasy)

    hard = display.newText(text, "CONTROLS", 160, 190, 200, 100, "Helvetica", 20)
    hard:setFillColor(1, 1, 0)
    sceneGroup:insert(hard)

    controls = display.newText(text, "W/SPACE: jump \nA: left\nD: right\nMOUSE: Aim\nMOUSE LEFT CLICK: Shoot", 140, 210, 200, 100, "Helvetica", 12)
    controls:setFillColor(1, 1, 0)
    sceneGroup:insert(controls)

    pressHard = display.newRoundedRect(text, 118, 192, 190, 110, 25)
    pressHard:setFillColor(0.5, 0, 1)
    sceneGroup:insert(pressHard)

    local GoBack = display.newText(text, "GO BACK", 69, 309, 200, 100, "Helvetica", 12)
    GoBack:setFillColor(1, 1, 0)
    sceneGroup:insert(GoBack)

    local pressGoBack = display.newRoundedRect(text, 0, 265, 90, 20, 25)
    pressGoBack:setFillColor(0.5, 0, 1)
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
        sceneTest=3
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

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
