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
function DifficultyScene:create( event )

    local DifficultySceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background = display.newImageRect(backGroup, "Arcade.png", 792, 944)
    background.x = 128
    background.y = 236
    DifficultySceneGroup:insert(background)

    screen = display.newImageRect(backGroup, "thumbnail.png", 436, 300)
    screen.x = 135
    screen.y = 160
    screen.alpha = 0.75
    DifficultySceneGroup:insert(screen)

    normal = display.newText(text, "NORMAL", 168, 190, 200, 100, "Helvetica", 24)
    normal:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(normal)

    pressNormal = display.newRoundedRect(text, 118, 155, 120, 30, 25)
    pressNormal:setFillColor(0.5, 0, 1)
    DifficultySceneGroup:insert(pressNormal)

    easy = display.newText(text, "EASY", 185, 150, 200, 100, "Helvetica", 24)
    easy:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(easy)

    pressEasy = display.newRoundedRect(text, 118, 115, 120, 30, 25)
    pressEasy:setFillColor(0.5, 0, 1)
    DifficultySceneGroup:insert(pressEasy)

    hard = display.newText(text, "HARD", 185, 230, 200, 100, "Helvetica", 24)
    hard:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(hard)

    pressHard = display.newRoundedRect(text, 118, 192, 120, 30, 25)
    pressHard:setFillColor(0.5, 0, 1)
    DifficultySceneGroup:insert(pressHard)

    local GoBack = display.newText(text, "GO BACK", 69, 309, 200, 100, "Helvetica", 12)
    GoBack:setFillColor(1, 1, 0)
    DifficultySceneGroup:insert(GoBack)

    local pressGoBack = display.newRoundedRect(text, 0, 265, 90, 20, 25)
    pressGoBack:setFillColor(0.5, 0, 1)
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
        sceneTest=2
    end
end


-- destroy()
function DifficultyScene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

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
