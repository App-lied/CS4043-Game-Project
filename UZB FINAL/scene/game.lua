local composer = require("composer")
local playerData = require("scene.game.lib.playerData")
local gunData = require("scene.game.lib.gunData")
local mapData = require("scene.game.lib.mapData")
local zombieData = require("scene.game.lib.zombieData")
local scoreData = require("scene.game.lib.scoreData")
local physics = require("physics")
local gameTest=1

local player, map, reticle, loadBall, leftClickIsPressed, canFireSemiAutomatic

local scene = composer.newScene()

function scene:create(event)

	physics.start()
	physics.setGravity(0, 30)

	map = mapData.new()

	player = playerData.new({x = display.contentCenterX, y = display.contentCenterY}, {})
	table.insert(map, player)


	reticle = display.newImageRect("scene/game/img/reticle.png", 50, 50)
	reticle.x = display.contentCenterX
	reticle.y = display.contentCenterY

	loadBall = display.newCircle(1320, 1200, 20)

	scene.score = scoreData.new()

	canFireSemiAutomatic = true
	leftClickIsPressed = false
	function fireLaser()
		if (leftClickIsPressed and canFireSemiAutomatic) then
			if (currentGun.ammo > 0 and loadBall.x == 1320) then

					currentGun:setAmmo()

					local newLaser = display.newImageRect("scene/game/img/laser.png", 15, 40)
					physics.addBody(newLaser, "dynamic", {isSensor = true})
					newLaser.isBullet = true
					newLaser.myName = "laser"
					newLaser.x, newLaser.y = player.x, player.y

					local x1, y1 = player.x, player.y

					local length = math.sqrt((reticle.x-x1)^2+(reticle.y-y1)^2)
					local degrees = math.deg(math.atan(math.abs(reticle.y-y1)/math.abs(reticle.x-x1)))
					if (reticle.y<y1) then
						if(reticle.x>x1) then
							newLaser.rotation = 180-degrees+90
						else
							newLaser.rotation = degrees+90
						end
					else
						if(reticle.x>x1) then
							newLaser.rotation = degrees+90
						else
							newLaser.rotation = 360-degrees+90
						end
					end

					local x2 = (5*reticle.x-(4*x1))
					local y2 = (5*reticle.y-(4*y1))
					transition.to( newLaser, {x=x2, y=y2, time=length*2,
						onComplete = function()display.remove(newLaser)end
					})

					local fs = currentGun.fireSpeed
					transition.to(loadBall, {x=1200, y=1200, time = fs})
					transition.to(loadBall, {delay = fs, x=1320, y=1200, time = fs})

					if currentGun.isSemiAuto then
						canFireSemiAutomatic = false
					end
			end
		end
	end


	function startWave()
		scene.score:updateWave()
		scene.score:numberToSpawn()
		map:spawnWave(scene.score:getSpawnNumber())
	end

	gunList = {}
	table.insert(gunList, gunData.new({clip = 7, reserve = 56, fireSpeed = 200, reloadSpeed = 500, damage = 200, name = "ruger", isSemiAuto = true, width = 303, height = 196}))
	table.insert(gunList, gunData.new({clip = 32, reserve = 96, fireSpeed = 50, reloadSpeed = 750, damage = 200, name = "uzi", isSemiAuto = false, width = 316, height = 267}))
	table.insert(gunList, gunData.new({clip = 30, reserve = 120, fireSpeed = 100, reloadSpeed = 750, damage = 250, name = "ak47", isSemiAuto = false, width = 969, height = 293}))
	table.insert(gunList, gunData.new({clip = 6, reserve = 30, fireSpeed = 600, reloadSpeed = 2000, damage = 1000, name = "mossberg500", isSemiAuto = true, width = 1004, height = 208}))
	table.insert(gunList, gunData.new({clip = 6, reserve = 30, fireSpeed = 1000, reloadSpeed = 2000, damage = 1000, name = "m40", isSemiAuto = true, canPierce = true, width = 1066, height = 230}))
	table.insert(gunList, gunData.new({clip = 100, reserve = 500, fireSpeed = 25, reloadSpeed = 2000, damage = 100, name = "m134", isSemiAuto = false, width = 1084, height = 301}))
	table.insert(gunList, gunData.new({clip = 20, reserve = 100, fireSpeed = 50, reloadSpeed = 750, damage = 300, name = "m16a4", isSemiAuto = true, width = 1083, height = 249}))
	table.insert(gunList, gunData.new({clip = 70, reserve = 210, fireSpeed = 75, reloadSpeed = 900, damage = 300, name = "ppsh41", isSemiAuto = false, width = 858, height = 233}))
	table.insert(gunList, gunData.new({clip = 25, reserve = 150, fireSpeed = 100, reloadSpeed = 750, damage = 200, name = "famas", isSemiAuto = false, width = 557, height = 221}))
	table.insert(gunList, gunData.new({clip = 6, reserve = 24, fireSpeed = 300, reloadSpeed = 1000, damage = 500, name = "python", isSemiAuto = true, width = 336, height = 196}))
	table.insert(gunList, gunData.new({clip = 20, reserve = 100, fireSpeed = 100, reloadSpeed = 500, damage = 300, name = "mp7", isSemiAuto = false, width = 653, height = 294}))
	table.insert(gunList, gunData.new({clip = 15, reserve = 75, fireSpeed = 50, reloadSpeed = 500, damage = 250, name = "mp5k", isSemiAuto = false, width = 659, height = 294}))
	table.insert(gunList, gunData.new({clip = 17, reserve = 60, fireSpeed = 400, reloadSpeed = 500, damage = 150, name = "glock", isSemiAuto = true, width = 293, height = 195}))
	table.insert(gunList, gunData.new({clip = 32, reserve = 180, fireSpeed = 5, reloadSpeed = 500, damage = 150, name = "mac11", isSemiAuto = false, width = 304, height = 219}))
	table.insert(gunList, gunData.new({clip = 12, reserve = 75, fireSpeed = 50, reloadSpeed = 500, damage = 200, name = "cz75", isSemiAuto = true, width = 286, height = 198}))

	gunN1 = gunList[1]
	gunN2 = gunList[2]
	currentGun = gunN1
	currentGun:show()

end

local function mouse(event)
	reticle.x = event.x
	reticle.y = event.y


	if event.isPrimaryButtonDown then
		leftClickIsPressed = true
	else
		leftClickIsPressed = false
		canFireSemiAutomatic = true
	end
end

local function enterFrame(event)
--composer.setVariable( "finalScore", scene.score.num )
	local elapsed = event.time
	composer.setVariable( "finalScore", scene.score.num)
	print(scene.score.num.."\n")
	if player and player.x and player.y and not player.isDead then
		local x, y = player:localToContent( 0, 0 )
		x, y = display.contentCenterX - x, display.contentCenterY - y
		for i = #map, 1, -1 do
			if not (map[i].isDead) then
				map[i].x, map[i].y = map[i].x + x, map[i].y + y
			end
		end
		if player.isDead then
			composer.gotoScene( "HighScore", { time=800, effect="zoomInOutFadeRotate" } )
		end
	end

	if scene.score:getSpawnNumber() == 0 then
		startWave()
	end
end

function scene:show(event)

	local phase = event.phase
	if ( phase == "will" ) then
		for i = #map, 1, -1 do
			map[i].isVisible = true
		end
		Runtime:addEventListener( "enterFrame", enterFrame )
		Runtime:addEventListener("mouse", mouse)
		gameLoopTimer = timer.performWithDelay(17, fireLaser, 0)
		player:start()
	elseif ( phase == "did" ) then

	end
end

function scene:hide(event)

	local phase = event.phase
	if ( phase == "will" ) then
		Runtime:removeEventListener("enterFrame", enterFrame)
		Runtime:removeEventListener("mouse", mouse)
		map.isVisible = false
		for i = #map, 1, -1 do
						map[i].isVisible = false
		end
		currentGun:hide()
		reticle.isVisible = false
		loadBall.isVisible = false
		scene.score.isVisible = false
		scene.score:hide()
		player:pause()
	elseif ( phase == "did" ) then

	end
end

function scene:destroy(event)

end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene
