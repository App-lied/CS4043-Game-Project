-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer")
--local Settings = composer.newScene()
--local Difficulty = composer.newScene()
--local Game = composer.newScene()
--local HighScore = composer.newScene()
local sceneTest=0
local musicStop = 0
local HighScore
local backgroundMusic1 = audio.loadStream( "try out 2.wav" )
audio.play( backgroundMusic1, { channel=1, loops=-1 } )
composer.setVariable( HighScore, 2 )
composer.gotoScene( "Start-Up", { time=2500, effect="crossFade" } )
