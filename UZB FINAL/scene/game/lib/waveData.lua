local zombieData = require("scene.game.lib.zombieData")

local M = {}

function M.new()
	
	local instance = {}
	
	local wave = 1
	local waveStarted = false
	
	local function enterFrame()
		if (waveStarted and next(instance) == nil) then
			wave = wave + 1
			waveStarted = false
			startWave()
		end
	end
	
	function startWave()
		table.insert(instance, zombieData.new({}))
		waveStarted = true
		timer.performWithDelay(2000, table.insert(instance, zombieData.new({}), math.pow(wave, 2) - wave + 4))
	end
	
	Runtime:addEventListener("enterFrame", enterFrame)
	
	return instance
end

return M