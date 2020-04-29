local composer = require "composer"

local sceneTest=0
local musicStop = 0
local mute = 0
local HighScore
local backgroundMusic1 = audio.loadStream( "scene/game.audio/main_song.wav" )
audio.play( backgroundMusic1, { channel=1, loops=-1 } )
composer.setVariable( HighScore, 2 )
composer.gotoScene("scene.Start-Up", {params = {}})
