local vendingData = require("scene.game.lib.vendingData")
local ladderData = require("scene.game.lib.ladderData")
local spawnerData = require("scene.game.lib.spawnerData")
local zombieData = require("scene.game.lib.zombieData")

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
	local obj1 = display.newRect(collisionGroup, -290, 3450, 500, 10)
	obj1:setFillColor(0.5, 0, 1)
	obj1.isFloating = true
	table.insert(map, obj1)
	local obj1a = display.newRect(collisionGroup, -480, 3250, 300, 10)
	obj1a:setFillColor(0.5, 0, 1)
	obj1a.isFloating = true
	table.insert(map, obj1a)
	--shelves in basement
	local obj2 = display.newRect(collisionGroup, 3000, 3100, 115, 50)
	obj2:setFillColor(0.5, 0, 1)
	obj2.isFloating = true
	table.insert(map, obj2)
	local obj2a = display.newRect(collisionGroup, 2830, 3420,515, 50)
	obj2a:setFillColor(0.5, 0, 1)
	obj2a.isFloating = true
	table.insert(map, obj2a)
	--the bar
	local obj3 = display.newRect(collisionGroup,2025, 2710, 1396, 10)
	obj3:setFillColor(0.5, 0, 1)
	obj3.isFloating = true
	table.insert(map, obj3)
	--the light in the bar
	local obj4 = display.newRect(collisionGroup,2930, 2260, 315, 50)
	obj4:setFillColor(0.5, 0, 1)
	obj4.isFloating = true
	table.insert(map, obj4)
	--stairs
	local obj5 = display.newRect(collisionGroup,10, 2460, 215, 10)
	obj5:setFillColor(0.5, 0, 1)
	obj5.isFloating = true
	table.insert(map, obj5)
	local obj6 = display.newRect(collisionGroup,-500, 2260, 415, 10)
	obj6:setFillColor(0.5, 0, 1)
	obj6.isFloating = true
	table.insert(map, obj6)
	local obj7 = display.newRect(collisionGroup,150, 2000, 215, 10)
	obj7:setFillColor(0.5, 0, 1)
	obj7.isFloating = true
	table.insert(map, obj7)
	local obj8 = display.newRect(collisionGroup,340, 1760, 215, 10)
	obj8:setFillColor(0.5, 0, 1)
	obj8.isFloating = true
	table.insert(map, obj8)
	local obj15 = display.newRect(collisionGroup,430, 2660, 180, 10)
    obj15:setFillColor(0.5, 0, 1)
	obj15.isFloating = true
    table.insert(map, obj15)
	local obj17 = display.newRect(collisionGroup,-180, 2360, 220, 10)
    obj17:setFillColor(0.5, 0, 1)
	obj17.isFloating = true
    table.insert(map, obj17)	
	--dj booth
	local obj9 = display.newRect(collisionGroup,2080, 1500, 615, 30)
	obj9:setFillColor(0.5, 0, 1)
	obj9.isFloating = true
	table.insert(map, obj9)
	local obj10 = display.newRect(collisionGroup,2085, 1220, 220, 30)
	obj10:setFillColor(0.5, 0, 1)
	obj10.isFloating = true
	table.insert(map, obj10)
	--lights in the disco
	local obj11 = display.newRect(collisionGroup,1530, 1000, 450, 80)
	obj11:setFillColor(0.5, 0, 1)
	table.insert(map, obj11)
	local obj12 = display.newRect(collisionGroup,2630, 1000, 350, 80)
	obj12:setFillColor(0.5, 0, 1)
	table.insert(map, obj12)
	local obj13 = display.newRect(collisionGroup,4330, 1600, 350, 250)
	obj13:setFillColor(0.5, 0, 1)
	table.insert(map, obj13)
	local obj14 = display.newRect(collisionGroup,4330, 1400, 150, 150)
	obj14:setFillColor(0.5, 0, 1)
	table.insert(map, obj14)
	
	local obj16 = display.newRect(collisionGroup,-180, 2360, 220, 10)
    obj15:setFillColor(0.5, 0, 1)
	obj16.isFloating = true
    table.insert(map, obj16)
	
	--b0x in storage room
	
	--zombie ladders
	local ladder1 = ladderData.new({x = 1850, y = 1250, width = 10, height = 900})
	collisionGroup:insert(ladder1)
	
	local ladder2 = ladderData.new({x = 2350, y = 1250, width = 10, height = 900})
	collisionGroup:insert(ladder2)
	
	local ladder3 = ladderData.new({x = 4010, y = 1250, width = 10, height = 900})
	collisionGroup:insert(ladder3)
	
	local ladder4 = ladderData.new({x = 490, y = 2250, width = 10, height = 1200})
	collisionGroup:insert(ladder4)
	
	local ladder5 = ladderData.new({x = 3810, y = 2454, width = 10, height = 800})
	collisionGroup:insert(ladder5)
	
	local ladder6 = ladderData.new({x = 2800, y = 3275, width = 10, height = 950})
	collisionGroup:insert(ladder6)
	
	local ladder7 = ladderData.new({x = 3090, y = 3275, width = 10, height = 950})
	collisionGroup:insert(ladder7)
	
	local ladder8 = ladderData.new({x = -140, y = 3275, width = 10, height = 950})
	collisionGroup:insert(ladder8)
	
	collisionGroup.alpha = 0.5
	--Objects
	local spawners = {}
	table.insert(spawners, spawnerData.new({x = 3480, y = 730, width = 100, height = 1}))
	table.insert(spawners, spawnerData.new({x = 2150, y = 1530, width = 1760, height = 1}))
	table.insert(spawners, spawnerData.new({x = 3775, y = 1530, width = 650, height = 1}))
	table.insert(spawners, spawnerData.new({x = 450, y = 2700, width = 800, height = 1}))
	table.insert(spawners, spawnerData.new({x = 2250, y = 2700, width = 1500, height = 1}))
	table.insert(spawners, spawnerData.new({x = 3950, y = 2700, width = 900, height = 1}))
	table.insert(spawners, spawnerData.new({x = 1925, y = 3600, width = 1550, height = 1}))
	
	local vendingRand = vendingData.new({name = "random"}, {name = "vendingMachine1", x = 300, y = 600, width = 300, height = 500})

	local vending1 = vendingData.new({name = "m40"}, {x = 15, y = 650, width = 50, height = 100, colour = {0, 0, 1}})

	local vending2 = vendingData.new({name = "ruger"}, {x = 15, y = 330, width = 50, height = 100, colour = {1, 0, 0}})

	local vending3 = vendingData.new({name = "mac11"}, {x = 157, y = 330, width = 50, height = 100, colour = {1, 1, 0}})

	local vending4 = vendingData.new({name = "mossberg500"}, {x = 300, y = 330, width = 50, height = 100, colour = {0, 0.8, 0.7}})
	
	for i = #map, 1, -1 do
		physics.addBody(map[i], "static", {bounce = 0.0, friction = 1.0})
	end
	table.insert(map, background)
	table.insert(map, ladder1)
	table.insert(map, ladder2)
	table.insert(map, ladder3)
	table.insert(map, ladder4)
	table.insert(map, ladder5)
	table.insert(map, ladder6)
	table.insert(map, ladder7)
	table.insert(map, ladder8)
	table.insert(map, vending1)
	table.insert(map, vending2)
	table.insert(map, vending3)
	table.insert(map, vending4)
	table.insert(map, vendingRand)
	for i = #spawners, 1, -1 do
		table.insert(map, spawners[i])
	end
		
		
	function map:spawnWave(number)
		for i = 1, number do
			local s = spawners[math.random(7)]
			local pX, pY = display.contentCenterX, display.contentCenterY
			if (pY + 500 > s.y or pY - 500 < s.y) then
				while not(pX + 700 > s.x or pX - 700 < s.x) do
					s = spawners[math.random(7)]
				end
			end
			local x, y = s:randomSpawnPoint(), s.y
			local z1 = zombieData.new({x = x, y = y})
			table.insert(map, z1)
		end
	end
	
	return map
end

return M