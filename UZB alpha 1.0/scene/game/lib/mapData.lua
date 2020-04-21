local vendingData = require("scene.game.lib.vendingData")

local M = {}

function M.new()
	
	local map = {}
	
	local backGroup = display.newGroup()
	local collisionGroup = display.newGroup()
	local objectGroup = display.newGroup()
	
	local background = display.newImageRect(backGroup, "scene/game/img/bg.png", 8000, 5000)
	background.x = 1700
	background.y = 1400

	--walls and floors
	--basement floor
	local platform1 = display.newRect(collisionGroup,1950, 3800, 5380, 84)
	platform1:setFillColor(0.5, 0, 1)
	table.insert(map, platform1)
	--ground floor left
	local platform2 = display.newRect(collisionGroup, 1550, 2900, 4548, 120)
	platform2:setFillColor(0.5, 0, 1)
	table.insert(map, platform2)
	--ground floor right
	local platform3 = display.newRect(collisionGroup,4500, 2900, 240, 123)
	platform3:setFillColor(0.5, 0, 1)
	table.insert(map, platform3)
	--left wall
	local wall1 = display.newRect(collisionGroup, -750, 2150, 88, 3656)
	wall1:setFillColor(0.5, 0, 1)
	table.insert(map, wall1)
	--right bottom wall(basement and bathroom right wall)
	local wall2 = display.newRect(collisionGroup, 4600, 3000, 100, 1660)
	wall2:setFillColor(0.5, 0, 1)
	table.insert(map, wall2)
	--the bar
	local bar = display.newRect(collisionGroup,2025, 2750, 1396, 181)
	bar:setFillColor(0.5, 0, 1)
	table.insert(map, bar)
	--the light in the bar
	local light = display.newRect(collisionGroup,2950, 2240, 332, 48)
	light:setFillColor(0.5, 0, 1)
	table.insert(map, light)
	--first floor left
	local platform4 = display.newRect(collisionGroup,-450,1700, 628, 124)
	platform4:setFillColor(0.5, 0, 1)
	table.insert(map, platform4)
	--first floor right
	local platform5 = display.newRect(collisionGroup,2500, 1700, 4116, 124)
	platform5:setFillColor(0.5, 0, 1)
	table.insert(map, platform5)
	--disco bottom wall right
	local wall3 = display.newRect(collisionGroup,3300, 1060, 96, 150)
	wall3:setFillColor(0.5, 0, 1)
	table.insert(map, wall3)
	--disco bottom wall left
	local wall4 = display.newRect(collisionGroup,950, 1060, 96, 150)
	wall4:setFillColor(0.5, 0, 1)
	table.insert(map, wall4)
	--right top wall (storage room wall right)
	local wall5 = display.newRect(collisionGroup,4600,1350, 112, 875)
	wall5:setFillColor(0.5, 0, 1)
	table.insert(map, wall5)
	--second floor right
	local platform6 = display.newRect(collisionGroup,3650,950, 1920, 116)
	platform6:setFillColor(0.5, 0, 1)
	table.insert(map, platform6)
	--second floor left
	local platform7 = display.newRect(collisionGroup,400, 950, 2216, 116)
	platform7:setFillColor(0.5, 0, 1)
	table.insert(map, platform7)
	--disco top wall left
	local wall6 = display.newRect(collisionGroup, 950, -40, 88, 736)
	wall6:setFillColor(0.5, 0, 1)
	table.insert(map, wall6)
	--disco top wall right
	local wall7 = display.newRect(collisionGroup, 3300,-40,88, 736)
	wall7:setFillColor(0.5, 0, 1)
	table.insert(map, wall7)
	--ceiling of the building
	--local platform8 = display.newImageRect(mainGroup,"ceiling.png", 2403, 81)
	--bottom balcony floor // bathroom ceiling
	local platform9 = display.newRect(collisionGroup,3950, 2245, 1369, 88)
	platform9:setFillColor(0.5, 0, 1)
	table.insert(map, platform9)
	--bar wall 
	local wall8 = display.newRect(collisionGroup,950, 1800, 88, 150 )
	wall8:setFillColor(0.5, 0, 1)
	table.insert(map, wall8)

	collisionGroup.alpha = 0.01
	
	--Objects

	local vendingRand = vendingData.new({name = "random"}, {name = "vendingMachine1", x = 300, y = 600, width = 300, height = 500})

	local vending1 = vendingData.new({name = "uzi"}, {x = 15, y = 650, width = 50, height = 100, colour = {0, 0, 1}})

	local vending2 = vendingData.new({name = "ruger"}, {x = 15, y = 330, width = 50, height = 100, colour = {1, 0, 0}})

	local vending3 = vendingData.new({name = "mac11"}, {x = 157, y = 330, width = 50, height = 100, colour = {1, 1, 0}})

	local vending4 = vendingData.new({name = "mossberg500"}, {x = 300, y = 330, width = 50, height = 100, colour = {0, 0.8, 0.7}})
	
	for i = #map, 1, -1 do
		physics.addBody(map[i], "static", {bounce = 0.0, friction = 1.0})
	end
	table.insert(map, background)
	table.insert(map, vending1)
	table.insert(map, vending2)
	table.insert(map, vending3)
	table.insert(map, vending4)
	table.insert(map, vendingRand)
		
	return map
end

return M