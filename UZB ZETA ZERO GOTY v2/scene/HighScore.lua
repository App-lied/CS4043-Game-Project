-----------------------------------------------------------------------------------------
--
-- HighScore.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local json = require( "json" )

local scoresTable = {}

local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

local function loadScores()

   local file = io.open( filePath, "r" )

   if file then
       local contents = file:read( "*a" )
       io.close( file )
       scoresTable = json.decode( contents )
   end

   if ( scoresTable == nil or #scoresTable == 0 ) then
       scoresTable = { 10000, 5000, 4500, 4000, 3500, 3000, 2500, 2000, 1500, 1000 }
   end
end

local function saveScores()

   for i = #scoresTable, 11, -1 do
       table.remove( scoresTable, i )
   end

   local file = io.open( filePath, "w" )

   if file then
       file:write( json.encode( scoresTable ) )
       io.close( file )
   end
end

local function gotoMenu()
  composer.gotoScene( "scene.Start-Up", {time=0, effect="fade"} )
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    loadScores()

    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    local function compare( a, b )
       return a > b
   end
   table.sort( scoresTable, compare )
   saveScores()

   local background = display.newImageRect( sceneGroup, "scene/game/img/thumbnail.png", 1280*2, 720*2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local rect = display.newRoundedRect( sceneGroup, display.contentCenterX-10, display.contentCenterY-150, 125*5, 150*5, 25 )
    rect:setFillColor(0.5, 0, 1)
    rect.alpha = 0.75


    local highScoresHeader = display.newText( sceneGroup, "HIGH SCORES", display.contentCenterX-10, 160, "Helvetica", 64 )
    highScoresHeader:setFillColor(1, 1, 0)

    for i = 1, 10 do
        if ( scoresTable[i] ) then
            local yPos = 200 + ( i * 56 )
            local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX-200, yPos, "Helvetica", 52 )
            rankNum:setFillColor( 1, 1, 0 )
            rankNum.anchorX = 1

            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX-80, yPos, "Helvetica", 52 )
            thisScore.anchorX = 0
            thisScore:setFillColor(1, 1, 0)
        end
    end
    rect:toBack()
    background:toBack()
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

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene( "scene.HighScore")
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
