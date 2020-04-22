local vendingData = require("scene.game.lib.vendingData")

local M = {}

function M.new()
	
	local map = {}
	
	local backGroup = display.newGroup()
	local collisionGroup = display.newGroup()
	local objectGroup = display.newGroup()
	
	local background = display.newImageRect(backGroup, "scene/game/img/backgroundV3.png", 8000, 5000)
	background.x = 1700
	background.y = 1400

	--walls
	--left wall
	local wall1 = display.newRect(collisionGroup, -750, 2150, 80, 3656)
	wall1:setFillColor(0.5, 0, 1)
	table.insert(map, wall1)
	--basement left wall
	local wall2 = display.newRect(collisionGroup, 945, 3080, 80, 200)
	wall2:setFillColor(0.5, 0, 1)
	table.insert(map, wall2)
	--basememt right wall
	local wall3 = display.newRect(collisionGroup, 3260, 3080, 80, 200)
	wall3:setFillColor(0.5, 0, 1)
	table.insert(map, wall3)
	--right bottom wall(basement and bathroom right wall)
	local wall4 = display.newRect(collisionGroup, 4550, 3000, 80, 1660)
	wall4:setFillColor(0.5, 0, 1)
	table.insert(map, wall4)
	--bar wall 
	local wall5 = display.newRect(collisionGroup,945, 2000, 80, 590 )
	wall5:setFillColor(0.5, 0, 1)
	table.insert(map, wall5)
	--disco bottom wall left
	local wall6 = display.newRect(collisionGroup,945, 1055, 80, 150)
	wall6:setFillColor(0.5, 0, 1)
	table.insert(map, wall6)
	--disco bottom wall right
	local wall7 = display.newRect(collisionGroup,3260, 1055, 80, 150)
	wall7:setFillColor(0.5, 0, 1)
	table.insert(map, wall7)
	--right top wall (storage room wall right)
	local wall8 = display.newRect(collisionGroup, 4550, 1360, 80, 810)
	wall8:setFillColor(0.5, 0, 1)
	table.insert(map, wall8)
	--disco top wall left
	local wall9 = display.newRect(collisionGroup, 945, -40, 80, 736)
	wall9:setFillColor(0.5, 0, 1)
	table.insert(map, wall9)
	--disco top wall right
	local wall10 = display.newRect(collisionGroup, 3260,-40, 80, 736)
	wall10:setFillColor(0.5, 0, 1)
	table.insert(map, wall10)
	
	--platforms
	--basement floor
	local platform1 = display.newRect(collisionGroup,1950, 3800, 5380, 84)
	platform1:setFillColor(0.5, 0, 1)
	table.insert(map, platform1)
	--ground floor left
	local platform2 = display.newRect(collisionGroup, -670, 2940, 200, 80)
	platform2:setFillColor(0.5, 0, 1)
	table.insert(map, platform2)
	--ground floor middle
	local platform3 = display.newRect(collisionGroup,1350, 2940, 2850, 80)
	platform3:setFillColor(0.5, 0, 1)
	table.insert(map, platform3)
	--ground floor right
	local platform4 = display.newRect(collisionGroup,3850, 2940, 1400, 80)
	platform4:setFillColor(0.5, 0, 1)
	table.insert(map, platform4)
	--bottom balcony floor // bathroom ceiling left
	local platform5 = display.newRect(collisionGroup,3490, 2250, 540, 80)
	platform5:setFillColor(0.5, 0, 1)
	table.insert(map, platform5)
	--bottom balcony floor // bathroom ceiling right
	local platform6 = display.newRect(collisionGroup,4440, 2250, 240, 80)
	platform6:setFillColor(0.5, 0, 1)
	table.insert(map, platform6)
	--first floor left
	local platform7 = display.newRect(collisionGroup,-590, 1740, 400, 80)
	platform7:setFillColor(0.5, 0, 1)
	table.insert(map, platform7)
	--first floor right
	local platform8 = display.newRect(collisionGroup,2560, 1740, 4040, 80)
	platform8:setFillColor(0.5, 0, 1)
	table.insert(map, platform8)
	--second floor left
	local platform9 = display.newRect(collisionGroup,400, 940, 2216, 80)
	platform9:setFillColor(0.5, 0, 1)
	table.insert(map, platform9)
	--second floor middle
	local platform10 = display.newRect(collisionGroup,3350,940, 1300, 80)
	platform10:setFillColor(0.5, 0, 1)
	table.insert(map, platform10)
	--second floor right
	local platform11 = display.newRect(collisionGroup,4470, 940, 120, 80)
	platform11:setFillColor(0.5, 0, 1)
	table.insert(map, platform11)
	--ceiling of the building
	local platform12 = display.newRect(collisionGroup, 2100, -360, 2403, 80)
	platform12:setFillColor(0.5, 0, 1)
	table.insert(map, platform12)
	
	--platform objects
	--kegs in basement
	local obj1 = display.newRect(collisionGroup, -290, 3650, 800,400)
	obj1:setFillColor(0.5, 0, 1)
	table.insert(map, obj1)
	local obj1a = display.newRect(collisionGroup, -480, 3650,300 ,850)
	obj1a:setFillColor(0.5, 0, 1)
	table.insert(map, obj1a)
	--shelves in basement
	local obj2 = display.newRect(collisionGroup, 3000, 3100, 115, 50)
	obj2:setFillColor(0.5, 0, 1)
	table.insert(map, obj2)
	local obj2a = display.newRect(collisionGroup, 2830, 3420,515, 50)
	obj2a:setFillColor(0.5, 0, 1)
	table.insert(map, obj2a)
	--the bar
	local obj3 = display.newRect(collisionGroup,2025, 2810, 1396, 181)
	obj3:setFillColor(0.5, 0, 1)
	table.insert(map, obj3)
	--the light in the bar
	local obj4 = display.newRect(collisionGroup,2930, 2260, 315, 50)
	obj4:setFillColor(0.5, 0, 1)
	table.insert(map, obj4)
	--stairs
	local obj5 = display.newRect(collisionGroup,10, 2460, 215, 10)
	obj5:setFillColor(0.5, 0, 1)
	table.insert(map, obj5)
	local obj6 = display.newRect(collisionGroup,-500, 2260, 415, 10)
	obj6:setFillColor(0.5, 0, 1)
	table.insert(map, obj6)
	local obj7 = display.newRect(collisionGroup,150, 2000, 215, 10)
	obj7:setFillColor(0.5, 0, 1)
	table.insert(map, obj7)
	local obj8 = display.newRect(collisionGroup,340, 1760, 215, 10)
	obj8:setFillColor(0.5, 0, 1)
	table.insert(map, obj8)
	--dj booth
	local obj9 = display.newRect(collisionGroup,2090, 1600, 615, 180)
	obj9:setFillColor(0.5, 0, 1)
	table.insert(map, obj9)
	collisionGroup.alpha = 1
	local obj10 = display.newRect(collisionGroup,2090, 1390, 210, 350)
	obj10:setFillColor(0.5, 0, 1)
	table.insert(map, obj10)
	collisionGroup.alpha = 1
	--lights in the disco
	local obj11 = display.newRect(collisionGroup,1530, 1000, 450, 80)
	obj11:setFillColor(0.5, 0, 1)
	table.insert(map, obj11)
	collisionGroup.alpha = 1
	local obj12 = display.newRect(collisionGroup,2630, 1000, 350, 80)
	obj12:setFillColor(0.5, 0, 1)
	table.insert(map, obj12)
	local obj13 = display.newRect(collisionGroup,4330, 1600, 350, 250)
	obj13:setFillColor(0.5, 0, 1)
	table.insert(map, obj13)
	local obj14 = display.newRect(collisionGroup,4330, 1400, 150, 150)
	obj14:setFillColor(0.5, 0, 1)
	table.insert(map, obj14)
	
	--b0x in storage room
	
	
	collisionGroup.alpha = 0.5
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