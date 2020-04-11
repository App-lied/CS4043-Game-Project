-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


local physics
local platform
local ceiling
local player
local reticle
local laser
local hook
local aIsPressed
local dIsPressed
local rIsPressed
local spaceIsPressed
local leftClickIsPressed
local inAir
local score
local ammo
local reserve
local reload
local ammoAdded
local currentGun
local gun1Ammo
local gun1Res
local gun1Clip
local gun2Ammo
local gun2Res
local gun2Clip
local currentGunClip
local reloading
local reloadSpeed
local fireSpeed
local reloadSpeed
local gun1
local gun2
local gun1Img
local gun2Img
local randStart


local zombiesTable = {}

local backGroup = display.newGroup()
local wallGroup = display.newGroup()
local floorGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()


physics = require("physics")
physics.start()
physics.setGravity(0,15)

local background = display.newImageRect(backGroup, "bg.png", 8000, 5000)
background.x = 1700
background.y = 1400

--walls and floors
--basement floor
local platform1 = display.newRect(floorGroup,1950, 3800, 5380, 84)
platform1:setFillColor(0.5, 0, 1)
--ground floor left
local platform2 = display.newRect(floorGroup, 1550, 2900, 4548, 120)
platform2:setFillColor(0.5, 0, 1)
--ground floor right
local platform3 = display.newRect(floorGroup,4500, 2900, 240, 123)
platform3:setFillColor(0.5, 0, 1)
--left wall
local wall1 = display.newRect(wallGroup, -750, 2150, 88, 3656)
wall1:setFillColor(0.5, 0, 1)
--right bottom wall(basement and bathroom right wall)
local wall2 = display.newRect(wallGroup, 4600, 3000, 100, 1660)
wall2:setFillColor(0.5, 0, 1)
--the bar
local bar = display.newRect(floorGroup,2025, 2750, 1396, 181)
bar:setFillColor(0.5, 0, 1)
--the light in the bar
local light = display.newRect(floorGroup,2950, 2240, 332, 48)
light:setFillColor(0.5, 0, 1)
--first floor left
local platform4 = display.newRect(floorGroup,-450,1700, 628, 124)
platform4:setFillColor(0.5, 0, 1)
--first floor right
local platform5 = display.newRect(floorGroup,2500, 1700, 4116, 124)
platform5:setFillColor(0.5, 0, 1)
--disco bottom wall right
local wall3 = display.newRect(wallGroup,3300, 1060, 96, 150)
wall3:setFillColor(0.5, 0, 1)
--disco bottom wall left
local wall4 = display.newRect(wallGroup,950, 1060, 96, 150)
wall4:setFillColor(0.5, 0, 1)
--right top wall (storage room wall right)
local wall5 = display.newRect(wallGroup,4600,1350, 112, 875)
wall5:setFillColor(0.5, 0, 1)
--second floor right
local platform6 = display.newRect(floorGroup,3650,950, 1920, 116)
platform6:setFillColor(0.5, 0, 1)
--second floor left
local platform7 = display.newRect(floorGroup,400, 950, 2216, 116)
platform7:setFillColor(0.5, 0, 1)
--disco top wall left
local wall6 = display.newRect(wallGroup, 950, -40, 88, 736)
wall6:setFillColor(0.5, 0, 1)
--disco top wall right
local wall7= display.newRect(wallGroup, 3300,-40,88, 736)
wall7:setFillColor(0.5, 0, 1)
--ceiling of the building
--local platform8 = display.newImageRect(mainGroup,"ceiling.png", 2403, 81)
--bottom balcony floor // bathroom ceiling
local platform9 = display.newRect(floorGroup,3950, 2245, 1369, 88)
platform9:setFillColor(0.5, 0, 1)
--bar wall
local wall8 = display.newRect(wallGroup,950, 1800, 88, 150 )
wall8:setFillColor(0.5, 0, 1)

local ak472Text = display.newText("[F] ak47", 300, 120, native.systemFont, 20 )
ak472Text.isVisible = false
local uzi2Text = display.newText("[F] uzi", 300, 120, native.systemFont, 20 )
uzi2Text.isVisible = false
local mossberg2Text = display.newText("[F] mossberg", 300, 120, native.systemFont, 20 )
mossberg2Text.isVisible = false

--Objects
local vending1 = display.newRect(backGroup, 300,400,50,50)
vending1:setFillColor(0,1,0)

local vending2 = display.newRect(backGroup, 15,400,50,50)
vending2:setFillColor(0,0,1)

local vending3 = display.newRect(backGroup, 15,80,50,50)
vending3:setFillColor(1,0,0)

local vendingRand = display.newRect(backGroup, 300,80,50,50)
vendingRand:setFillColor(0,0.8,0.7)

--[[platform = display.newImage(backGroup, "skeleton walls small.png", 500, 500)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25
platform = display.newImageRect(backGroup, "platform.png", 1000, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25
ceiling = display.newImageRect(backGroup, "platform.png", 300, 50)
ceiling.x = display.contentCenterX
ceiling.y = 25]]--

player = display.newImageRect(mainGroup, "square.png", 50, 50)
player.x = display.contentCenterX
player.y = display.contentCenterY

reticle = display.newImageRect(uiGroup, "reticle.png", 50, 50)
reticle.x = display.contentCenterX
reticle.y = display.contentCenterY

hook = display.newImageRect(mainGroup,"hook.png", 25, 25)
hook.x = player.x
hook.y = player.y
hook.isVisible = false

physics.addBody(player, "dynamic", {bounce = 0.0})
physics.addBody(platform1, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform2, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform3, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform4, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform5, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform6, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform7, "kinematic", {bounce = 0.0},{isSensor = true})
--physics.addBody(platform8, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform9, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall1, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall2, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall3, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall4, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall5, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall6, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall7, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(wall8, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(light, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(bar, "kinematic", {bounce = 0.0},{isSensor = true})
--physics.addBody(platform, "static", {bounce = 0.0})
--physics.addBody(ceiling, "static", {bounce = 0.0})

physics.addBody(hook, "dynamic", {isSensor = true})
hook.isBodyActive = false
hook.isBullet = true

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html
floorGroup.deltaPerFrame = {0, 0}
background.deltaPerFrame = {0, 0}

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
	floorGroup.x = floorGroup.x + floorGroup.deltaPerFrame[1]
	floorGroup.y = floorGroup.y + floorGroup.deltaPerFrame[2]
	background.x = background.x + background.deltaPerFrame[1]
	background.y = background.y + background.deltaPerFrame[2]

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
	end
end

-- HUD
score = 1000
local scoreText = display.newText(uiGroup, "score:" ..score, -550 , 50, native.systemFont, 80 )
scoreText:setFillColor( 1, 1, 1 )

ammo = 7
reserve = 35

local ammoText = display.newText(uiGroup, ""..ammo.."/"..reserve, 1250, 1250, native.systemFont, 80 )

local loadBall = display.newCircle(uiGroup, 1320, 1200 , 14 )
local uziImg = display.newImageRect(uiGroup, "gun 1 mag.png", 200, 300 )
uziImg.x = 1400
uziImg.y = 1170
uziImg:toBack()
uziImg.isVisible = false

uziImg2 = display.newImageRect(uiGroup, "gun 1.png", 200, 300)
uziImg2.isVisible = false

-- ruger image needs to be changed
local rugerImg = display.newImageRect(uiGroup, "ruger.png", 150, 150 )
rugerImg.x = 1400
rugerImg.y = 1210
rugerImg:toBack()
rugerImg.isVisible = true

-- ak47 image needs to be changed
local ak47Img = display.newImageRect(uiGroup, "ak47.png", 200, 200 )
ak47Img.x = 1400
ak47Img.y = 1170
ak47Img:toBack()
ak47Img.isVisible = false

-- mossberg image needs to be changed
local mossbergImg = display.newImageRect(uiGroup, "mossberg.png", 300, 300 )
mossbergImg.x = 1400
mossbergImg.y = 1200
mossbergImg:toBack()
mossbergImg.isVisible = false

local function imgRemove()
	rugerImg.isVisible = false
	ak47Img.isVisible = false
	uziImg.isVisible = false
	mossbergImg.isVisible = false
end



local function firerate()
	if reload == true then
		reload = false
	end
end

--guns
ruger = "ruger"
uzi = "uzi"
ak47 = "ak47"
mossberg = "mossberg"
currentGun = ruger
currentGunClip = 7
gun1FireSpeed = 200
gun1ReloadSpeed = 500
gun2FireSpeed = 50
gun2ReloadSpeed = 750
fireSpeed = gun1FireSpeed
reloadSpeed = gun1ReloadSpeed

gun1Ammo = 7
gun1Res = 56
gun1Clip = 7
gun2Ammo = 32
gun2Res = 96
gun2Clip = 32

gun1 = ruger
gun2 = uzi

gunN1 = true
gunN2 = false

gun1Img = rugerImg
gun2Img = uziImg

local uziPurchased = false
local akPurchased = false
local mossbergPurchased = false

--uzi
local function uziEquiped()
	if uziPurchased == true then
		currentGun = uzi
		ammo = 32
		reserve = 96
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "uzi"
			gun1Img = uziImg
			gun1Clip = 32
			gun1FireSpeed = 50
			gun1ReloadSpeed = 750
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = true
			ak47Img.isVisible = false
			mossbergImg.isVisible = false
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "uzi"
			gun2Img = uziImg
			ammo = 32
			reserve = 96
			gun2FireSpeed = 50
			gun2ReloadSpeed = 750
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = true
			ak47Img.isVisible = false
			mossbergImg.isVisible = false
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add [F]
local function uziPurchase()
	if score >= 500 then
		if (reticle.x > -15) and (reticle.x < 50) and (reticle.y > 375) and (reticle.y < 425) then
			uziPurchased = true
			uziEquiped()
			transition.to(loadBall, {x=1200, y=1200, time = 50})
			transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = uzi
		end
	end
end

--ak47
local function ak47Equiped()
	if akPurchased == true then
		currentGun = ak47
		ammo = 30
		reserve = 120
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "ak47"
			gun1Img = ak47Img
			gun1Clip = 30
			gun1FireSpeed = 100
			gun1ReloadSpeed = 750
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = false
			ak47Img.isVisible = true
			mossbergImg.isVisible = false
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "ak47"
			gun2Img = ak47Img
			gun2FireSpeed = 100
			gun2ReloadSpeed = 750
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = false
			ak47Img.isVisible = true
			mossbergImg.isVisible = false
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
local function ak47Purchase()
	if score >= 500 then
		if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 375) and (reticle.y < 425) then
			akPurchased = true
			ak47Equiped()
			transition.to(loadBall, {x=1200, y=1200, time = 50})
			transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = ak47
		end
	end
end
--mossberg
local function mossbergEquiped()
	if mossbergPurchased == true then
		currentGun = mossberg
		ammo = 6
		reserve = 30
		currentGunClip = 6
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "mossberg"
			gun1Img = mossbergImg
			gun1Clip = 6
			gun1FireSpeed = 1000
			gun1ReloadSpeed = 2000
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = false
			ak47Img.isVisible = false
			mossbergImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mossberg"
			gun2Img = mossbergImg
			gun2Clip = 6
			gun2FireSpeed = 1000
			gun2ReloadSpeed = 2000
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = false
			ak47Img.isVisible = false
			mossbergImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
local function mossbergPurchase()
	if score >= 500 then
		if (reticle.x > -10) and (reticle.x < 40) and (reticle.y > 55) and (reticle.y < 105) then
			mossbergPurchased = true
			mossbergEquiped()
			transition.to(loadBall, {x=1200, y=1200, time = 50})
			transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = mossberg
		end
	end
end

--random weapon
randStart = false
local randomAK47
local randomUzi
local randomMossberg

local ak47RandImg = display.newImageRect(uiGroup, "ak47.png", 100, 100 )
ak47RandImg.x = 300
ak47RandImg.y = 150
ak47RandImg.isVisible = false

local uziRandImg = display.newImageRect(uiGroup, "gun 1 mag.png", 100, 100 )
uziRandImg.x = 300
uziRandImg.y = 150
uziRandImg.isVisible = false

local mossbergRandImg = display.newImageRect(uiGroup, "mossberg.png", 150, 150 )
mossbergRandImg.x = 300
mossbergRandImg.y = 150
mossbergRandImg.isVisible = false

local function randPurchase()
	if score >= 1000 then
		if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 55) and (reticle.y < 105) then
			score = score - 1000
			scoreText.text = "score:" ..score
			randStart = true
			local randGun = math.random(3)
			if randGun == 1 then
				ak47RandImg.isVisible = true
				randomAK47 = true
				randomUzi = false
				randomMossberg = false
			elseif randGun == 2 then
				uziRandImg.isVisible = true
				randomUzi = true
				randomAK47 = false
				randomMossberg = false
			elseif randGun == 3 then
				mossbergRandImg.isVisible = true
				randomMossberg = true
				randomAK47 = false
				randomUzi = false
			end
			if randomAK47 == true then
				uziRandImg.isVisible = false
				mossbergRandImg.isVisible = false
			elseif randomMossberg == true then
				ak47RandImg.isVisible = false
				uziRandImg.isVisible = false
			elseif randomUzi == true then
				ak47RandImg.isVisible = false
				mossbergRandImg.isVisible = false
			end
		end
	end
end

local function randPickup()
	if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 105) and (reticle.y < 155) then
		if randomAK47 == true then
			akPurchased = true
			ak47Equiped()
			ak47RandImg.isVisible = false
			randomAK47 = false
			ak472Text.isVisible = false
		elseif randomUzi == true then
			uziPurchased = true
			uziEquiped()
			uziRandImg.isVisible = false
			randomUzi = false
			uzi2Text.isVisible = false
		elseif randomMossberg == true then
			mossbergPurchased = true
			mossbergEquiped()
			mossbergRandImg.isVisible = false
			randomMossberg = false
			mossberg2Text.isVisible = false
		end
	end
end

local function switchGun1()
	if ( gunN1 == false) then
		if loadBall.x == 1320 then
			--call a function which decides the image to use here
			if gun1 ~= gun2 then
				gun1Img.isVisible = true
				gun2Img.isVisible = false
			end
			gun2Ammo = ammo
			gun2Res = reserve
			currentGun = gun1
			ammo = gun1Ammo
			reserve = gun1Res
			currentGunClip = gun1Clip
			fireSpeed = gun1FireSpeed
			reloadSpeed = gun1ReloadSpeed
			ammoText.text = "" ..ammo.. "/" ..reserve
			gunN1 = true
			gunN2 = false
		end
	end
end

local function switchGun2()
	if loadBall.x == 1320 then
		if ( gunN2 == false ) then
			if gun1 ~= gun2 then
				gun1Img.isVisible = false
				gun2Img.isVisible = true
			end
			gun1Ammo = ammo
			gun1Res = reserve
			currentGun = gun2
			ammo = gun2Ammo
			reserve = gun2Res
			currentGunClip = gun2Clip
			fireSpeed = gun2FireSpeed
			reloadSpeed = gun2ReloadSpeed
			ammoText.text = "" ..ammo.. "/" ..reserve
			ammoText.text = "" ..ammo.. "/" ..reserve
			gunN1 = false
			gunN2 = true
		end
	end
end

--Laser

reload = false

function fireLaser()

	if leftClickIsPressed then
		if ammo < 1 then
			reload = true
		elseif ammo > 0 then
			reload = false
		end

		if (loadBall.x == 1320) then
			if reload == false then
				ammo = ammo - 1
				ammoText.text = "" ..ammo.. "/" ..reserve

				local newLaser = display.newImageRect(mainGroup, "laser.png", 15, 40)
				physics.addBody(newLaser, "kinematic", {isSensor = true})
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
				if gunN1 == true then
					fireSpeed = gun1FireSpeed
				elseif gunN2 == true then
					fireSpeed = gun2FireSpeed
				end
				transition.to(loadBall, {x=1200, y=1200, time = fireSpeed})
						transition.to(loadBall, {delay = fireSpeed, x=1320, y=1200, time = fireSpeed})
			end
		end
	end
end

--Reloading
rIsPressed = false

local function reloadGun()
	if gunN1 == true then
		reloadSpeed = gun1ReloadSpeed
		currentGunClip = gun1Clip
	elseif gunN2 == true then
		reloadspeed = gun2ReloadSpeed
		currentGunClip = gun2Clip
	end
	if (reserve > 0 ) then
	if ( ammo < currentGunClip ) then
		if( reserve >= currentGunClip ) then
			transition.to(loadBall, {x=1200, y=1200, time = reloadSpeed})
			transition.to(loadBall, {delay = reloadSpeed, x=1320, y=1200, time = reloadSpeed})
			ammoAdded = currentGunClip - ammo
			reserve = reserve - ammoAdded
			ammo = currentGunClip
			ammoText.text = ammo.. "/" ..reserve
			reload = false
			--use ImageSheet
			if currentGun == uzi then
				uziImg.isVisible = false
				uziImg2.isVisible = true
				uziImg2.x =1400
				uziImg2.y = 1170
			end
		elseif( reserve < currentGunClip) then
			if (ammo + reserve >= currentGunClip) then
				transition.to(loadBall, {x=1200, y=1200, time = reloadSpeed})
				transition.to(loadBall, {delay = reloadSpeed, x=1320, y=1200, time = reloadSpeed})
				reserve = (ammo + reserve) - currentGunClip
				ammo = currentGunClip
				ammoText.text = ammo.. "/" ..reserve
				reload = false
				--use imageSheet
				if currentGun == uzi then
					uziImg.isVisible = false
					uziImg2.isVisible = true
					uziImg2.x =1400
					uziImg2.y = 1170
				end
			elseif (ammo + reserve < currentGunClip) then
				transition.to(loadBall, {x=1200, y=1200, time = reloadSpeed})
				transition.to(loadBall, {delay = reloadSpeed, x=1320, y=1200, time = reloadSpeed})
				ammo = ammo + reserve
				reserve = 0
				ammoText.text = ammo.. "/" ..reserve
				reload = false
				--use imageSheet
				if currentGun == uzi then
					uziImg.isVisible = false
					uziImg2.isVisible = true
					uziImg2.x =1400
					uziImg2.y = 1170
				end
			end
		end
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
		transition.to(player, {x = event.target.x, y = event.target.y, time = 300})
	end
end


--Movement
local function onLanding(event)
	if not (event.other.myName == "zombie") then
		if(event.phase == "began") then
			inAir = false
		elseif(event.phase == "ended") then
			inAir = true
		end
	end
end

aIsPressed = false
dIsPressed = false
wIsPressed = false
local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "d") then
			player.deltaPerFrame = {3.5, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			player.deltaPerFrame = {-3.5, 0}
			aIsPressed = true
		elseif (event.keyName == "w" and not inAir) then
			player:applyLinearImpulse(0, -0.5, player.x, player.y)
			wIsPressed = true
		elseif (event.keyName == "e") then
			fireHook()
		elseif (event.keyName == "r") then
			reloadGun()
		elseif (event.keyName == "1") then
			switchGun1()
		elseif (event.keyName == "2") then
			switchGun2()
		elseif (event.keyName == "f") then
			ak47Purchase()
			uziPurchase()
			mossbergPurchase()
			randPurchase()
			randPickup()
		end
		return true
	end
	if (event.phase == "up") then
		if (event.keyName == "d") then
			dIsPressed = false
		elseif (event.keyName == "a") then
			aIsPressed = false
		elseif (event.keyName == "w") then
			wIsPressed = false
		end
	end
	if not(dIsPressed or aIsPressed) then
		player.deltaPerFrame = {0, 0}
	end
end

--spawn enemies
local function spawnZombie()

	local newZombie = display.newImageRect(mainGroup, "redSquare.png", 50, 50)
	physics.addBody(newZombie, "dynamic", {bounce = 0.0})
	newZombie.myName = "zombie"

	table.insert(zombiesTable, newZombie)

	newZombie.x = math.random(500)
	newZombie.y = platform5.y - 50

end

-- bg movement
local coordX, coordY
local function onEnterFrame(event)
	coordX = player.x
	coordY = player.y
end

aIsPressed = false
dIsPressed = false
wPressed = false
local function moveBackground(event)
	if (event.phase == "down") then
		if (event.keyName == "d" ) then
			--zombie:setLinearVelocity(-365, 0)
			wall1:setLinearVelocity(-365, 0)
			wall2:setLinearVelocity(-365, 0)
			wall3:setLinearVelocity(-365, 0)
			wall4:setLinearVelocity(-365, 0)
			wall5:setLinearVelocity(-365, 0)
			wall6:setLinearVelocity(-365, 0)
			wall7:setLinearVelocity(-365, 0)
			wall8:setLinearVelocity(-365, 0)
			platform1:setLinearVelocity(-365, 0)
			platform2:setLinearVelocity(-365, 0)
			platform3:setLinearVelocity(-365, 0)
			platform4:setLinearVelocity(-365, 0)
			platform5:setLinearVelocity(-365, 0)
			platform6:setLinearVelocity(-365, 0)
			platform7:setLinearVelocity(-365, 0)
			--platform8:setLinearVelocity(-365, 0)
			bar:setLinearVelocity(-365, 0)
			light:setLinearVelocity(-365, 0)
			platform9:setLinearVelocity(-365, 0)
			background.deltaPerFrame = {-6, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			--zombie:setLinearVelocity(365, 0)
			wall1:setLinearVelocity(365, 0)
			wall2:setLinearVelocity(365, 0)
			wall3:setLinearVelocity(365, 0)
			wall4:setLinearVelocity(365, 0)
			wall5:setLinearVelocity(365, 0)
			wall6:setLinearVelocity(365, 0)
			wall7:setLinearVelocity(365, 0)
			wall8:setLinearVelocity(365, 0)
			platform1:setLinearVelocity(365, 0)
			platform2:setLinearVelocity(365, 0)
			platform3:setLinearVelocity(365, 0)
			platform4:setLinearVelocity(365, 0)
			platform5:setLinearVelocity(365, 0)
			platform6:setLinearVelocity(365, 0)
			platform7:setLinearVelocity(365, 0)
			--platform8:setLinearVelocity(365, 0)
			bar:setLinearVelocity(365, 0)
			light:setLinearVelocity(365, 0)
			platform9:setLinearVelocity(365, 0)
			background.deltaPerFrame = {6, 0}
			aIsPressed = true
		end
		return true
	end
	if (event.phase == "up") then
		if (event.keyName == "d") then
			dIsPressed = false
		elseif (event.keyName == "a") then
			aIsPressed = false
		end
	end
	if not(dIsPressed or aIsPressed) then
		wall1:setLinearVelocity(0,0)
		wall2:setLinearVelocity(0,0)
		wall3:setLinearVelocity(0,0)
		wall4:setLinearVelocity(0,0)
		wall5:setLinearVelocity(0,0)
		wall6:setLinearVelocity(0,0)
		wall7:setLinearVelocity(0,0)
		wall8:setLinearVelocity(0,0)
		platform1:setLinearVelocity(0,0)
		platform2:setLinearVelocity(0,0)
		platform3:setLinearVelocity(0,0)
		platform4:setLinearVelocity(0,0)
		platform5:setLinearVelocity(0,0)
		platform6:setLinearVelocity(0,0)
		platform7:setLinearVelocity(0,0)
		--platform8:setLinearVelocity(0,0)
		bar:setLinearVelocity(0,0)
		light:setLinearVelocity(0,0)
		platform9:setLinearVelocity(0,0)
		background.deltaPerFrame = {0,0}
	end
end

local function move()
	if not(dIsPressed or aIsPressed) then
	if ( player.y >= 950  ) then
		--zombie:setLinearVelocity(0, -1400)
		wall1:setLinearVelocity(0, -1400)
		wall2:setLinearVelocity(0, -1400)
		wall3:setLinearVelocity(0, -1400)
		wall4:setLinearVelocity(0, -1400)
		wall5:setLinearVelocity(0, -1400)
		wall6:setLinearVelocity(0, -1400)
		wall7:setLinearVelocity(0, -1400)
		wall8:setLinearVelocity(0, -1400)
		platform1:setLinearVelocity(0,-1400)
		platform2:setLinearVelocity(0,-1400)
		platform3:setLinearVelocity(0,-1400)
		platform4:setLinearVelocity(0,-1400)
		platform5:setLinearVelocity(0,-1400)
		platform6:setLinearVelocity(0,-1400)
		platform7:setLinearVelocity(0,-1400)
		--platform8:setLinearVelocity(0,-1400)
		bar:setLinearVelocity(0,-1400)
		light:setLinearVelocity(0,-1400)
		platform9:setLinearVelocity(0,-1400)
		backGroup.y = backGroup.y - 17
	elseif not inAir then
		floorGroup.y = floorGroup.y
		backGroup.y = backGroup.y
		wallGroup.y = wallGroup.y
	end
	if ( player.y <= 250  ) then
		--zombie:setLinearVelocity(0, -1400)
		wall1:setLinearVelocity(0, 1400)
		wall2:setLinearVelocity(0, 1400)
		wall3:setLinearVelocity(0, 1400)
		wall4:setLinearVelocity(0, 1400)
		wall5:setLinearVelocity(0, 1400)
		wall6:setLinearVelocity(0, 1400)
		wall7:setLinearVelocity(0, 1400)
		wall8:setLinearVelocity(0, 1400)
		platform1:setLinearVelocity(0,1400)
		platform2:setLinearVelocity(0,1400)
		platform3:setLinearVelocity(0,1400)
		platform4:setLinearVelocity(0,1400)
		platform5:setLinearVelocity(0,1400)
		platform6:setLinearVelocity(0,1400)
		platform7:setLinearVelocity(0,1400)
		--platform8:setLinearVelocity(0,-1400)
		bar:setLinearVelocity(0,1400)
		light:setLinearVelocity(0,1400)
		platform9:setLinearVelocity(0,1400)
		backGroup.y = backGroup.y + 17
	elseif not inAir then
		floorGroup.y = floorGroup.y
		backGroup.y = backGroup.y
		wallGroup.y = wallGroup.y
	end
end
end

local function onCollision(event)
	if (event.phase == "began") then
		local obj1 = event.object1
		local obj2 = event.object2

		if ((obj1.myName == "laser" and obj2.myName == "zombie")
		or (obj1.myName == "zombie" and obj2.myName == "laser")
		) then
			display.remove(event.object1)
			display.remove(event.object2)

			for i = #zombiesTable, 1, -1 do
				if (zombiesTable[i] == event.object1 or zombiesTable[i] == event.object2) then
					table.remove(zombiesTable, i)
				end
			end
			score = score + 100
			scoreText.text = "score:" ..score
		end
	end

end

--Gameloops

local ak47Text = display.newText(uiGroup, "[F] ak47 (500)", 300 , 350, native.systemFont, 20 )
ak47Text:setFillColor( 1, 1, 1 )
ak47Text.isVisible = false
local uziText = display.newText(uiGroup, "[F] uzi (500)", 15 , 350, native.systemFont, 20 )
ak47Text:setFillColor( 1, 1, 1 )
uziText.isVisible = false
local mossbergText = display.newText( "[F] mossberg (500)", 15 , 30, native.systemFont, 20 )
mossbergText:setFillColor( 1, 1, 1 )
mossbergText.isVisible = false
local randText = display.newText( "[F] ? (1000)", 300 , 30, native.systemFont, 20 )
randText:setFillColor( 1, 1, 1 )
randText.isVisible = false

local function gameLoopPurchase()
	if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 375) and (reticle.y < 425) then
			ak47Text.isVisible = true
	elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 375) or (reticle.y > 425) then
		ak47Text.isVisible = false
	end
	if (reticle.x > -15) and (reticle.x < 50) and (reticle.y > 375) and (reticle.y < 425) then
			uziText.isVisible = true
	elseif (reticle.x < -15) or (reticle.x > 50)or (reticle.y < 375) or (reticle.y > 425) then
		uziText.isVisible = false
	end
	if (reticle.x > -15) and (reticle.x < 50) and (reticle.y > 55) and (reticle.y < 105) then
			mossbergText.isVisible = true
	elseif (reticle.x < -15) or (reticle.x > 50)or (reticle.y < 55) or (reticle.y > 105) then
			mossbergText.isVisible = false
	end
	if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 55) and (reticle.y < 105) then
			randText.isVisible = true
	elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 55) or (reticle.y > 105) then
			randText.isVisible = false
	end

end

local function gameLoopRandPickup()
		if randomAK47 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				ak472Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				ak472Text.isVisible = false
			end
		elseif randomUzi == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				uzi2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				uzi2Text.isVisible = false
			end
		elseif randomMossberg == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				mossberg2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				mossberg2Text.isVisible = false
			end
		end
	end


local reloadText = display.newText( "", display.contentCenterX, 250, native.systemFont, 50 )
local function gameLoopReload()
	if ammo < 1 then
		reloadText.text ="[R]RELOAD"
	elseif ammo > 0 then
		reloadText.text = ""
	end
end

local gunNameText = display.newText( "" , 1230 , 1160, native.systemFont, 60 )
local function gameLoopEquiped()
	if currentGun == "uzi" then
		gunNameText.text ="UZI"
	elseif currentGun == "ruger" then
		gunNameText.text = "RUGER"
	elseif currentGun == "ak47" then
		gunNameText.text = "AK47"
	elseif currentGun == "mossberg" then
	gunNameText.text = "MOSSBERG"
	end
end

local function gameLoopUziReload()
	if loadBall.x == 1320 then
		if currentGun == uzi then
			if uziImg.isVisible == false then
				uziImg2.isVisible = false
				uziImg.isVisible = true
			end
		end
	end
end

local function gameLoopPurchaseEnd()
	if loadBall.x == 1320 then
		if purchase == true then
			purchased = false
		end
	end
end

local function gameLoopDrift()
	if dIsPressed == false and aIsPressed == false and wIsPressed == false and inAir == false
		then player:setLinearVelocity (0,0)
	end
end

Runtime:addEventListener("enterFrame", frameUpdate)
Runtime:addEventListener("key", movePlayer)
Runtime:addEventListener("key", moveBackground)
Runtime:addEventListener("mouse", onMouseAction)
Runtime:addEventListener("collision", onCollision)
hook:addEventListener("collision", onHookCollision)
player:addEventListener("collision", onLanding)
gameLoopTimer = timer.performWithDelay(fireSpeed, fireLaser, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopReload, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopEquiped, 0)
timer.performWithDelay(1000, reloadGun(), 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopUziReload, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopPurchase, 0)
gameLoopTimer = timer.performWithDelay(2000, spawnZombie, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopRandPickup, 0)
gameLoopTimer = timer.performWithDelay(50, moveBackground, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopDrift, 0)
Runtime:addEventListener("enterFrame", onEnterFrame)
Runtime:addEventListener("enterFrame", move)
gameLoopTimer = timer.performWithDelay( 1000, move, 0)
