local playerData = require("scene.game.lib.playerData")
local gunData = require("scene.game.lib.gunData")
local mapData = require("scene.game.lib.mapData")
local physics = require("physics")

local player
local reticle
local loadBall
local hook
local map 
local leftClickIsPressed
local canFireSemiAutomatic = true
local score
local currentGun
local gunN1
local gunN2
local gunList

local currentWave
local zombiesTable = {}
local zombiesHealth = {}

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()


physics.start()
physics.setGravity(0,15)

map = mapData.new()
-- backGroup:insert(map)

player = playerData.new({}, {})
player.x = display.contentCenterX
player.y = display.contentCenterY
-- mainGroup:insert(player)
table.insert(map, player)

reticle = display.newImageRect(uiGroup, "reticle.png", 50, 50)
reticle.x = display.contentCenterX
reticle.y = display.contentCenterY

loadBall = display.newCircle(uiGroup, 1320, 1200, 10)

hook = display.newImageRect(mainGroup,"hook.png", 25, 25)
hook.x = player.x
hook.y = player.y
hook.isVisible = false

physics.addBody(hook, "dynamic", {isSensor = true})
hook.isBodyActive = false
hook.isBullet = true

local function enterFrame()
	
	if player and player.x and player.y then
		local x, y = player:localToContent( 0, 0 )
		x, y = display.contentCenterX - x, display.contentCenterY - y
		for i = #map, 1, -1 do
			map[i].x, map[i].y = map[i].x + x, map[i].y + y
		end
	end
	
	hook.x = player.x
	hook.y = player.y 
end

--Reticle
leftClickIsPressed = false
local function onMouseAction(event)
	reticle.x = event.x
	reticle.y = event.y
	
	if event.isPrimaryButtonDown then
		leftClickIsPressed = true
	else
		leftClickIsPressed = false
		canFireSemiAutomatic = true
	end
	
	if event.isSecondaryButtonDown then
		rightClickIsPressed = true
	else
		rightClickIsPressed = false
	end
end

-- HUD 
score = 1000
local scoreText = display.newText(uiGroup, "score:" ..score, -550 , 50, native.systemFont, 80 )
scoreText:setFillColor( 1, 1, 1 )

--Laser
	
function fireLaser()
	if (leftClickIsPressed and canFireSemiAutomatic) then
		if (currentGun:getAmmo() > 0 and loadBall.x == 1320) then
				
				currentGun:setAmmo()
				
				local newLaser = display.newImageRect("laser.png", 15, 40)
				physics.addBody(newLaser, "dynamic", {isSensor = true})
				newLaser.isBullet = true
				newLaser.myName = "laser"

				newLaser.x = player.x
				newLaser.y = player.y
				newLaser:toBack()
			
				local y1 = player.y
				local x1 = player.x
			
				local length = math.sqrt((reticle.x-x1)^2+(reticle.y-y1)^2)
				local degrees = math.deg(math.atan(math.abs(reticle.y-y1)/math.abs(reticle.x-x1)))
				if (reticle.y<y1) then
					if(reticle.x>x1) then
						newLaser.rotation = 180-degrees+90
					else
						newLaser.rotation = degrees+90
					end
				end
				if (reticle.y>=y1) then
					if(reticle.x>x1) then
						newLaser.rotation = degrees+90
					else
						newLaser.rotation = 360-degrees+90
					end
				end
				
				local x2 = (5*reticle.x-(4*x1))/(1)
				local y2 = (5*reticle.y-(4*y1))/(1)
				transition.to( newLaser, {x=x2, y=y2, time=length*2,
					onComplete = function()display.remove(newLaser)end
				})
				
				local fireSpeed = currentGun:getFireSpeed()
		
				transition.to(loadBall, {x=1200, y=1200, time = fireSpeed})
				transition.to(loadBall, {delay = fireSpeed, x=1320, y=1200, time = fireSpeed})
				
		end
	end
end

--Hook
local function fireHook()
	hook.isVisible = true
	hook.isBodyActive = true
	transition.to(hook, {x = reticle.x, y = reticle.y, time = 300,
		onComplete = function() hook.isVisible = false
		hook.isBodyActive = false
		end
	})
end
 
local function onHookCollision(event)
	if (not (event.other == player)) then
		transition.to(player, {x = event.target.x, y = event.target.y, time = 3000})
	end
end


--Movement

local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "e") then
			fireHook()
		elseif (event.keyName == "r") then
			currentGun:reload()
		elseif (event.keyName == "1") then
			currentGun:hide()
			currentGun = gunN1
			currentGun:show()
		elseif (event.keyName == "2") then
			currentGun:hide()
			currentGun = gunN2
			currentGun:show()
		end
	end
end

--spawn enemies
currentWave = 1

-- local function spawnZombie()

	-- local newZombie = display.newImageRect(mainGroup, "redSquare.png", 50, 50)
	-- physics.addBody(newZombie, "dynamic", {bounce = 0.0})
	-- newZombie.isFixedRotation = true
	-- newZombie.myName = "zombie"
	
	-- local newHealth = 500

	-- table.insert(zombiesTable, newZombie)
	-- table.insert(zombiesHealth, newHealth)
	
	-- local spawnPoint = math.random(2)
	-- if (spawnPoint == 1) then
		-- newZombie.x = display.contentCenterX - 1300
		-- -- newZombie.y = platform5.y - 50
	-- elseif (spawnPoint == 2) then
		-- newZombie.x = display.contentCenterX + 1300
		-- -- newZombie.y = platform5.y - 50	
	-- end
	
	-- table.insert(map, newZombie)
-- end

-- local function onCollision(event)
	-- if (event.phase == "began") then
		-- local obj1 = event.object1
		-- local obj2 = event.object2

		-- if ((obj1.myName == "laser" and obj2.myName == "zombie")
		-- or (obj1.myName == "zombie" and obj2.myName == "laser")
		-- ) then
		
			-- local opposite
			
			-- if (obj1.myName == "laser") then
				-- opposite = obj2
				-- display.remove(obj1)
			-- elseif (obj2.myName == "laser") then
				-- opposite = obj1
				-- display.remove(obj2)
			-- end
			
			-- for i = #zombiesTable, 1, -1 do
				-- if (zombiesTable[i] == event.object1 or zombiesTable[i] == event.object2) then
					-- zombiesHealth[i] = zombiesHealth[i] - currentGun:getDamage()
					
					-- if (zombiesHealth[i] <= 0) then
						-- display.remove(opposite)
						-- table.remove(map, table.indexOf(map, zombiesTable[i]))
						-- table.remove(zombiesHealth, i)
						-- table.remove(zombiesTable, i)
						
						-- score = score + 100
						-- scoreText.text = "score:" ..score
						-- if next(zombiesTable) == nil then
							-- currentWave = currentWave + 1
							-- startWave()
						-- end
					-- end
				-- end
			-- end
		-- end
	-- end

-- end

-- function startWave()
	-- timer.performWithDelay(2000, spawnZombie, math.pow(currentWave, 2) - currentWave + 5)
-- end

--Gameloops

gunList = {}
table.insert(gunList, gunData.new({clip = 7, reserve = 56, fireSpeed = 200, reloadSpeed = 500, damage = 200, name = "ruger", isSemiAuto = true, width = 303, height = 196}))
table.insert(gunList, gunData.new({clip = 32, reserve = 96, fireSpeed = 50, reloadSpeed = 750, damage = 200, name = "uzi", isSemiAuto = false, width = 316, height = 267}))
table.insert(gunList, gunData.new({clip = 30, reserve = 120, fireSpeed = 100, reloadSpeed = 750, damage = 250, name = "ak47", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 6, reserve = 30, fireSpeed = 1000, reloadSpeed = 2000, damage = 1000, name = "mossberg500", isSemiAuto = true}))
table.insert(gunList, gunData.new({clip = 6, reserve = 30, fireSpeed = 1000, reloadSpeed = 2000, damage = 1000, name = "m40", isSemiAuto = true}))
table.insert(gunList, gunData.new({clip = 100, reserve = 500, fireSpeed = 25, reloadSpeed = 2000, damage = 100, name = "m134", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 20, reserve = 100, fireSpeed = 50, reloadSpeed = 750, damage = 300, name = "m16a4", isSemiAuto = true}))
table.insert(gunList, gunData.new({clip = 70, reserve = 210, fireSpeed = 75, reloadSpeed = 900, damage = 300, name = "ppsh41", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 25, reserve = 150, fireSpeed = 50, reloadSpeed = 750, damage = 200, name = "famas", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 6, reserve = 24, fireSpeed = 300, reloadSpeed = 1000, damage = 500, name = "python", isSemiAuto = true}))
table.insert(gunList, gunData.new({clip = 20, reserve = 100, fireSpeed = 100, reloadSpeed = 500, damage = 300, name = "mp7", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 15, reserve = 75, fireSpeed = 50, reloadSpeed = 500, damage = 250, name = "mp5k", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 17, reserve = 60, fireSpeed = 400, reloadSpeed = 500, damage = 150, name = "glock", isSemiAuto = true}))
table.insert(gunList, gunData.new({clip = 32, reserve = 180, fireSpeed = 5, reloadSpeed = 500, damage = 150, name = "mac11", isSemiAuto = false}))
table.insert(gunList, gunData.new({clip = 12, reserve = 75, fireSpeed = 50, reloadSpeed = 500, damage = 200, name = "cz75", isSemiAuto = true,}))

gunN1 = gunList[1]
gunN2 = gunList[2]
currentGun = gunN1
currentGun:show()

local reloadText = display.newText( "", display.contentCenterX, display.contentCenterY, native.systemFont, 100 )
uiGroup:insert(reloadText)
local function gameLoopReload()
	if currentGun:getAmmo() < 1 then
		reloadText.text ="[R]RELOAD"
	elseif currentGun:getAmmo() > 0 then
		reloadText.text = ""
	end
end

Runtime:addEventListener("enterFrame", enterFrame)
Runtime:addEventListener("key", movePlayer)
Runtime:addEventListener("mouse", onMouseAction)
-- Runtime:addEventListener("collision", onCollision)
hook:addEventListener("collision", onHookCollision)
gameLoopTimer = timer.performWithDelay(17, fireLaser, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopReload, 0)

-- startWave()