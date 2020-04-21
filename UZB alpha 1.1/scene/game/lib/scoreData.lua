local M = {}

function M.new()
	
	local num = 1000
	local font = "scene/game/font/Equalize.ttf"
	local score = display.newText("Score: " ..num, -500 , 50, font, 60 )
	score.num = num
	score:setFillColor( 1, 1, 1 )
	
	function score:add(points)
		score.num = score.num - (points or 100)
		score.text = "Score: ".. score.num
	end
	
	function score:subtract(points)
		score.num = score.num - (points or 100)
		score.text = "Score: ".. score.num
	end
	
	function score:get() return self.num end
	
	return score
end

return M