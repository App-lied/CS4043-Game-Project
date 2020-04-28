local M = {}

function M.new()

	local num = 1000
	local font = "scene/game/font/Equalize.ttf"
	local score = display.newText("Score: " ..num, -400 , 50, font, 60 )
	score.num = num
	score:setFillColor( 1, 1, 1 )

	local wave = 0
	local waveText = display.newText("Wave: "..wave, -400, 125, font, 60)
	local numberToSpawn = 0

	function score:add(points)
		score.num = score.num + (points or 100)
		score.text = "Score: ".. score.num
	end

	function score:subtract(points)
		score.num = score.num - (points or 100)
		score.text = "Score: ".. score.num
	end

	function score:updateWave()
		wave = wave + 1
		waveText.text = "Wave: " ..wave
	end

	function score:getWave()
		return wave
	end

	function score:numberToSpawn()
		numberToSpawn = math.pow(wave, 2) - wave + 5
	end

	function score:killZombie()
		numberToSpawn = numberToSpawn - 1
	end

	function score:getSpawnNumber()
		return numberToSpawn
	end

	function score:get() return self.num end

	function score:hide()
		waveText.isVisible = false
	end
	return score
end

return M
