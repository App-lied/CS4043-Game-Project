local composer = require "composer"

local sceneTest=0
local musicStop = 0
local HighScore
local backgroundMusic1 = audio.loadStream( "try out 2.wav" )
audio.play( backgroundMusic1, { channel=1, loops=-1 } )
composer.setVariable( HighScore, 2 )
composer.gotoScene("Start-Up", {params = {}})
