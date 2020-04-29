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


physics = require("physics")
physics.start()
physics.setGravity(0,15)

--Objects
local vending1 = display.newRect(300,400,50,50)
vending1:setFillColor(0,1,0)

local vending2 = display.newRect(15,400,50,50)
vending2:setFillColor(0,0,1)

platform = display.newImageRect("platform.png", 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

ceiling = display.newImageRect("platform.png", 300, 50)
ceiling.x = display.contentCenterX
ceiling.y = 25

player = display.newImageRect("square.png", 50, 50)
player.x = display.contentCenterX
player.y = display.contentCenterY

reticle = display.newImageRect("reticle.png", 50, 50)
reticle.x = display.contentCenterX
reticle.y = display.contentCenterY

hook = display.newImageRect("hook.png", 25, 25)
hook.x = player.x
hook.y = player.y
hook.isVisible = false

physics.addBody(player, "dynamic", {bounce = 0.0})
physics.addBody(platform, "static", {bounce = 0.0})
physics.addBody(ceiling, "static", {bounce = 0.0})

physics.addBody(hook, "dynamic")
hook.isBodyActive = false
hook.isSensor = true
hook.isBullet = true

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
	
	hook.x = player.x
	hook.y = player.y
end

--Reticle
local function onMouseAction(event)
	reticle.x = event.x
	reticle.y = event.y
end

local function onTouchAction(event)
	--if 
		timer.performWithDelay({delay = 500},fireLaser())
	--end
end

-- HUD 
score = 1000
local scoreText = display.newText( "score:" ..score, -180 , 20, native.systemFont, 40 )
scoreText:setFillColor( 0.5, 0.5, 0.5 )

ammo = 7
reserve = 35

local ammoText = display.newText( ""..ammo.."/"..reserve, 480, 450, native.systemFont, 40 )

local loadBall = display.newCircle( 520, 425 , 8 )
local uziImg = display.newImageRect("gun 1 mag.png", 130, 170 )
uziImg.x = 560
uziImg.y = 410
uziImg:toBack()
uziImg.isVisible = false

uziImg2 = display.newImageRect("gun 1.png", 130, 170)
uziImg2.isVisible = false

-- ruger image needs to be changed
local rugerImg = display.newImageRect("ruger.png", 75, 100 ) 
rugerImg.x = 570
rugerImg.y = 430
rugerImg:toBack()
rugerImg.isVisible = true

-- ak47 image needs to be changed
local ak47Img = display.newImageRect("ak47.png", 125, 125 ) 
ak47Img.x = 570
ak47Img.y = 420
ak47Img:toBack()
ak47Img.isVisible = false

local function firerate()
	if reload == true then
		reload = false
	end
end

--guns
ruger = "ruger"
uzi = "uzi"
ak47 = "ak47"
currentGun = ruger
currentGunClip = 7
gun1FireSpeed = 200
gun1reloadSpeed = 500
gun2FireSpeed = 50
gun2ReloadSpeed = 750
fireSpeed = 200
reloadSpeed = 500

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

local purchased = false


--uzi
local function uziEquiped()
	if purchased == true then
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
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add [F]
local function uziPurchase()
	if score >= 500 then
		if (reticle.x > -15) and (reticle.x < 50) and (reticle.y > 375) and (reticle.y < 425) then
			purchased = true
			uziEquiped()
			transition.to(loadBall, {x=425, y=425, time = 50})
			transition.to(loadBall, {delay = 50, x=520, y=425, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = uzi
		end
	end
end

--ak47
local function ak47Equiped()
	if purchased == true then
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
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "ak47"
			gun2Img = ak47Img
			gun2FireSpeed = 100
			gun2ReloadSpeed = 750
			--make this an image sheet
			rugerImg.isVisible = false
			uziImg.isVisible = false
			ak47Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
local function ak47Purchase()
	if score >= 500 then
		if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 375) and (reticle.y < 425) then
			purchased = true
			ak47Equiped()
			transition.to(loadBall, {x=425, y=425, time = 50})
			transition.to(loadBall, {delay = 50, x=520, y=425, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = ak47
		end
	end
end

local function switchGun1()
	if ( gunN1 == false) then
		if loadBall.x == 520 then
			--call a function which decides the image to use here
			gun1Img.isVisible = true
			gun2Img.isVisible = false
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
	if loadBall.x == 520 then
		if ( gunN2 == false ) then
			gun1Img.isVisible = false
			gun2Img.isVisible = true
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

	if ammo < 1 then
		reload = true
	elseif ammo > 1 then
		reload = false
	end
	
	if (loadBall.x == 520) then
	if reload == false then
		ammo = ammo - 1
		ammoText.text = "" ..ammo.. "/" ..reserve

		local newLaser = display.newImageRect("laser.png", 15, 40)
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
		
		fireSpeed = gun1FireSpeed
		transition.to(loadBall, {x=425, y=425, time = fireSpeed})
				transition.to(loadBall, {delay = fireSpeed, x=520, y=425, time = fireSpeed})
	end	
	end
end

--Reloading
rIsPressed = false

local function reloadGun()
	if gunN1 == true then
		reloadSpeed = gun1ReloadSpeed
	elseif gunN2 == true then
		reloadspeed = gun2ReloadSpeed
	end
	if ( ammo < currentGunClip ) then
		if( reserve >= currentGunClip ) then
			transition.to(loadBall, {x=425, y=425, time = reloadSpeed})
			transition.to(loadBall, {delay = reloadSpeed, x=520, y=425, time = reloadSpeed})
			ammoAdded = currentGunClip - ammo
			reserve = reserve - ammoAdded
			ammo = currentGunClip
			ammoText.text = ammo.. "/" ..reserve
			reload = false
			--use ImageSheet
			if currentGun == uzi then
				uziImg.isVisible = false
				uziImg2.isVisible = true
				uziImg2.x =560
				uziImg2.y = 410
			end
		elseif( reserve < currentGunClip) then
			if (ammo + reserve >= currentGunClip) then
				transition.to(loadBall, {x=425, y=425, time = reloadSpeed})
				transition.to(loadBall, {delay = reloadSpeed, x=520, y=425, time = reloadSpeed})
				reserve = (ammo + reserve) - currentGunClip
				ammo = currentGunClip
				ammoText.text = ammo.. "/" ..reserve
				reload = false
				--use imageSheet
				if currentGun == uzi then
					uziImg.isVisible = false
					uziImg2.isVisible = true
					uziImg2.x =560
					uziImg2.y = 410
				end
			elseif (ammo + reserve < currentGunClip) then
				transition.to(loadBall, {x=425, y=425, time = reloadSpeed})
				transition.to(loadBall, {delay = reloadSpeed, x=520, y=425, time = reloadSpeed})
				ammo = ammo + reserve
				reserve = 0
				ammoText.text = ammo.. "/" ..reserve
				reload = false
				--use imageSheet
				if currentGun == uzi then
					uziImg.isVisible = false
					uziImg2.isVisible = true
					uziImg2.x =560
					uziImg2.y = 410
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

local function onLanding(event)	 
	if(event.phase == "began") then
		inAir = false
	elseif(event.phase == "ended") then
		inAir = true
	end
end

--Movement
aIsPressed = false
dIsPressed = false
spaceIsPressed = false
local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "d") then
			player.deltaPerFrame = {3.5, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			player.deltaPerFrame = {-3.5, 0}
			aIsPressed = true
		elseif (event.keyName == "space" and not inAir) then
			player:applyLinearImpulse(0, -0.2, player.x, player.y)
			spaceIsPressed = true
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
		end
	end
	if (event.phase == "up") then
		if (event.keyName == "d") then
			dIsPressed = false
		elseif (event.keyName == "a") then
			aIsPressed = false
		end
	end
	if not(dIsPressed or aIsPressed) then
		player.deltaPerFrame = {0, 0}
	end
end

--Gameloops
local ak47Text = display.newText( "[F] ak47 (500)", 300 , 350, native.systemFont, 20 )
ak47Text:setFillColor( 1, 1, 1 )
ak47Text.isVisible = false
local uziText = display.newText( "[F] uzi (500)", 15 , 350, native.systemFont, 20 )
ak47Text:setFillColor( 1, 1, 1 )
uziText.isVisible = false

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
end

local reloadText = display.newText( "", display.contentCenterX, 250, native.systemFont, 50 )
local function gameLoopReload()
	if ammo < 1 then
		reloadText.text ="[R]RELOAD"
	elseif ammo > 0 then
		reloadText.text = ""
	end
end

local gunNameText = display.newText( "" , 480 , 400, native.systemFont, 30 )
local function gameLoopEquiped()
	if currentGun == "uzi" then
		gunNameText.text ="UZI"
	elseif currentGun == "ruger" then
		gunNameText.text = "RUGER"
	elseif currentGun == "ak47" then
		gunNameText.text = "AK47"
	end
end

local function gameLoopUziReload()
	if loadBall.x == 520 then
		if currentGun == uzi then
			if uziImg.isVisible == false then
				uziImg2.isVisible = false
				uziImg.isVisible = true
			end
		end
	end
end

local function gameLoopPurchaseEnd()
	if loadBall.x == 520 then
		if purchase == true then
			purchased = false
		end
	end
end
  
Runtime:addEventListener("enterFrame", frameUpdate)
Runtime:addEventListener("key", movePlayer)
Runtime:addEventListener("mouse", onMouseAction)
Runtime:addEventListener("tap", onTouchAction)
hook:addEventListener("collision", onHookCollision)
player:addEventListener("collision", onLanding)
gameLoopTimer = timer.performWithDelay(100, gameLoopReload, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopEquiped, 0)
timer.performWithDelay(1000, reloadGun(), 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopUziReload, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopPurchase, 0)
