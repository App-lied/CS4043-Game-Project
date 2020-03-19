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


local zombiesTable = {}
local zombiesHealth = {}

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()


physics = require("physics")
physics.start()
physics.setGravity(0,15)

--Objects
local vending1 = display.newRect(backGroup, 300,400,50,50)
vending1:setFillColor(0,1,0)

local vending2 = display.newRect(backGroup, 15,400,50,50)
vending2:setFillColor(0,0,1)

local vending3 = display.newRect(backGroup, 15,80,50,50)
vending3:setFillColor(1,0,0)

local vendingRand = display.newRect(backGroup, 300,80,50,50)
vendingRand:setFillColor(0,0.8,0.7)

platform = display.newImageRect(backGroup, "platform.png", 1000, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight - 25

ceiling = display.newImageRect(backGroup, "platform.png", 300, 50)
ceiling.x = display.contentCenterX
ceiling.y = 25

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
physics.addBody(platform, "static", {bounce = 0.0})
physics.addBody(ceiling, "static", {bounce = 0.0})

physics.addBody(hook, "dynamic", {isSensor = true})
hook.isBodyActive = false
hook.isBullet = true

player.deltaPerFrame = {0, 0} --https://docs.coronalabs.com/tutorial/events/continuousActions/index.html

local function frameUpdate()
	player.x = player.x + player.deltaPerFrame[1]
	player.y = player.y + player.deltaPerFrame[2]
	
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
local scoreText = display.newText(uiGroup, "score:" ..score, -150 , 50, native.systemFont, 40 )
scoreText:setFillColor( 0.5, 0.5, 0.5 )

ammo = 7
reserve = 35

local ammoText = display.newText(uiGroup, ""..ammo.."/"..reserve, 480, 450, native.systemFont, 40 )

local loadBall = display.newCircle(uiGroup, 520, 425 , 8 )
local uziImg = display.newImageRect(uiGroup, "gun 1 mag.png", 130, 170 )
uziImg.x = 560
uziImg.y = 410
uziImg:toBack()
uziImg.isVisible = false

uziImg2 = display.newImageRect(uiGroup, "gun 1.png", 130, 170)
uziImg2.isVisible = false

-- ruger image needs to be changed
local rugerImg = display.newImageRect(uiGroup, "ruger.png", 75, 100 ) 
rugerImg.x = 570
rugerImg.y = 430
rugerImg:toBack()
rugerImg.isVisible = true

-- ak47 image needs to be changed
local ak47Img = display.newImageRect(uiGroup, "ak47.png", 125, 125 ) 
ak47Img.x = 570
ak47Img.y = 420
ak47Img:toBack()
ak47Img.isVisible = false

-- mossberg image needs to be changed
local mossbergImg = display.newImageRect(uiGroup, "mossberg.png", 150, 150 ) 
mossbergImg.x = 540
mossbergImg.y = 420
mossbergImg:toBack()
mossbergImg.isVisible = false

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
			transition.to(loadBall, {x=425, y=425, time = 50})
			transition.to(loadBall, {delay = 50, x=520, y=425, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = ak47
		end
	end
end
--mossberg
local function mossbergEquiped()
	if purchased == true then
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
			purchased = true
			mossbergEquiped()
			transition.to(loadBall, {x=425, y=425, time = 50})
			transition.to(loadBall, {delay = 50, x=520, y=425, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = mossberg
		end
	end
end

--random weapon
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
			purchased = true
			score = score - 1000
			scoreText.text = "score:" ..score
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

local function switchGun1()
	if ( gunN1 == false) then
		if loadBall.x == 520 then
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
	if loadBall.x == 520 then
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
		
		if (loadBall.x == 520) then
			if reload == false then
				ammo = ammo - 1
				ammoText.text = "" ..ammo.. "/" ..reserve

				local newLaser = display.newImageRect(mainGroup, "laser.png", 15, 40)
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
				if gunN1 == true then
					fireSpeed = gun1FireSpeed
				elseif gunN2 == true then
					fireSpeed = gun2FireSpeed
				end
				transition.to(loadBall, {x=425, y=425, time = fireSpeed})
						transition.to(loadBall, {delay = fireSpeed, x=520, y=425, time = fireSpeed})
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
local function movePlayer(event)
	if (event.phase == "down") then
		if (event.keyName == "d") then
			player.deltaPerFrame = {3.5, 0}
			dIsPressed = true
		elseif (event.keyName == "a") then
			player.deltaPerFrame = {-3.5, 0}
			aIsPressed = true
		elseif (event.keyName == "w" and not inAir) then
			player:applyLinearImpulse(0, -0.2, player.x, player.y)
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

--spawn enemies
local function spawnZombie()

	local newZombie = display.newImageRect(mainGroup, "redSquare.png", 50, 50)
	physics.addBody(newZombie, "dynamic", {bounce = 0.0})
	newZombie.myName = "zombie"
	
	local newHealth = 500

	table.insert(zombiesTable, newZombie)
	table.insert(zombiesHealth, newHealth)
	
	newZombie.x = math.random(500)
	newZombie.y = platform.y - 50

end

local function onCollision(event)
	if (event.phase == "began") then
		local obj1 = event.object1
		local obj2 = event.object2

		if ((obj1.myName == "laser" and obj2.myName == "zombie")
		or (obj1.myName == "zombie" and obj2.myName == "laser")
		) then
			
			local opposite
			
			if (obj1.myName == "laser") then
				opposite = obj2
				display.remove(obj1)
			elseif (obj2.myName == "laser") then
				opposite = obj1
				display.remove(obj2)
			end
			
			for i = #zombiesTable, 1, -1 do
				if (zombiesTable[i] == event.object1 or zombiesTable[i] == event.object2) then
					if (currentGun == "ruger") then
						zombiesHealth[i] = zombiesHealth[i] - 200
					elseif (currentGun == "uzi") then
						zombiesHealth[i] = zombiesHealth[i] - 100
					elseif (currentGun == "ak47") then
						zombiesHealth[i] = zombiesHealth[i] - 250
					elseif (currentGun == "mossberg") then
						zombiesHealth[i] = zombiesHealth[i] - 250						
					end
					
					if (zombiesHealth[i] <= 0) then
						display.remove(opposite)
						table.remove(zombiesHealth, i)
						table.remove(zombiesTable, i)
						
						score = score + 100
						scoreText.text = "score:" ..score
					end
				end
			end
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
	elseif currentGun == "mossberg" then
	gunNameText.text = "MOSSBERG"
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