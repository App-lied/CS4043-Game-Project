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
local canFireSemiAutomatic = true
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

local currentWave
local zombiesTable = {}
local zombiesHealth = {}

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

local ak472Text = display.newText("[F] ak47", 300, 120, native.systemFont, 50 )
ak472Text.isVisible = false
local uzi2Text = display.newText("[F] uzi", 300, 120, native.systemFont, 50 )
uzi2Text.isVisible = false
local mossberg2Text = display.newText("[F] mossberg", 300, 120, native.systemFont, 50 )
mossberg2Text.isVisible = false
local m402Text = display.newText("[F] m40", 300, 120, native.systemFont, 50 )
m402Text.isVisible = false
local mini2Text = display.newText("[F] mini gun", 300, 120, native.systemFont, 50 )
mini2Text.isVisible = false
local m162Text = display.newText("[F] m16", 300, 120, native.systemFont, 50 )
m162Text.isVisible = false
local ppsh2Text = display.newText("[F] ppsh41", 300, 120, native.systemFont, 50 )
ppsh2Text.isVisible = false
local famas2Text = display.newText("[F] famas", 300, 120, native.systemFont, 50 )
famas2Text.isVisible = false
local python2Text = display.newText("[F] python", 300, 120, native.systemFont, 50 )
python2Text.isVisible = false
local mp5k2Text = display.newText("[F] mp5k", 300, 120, native.systemFont, 50 )
mp5k2Text.isVisible = false
local glock2Text = display.newText("[F] glock", 300, 120, native.systemFont, 50 )
glock2Text.isVisible = false
local mac112Text = display.newText("[F] mac11", 300, 120, native.systemFont, 50 )
mac112Text.isVisible = false
local cz752Text = display.newText("[F] cz75", 300, 120, native.systemFont, 50 )
cz752Text.isVisible = false
local mp72Text = display.newText("[F] mp7", 300, 120, native.systemFont,50 )
mp72Text.isVisible = false


--Objects
local vending1 = display.newRect(backGroup, 300,400,50,50)
vending1:setFillColor(0,1,0)

local vending2 = display.newRect(backGroup, 15,400,50,50)
vending2:setFillColor(0,0,1)

local vending3 = display.newRect(backGroup, 15,80,50,50)
vending3:setFillColor(1,0,0)

local vendingRand = display.newRect(backGroup, 300,80,50,50)
vendingRand:setFillColor(0,0.8,0.7)

local vending4 = display.newRect(backGroup, 157,80,50,50)
vending4:setFillColor(1,1,0)

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
player.isFixedRotation = true

physics.addBody(platform1, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform2, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform3, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform4, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform5, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform6, "kinematic", {bounce = 0.0},{isSensor = true})
physics.addBody(platform7, "kinematic", {bounce = 0.0},{isSensor = true})
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
mossbergImg.x = 1200
mossbergImg.y = 1200
mossbergImg:toBack()
mossbergImg.isVisible = false

-- m40 image needs to be changed
local m40Img = display.newImageRect(uiGroup, "m40.png", 450, 200 ) 
m40Img.x = 1270
m40Img.y = 1200
m40Img:toBack()
m40Img.isVisible = false

-- mini gun image needs to be changed
local miniImg = display.newImageRect(uiGroup, "minigun.png", 200, 200 ) 
miniImg.x = 1400
miniImg.y = 1200
miniImg:toBack()
miniImg.isVisible = false

-- m16 image needs to be changed
local m16Img = display.newImageRect(uiGroup, "m16.png", 200, 120 ) 
m16Img.x = 1400
m16Img.y = 1200
m16Img:toBack()
m16Img.isVisible = false

-- ppsh image needs to be changed
local ppshImg = display.newImageRect(uiGroup, "ppsh.png", 300, 200 ) 
ppshImg.x = 1400
ppshImg.y = 1200
ppshImg:toBack()
ppshImg.isVisible = false

-- famas image needs to be changed
local famasImg = display.newImageRect(uiGroup, "famas.png", 240, 150 ) 
famasImg.x = 1400
famasImg.y = 1200
famasImg:toBack()
famasImg.isVisible = false

-- python image needs to be changed
local pythonImg = display.newImageRect(uiGroup, "python.png", 180, 100 ) 
pythonImg.x = 1400
pythonImg.y = 1200
pythonImg:toBack()
pythonImg.isVisible = false

-- mp5k image needs to be changed
local mp5kImg = display.newImageRect(uiGroup, "mp5k.png", 200, 120 ) 
mp5kImg.x = 1400
mp5kImg.y = 1200
mp5kImg:toBack()
mp5kImg.isVisible = false

-- glock image needs to be changed
local glockImg = display.newImageRect(uiGroup, "glock.png", 170, 100 ) 
glockImg.x = 1400
glockImg.y = 1200
glockImg:toBack()
glockImg.isVisible = false

-- mac 11 image needs to be changed
local mac11Img = display.newImageRect(uiGroup, "mac11.png", 220, 150 ) 
mac11Img.x = 1400
mac11Img.y = 1200
mac11Img:toBack()
mac11Img.isVisible = false

-- cz75 image needs to be changed
local cz75Img = display.newImageRect(uiGroup, "cz75.png", 200, 120 ) 
cz75Img.x = 1400
cz75Img.y = 1200
cz75Img:toBack()
cz75Img.isVisible = false

-- mp7 image needs to be changed
local mp7Img = display.newImageRect(uiGroup, "mp7.png", 250, 170 ) 
mp7Img.x = 1400
mp7Img.y = 1200
mp7Img:toBack()
mp7Img.isVisible = false

local function imgRemove()
	rugerImg.isVisible = false
	ak47Img.isVisible = false
	uziImg.isVisible = false
	mossbergImg.isVisible = false
	m40Img.isVisible = false
	miniImg.isVisible = false
	m16Img.isVisible = false
	ppshImg.isVisible = false
	famasImg.isVisible = false
	pythonImg.isVisible = false
	mp5kImg.isVisible = false
	glockImg.isVisible = false
	mac11Img.isVisible = false
	cz75Img.isVisible = false
	mp7Img.isVisible = false
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
m40 = "m40"
mini = "mini"
m16 = "m16"
ppsh = "ppsh"
famas = "famas"
python = "python"
mp5k = "mp5k"
glock = "glock"
mac11 = "mac11"
cz75 = "cz75"
mp7 = "mp7"
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
local m40Purchased = false
local miniPurchased = false
local m16Purchased = false
local ppshPurchased = false
local famasPurchased = false
local pythonPurchased = false
local mp5kPurchased = false
local glockPurchased = false
local mac11Purchased = false
local cz75Purchased = false
local mp7Purchased = false

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
			imgRemove()
			uziImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "uzi"
			gun2Img = uziImg
			ammo = 32
			reserve = 96
			gun2FireSpeed = 50
			gun2ReloadSpeed = 750
			imgRemove()
			uziImg.isVisible = true
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
			imgRemove()
			ak47Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "ak47"
			gun2Img = ak47Img
			gun2FireSpeed = 100
			gun2ReloadSpeed = 750
			imgRemove()
			ak47Img.isVisible = true
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
			imgRemove()
			mossbergImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mossberg"
			gun2Img = mossbergImg
			gun2Clip = 6
			gun2FireSpeed = 1000
			gun2ReloadSpeed = 2000
			imgRemove()
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

--m40
local function m40Equiped()
	if m40Purchased == true then
		currentGun = m40
		ammo = 6
		reserve = 30
		currentGunClip = 6
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "m40"
			gun1Img = m40Img
			gun1Clip = 6
			gun1FireSpeed = 1000
			gun1ReloadSpeed = 2000
			imgRemove()
			m40Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "m40"
			gun2Img = m40Img
			gun2Clip = 6
			gun2FireSpeed = 1000
			gun2ReloadSpeed = 2000
			imgRemove()
			m40Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function m40Purchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--m40Purchased = true
			--m40Equiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = m40
		--end
	--end
--end

--mini gun
local function miniEquiped()
	if miniPurchased == true then
		currentGun = mini
		ammo = 100
		reserve = 500
		currentGunClip = 100
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "mini" --"mini gun"
			gun1Img = miniImg
			gun1Clip = 100
			gun1FireSpeed = 25
			gun1ReloadSpeed = 2000
			imgRemove()
			miniImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mini"
			gun2Img = miniImg
			gun2Clip = 100
			gun2FireSpeed = 25
			gun2ReloadSpeed = 2000
			imgRemove()
			miniImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function miniPurchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--miniPurchased = true
			--miniEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = mini
		--end
	--end
--end


--m16
local function m16Equiped()
	if m16Purchased == true then
		currentGun = m16
		ammo = 20
		reserve = 100
		currentGunClip = 20
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "m16"
			gun1Img = m16Img
			gun1Clip = 20
			gun1FireSpeed = 50 --burst fire
			gun1ReloadSpeed = 750
			imgRemove()
			m16Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "m16"
			gun2Img = m16Img
			gun2Clip = 20
			gun2FireSpeed = 50 --burst fire
			gun2ReloadSpeed = 750
			imgRemove()
			m16Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function m16Purchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--m16Purchased = true
			--m16Equiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = m16
		--end
	--end
--end

--ppsh
local function ppshEquiped()
	if ppshPurchased == true then
		currentGun = ppsh
		ammo = 70
		reserve = 210
		currentGunClip = 70
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "ppsh"
			gun1Img = ppshImg
			gun1Clip = 70
			gun1FireSpeed = 75
			gun1ReloadSpeed = 900
			imgRemove()
			ppshImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "ppsh"
			gun2Img = ppshImg
			gun2Clip = 70
			gun2FireSpeed = 75
			gun2ReloadSpeed = 900
			imgRemove()
			ppshImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function ppshPurchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--ppshPurchased = true
			--ppshEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = ppsh
		--end
	--end
--end

--famas
local function famasEquiped()
	if famasPurchased == true then
		currentGun = famas
		ammo = 25
		reserve = 150
		currentGunClip = 25
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "famas"
			gun1Img = famasImg
			gun1Clip = 25
			gun1FireSpeed = 50
			gun1ReloadSpeed = 750
			imgRemove()
			famasImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "famas"
			gun2Img = famasImg
			gun2Clip = 25
			gun2FireSpeed = 50
			gun2ReloadSpeed = 750
			imgRemove()
			famasImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function famasPurchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--famasPurchased = true
			--famasEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = famas
		--end
	--end
--end

--python
local function pythonEquiped()
	if pythonPurchased == true then
		currentGun = python
		ammo = 6
		reserve = 24
		currentGunClip = 6
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "python"
			gun1Img = pythonImg
			gun1Clip = 6
			gun1FireSpeed = 300
			gun1ReloadSpeed = 1000
			imgRemove()
			pythonImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "python"
			gun2Img = pythonImg
			gun2Clip = 6
			gun2FireSpeed = 300
			gun2ReloadSpeed = 1000
			imgRemove()
			pythonImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function pythonPurchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--pythonPurchased = true
			--pythonEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = python
		--end
	--end
--end

--mp5k
local function mp5kEquiped()
	if mp5kPurchased == true then
		currentGun = mp5k
		ammo = 15
		reserve = 75
		currentGunClip = 15
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "mp6k"
			gun1Img = mp5kImg
			gun1Clip = 15
			gun1FireSpeed = 50
			gun1ReloadSpeed = 500
			imgRemove()
			mp5kImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mp5k"
			gun2Img = mp5kImg
			gun2Clip = 15
			gun2FireSpeed = 50
			gun2ReloadSpeed = 50
			imgRemove()
			mp5kImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function m40Purchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--mp5kPurchased = true
			--mp5kEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = mp5k
		--end
	--end
--end

--glock
local function glockEquiped()
	if glockPurchased == true then
		currentGun = glock
		ammo = 17
		reserve = 60
		currentGunClip = 17
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "glock"
			gun1Img = glockImg
			gun1Clip = 17
			gun1FireSpeed = 400
			gun1ReloadSpeed = 500
			imgRemove()
			glockImg.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "glock"
			gun2Img = glockImg
			gun2Clip = 17
			gun2FireSpeed = 400
			gun2ReloadSpeed = 500
			imgRemove()
			glockImg.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function glockPurchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--glockPurchased = true
			--glockEquiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = glock
		--end
	--end
--end

--mac 11
local function mac11Equiped()
	if mac11Purchased == true then
		currentGun = mac11
		ammo = 32
		reserve = 180
		currentGunClip = 32
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "mac11"
			gun1Img = mac11Img
			gun1Clip = 32
			gun1FireSpeed = 5
			gun1ReloadSpeed = 500
			imgRemove()
			mac11Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mac11"
			gun2Img = mac11Img
			gun2Clip = 32
			gun2FireSpeed = 5
			gun2ReloadSpeed = 500
			imgRemove()
			mac11Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function mac11Purchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--mac11Purchased = true
			--mac11Equiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = mac11
		--end
	--end
--end

--cz75
local function cz75Equiped()
	if cz75Purchased == true then
		currentGun = cz75
		ammo = 12
		reserve = 75
		currentGunClip = 12
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "cz75"
			gun1Img = cz75Img
			gun1Clip = 12
			gun1FireSpeed = 50 --burst fire
			gun1ReloadSpeed = 500
			imgRemove()
			cz75Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "cz75"
			gun2Img = cz75Img
			gun2Clip = 12
			gun2FireSpeed = 50
			gun2ReloadSpeed = 500
			imgRemove()
			cz75Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
--local function m40Purchase()
	--if score >= 500 then
		--if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			--cz75Purchased = true
			--cz75Equiped()
			--transition.to(loadBall, {x=1200, y=1200, time = 50})
			--transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			--score = score - 500
			--scoreText.text = "score:" ..score
			--currentGun = cz75
		--end
	--end
--end

--mp7
local function mp7Equiped()
	if mp7Purchased == true then
		currentGun = mp7
		ammo = 20
		reserve = 100
		currentGunClip = 20
		if (gunN1 == true) and (gunN2 == false) then
			gun1 = "mp7"
			gun1Img = mp7Img
			gun1Clip = 20
			gun1FireSpeed = 100
			gun1ReloadSpeed = 500
			imgRemove()
			mp7Img.isVisible = true
		elseif (gunN1 == false) and (gunN2 == true) then
			gun2 = "mp7"
			gun2Img = mp7Img
			gun2Clip = 20
			gun2FireSpeed = 100
			gun2ReloadSpeed = 500
			imgRemove()
			mp7Img.isVisible = true
		end
		ammoText.text = ammo.. "/" ..reserve
	end
end
--add[F]
local function m40Purchase()
	if score >= 500 then
		if (reticle.x > 110) and (reticle.x < 160) and (reticle.y > 55) and (reticle.y < 105) then
			mp7Purchased = true
			mp7Equiped()
			transition.to(loadBall, {x=1200, y=1200, time = 50})
			transition.to(loadBall, {delay = 50, x=1320, y=1200, time = 50})
			score = score - 500
			scoreText.text = "score:" ..score
			currentGun = mp7
		end
	end
end

--random weapon
randStart = false
local randomAK47
local randomUzi
local randomMossberg
local randomM40
local randomMini
local randomM16
local randomPpsh
local randomFamas
local randomPython
local randomMp5k
local randomGlock
local randomMac11
local randomCz75
local randomMp7

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

local m40RandImg = display.newImageRect(uiGroup, "m40.png", 150, 100 ) 
m40RandImg.x = 300
m40RandImg.y = 150
m40RandImg.isVisible = false

local miniRandImg = display.newImageRect(uiGroup, "minigun.png", 150, 100 ) 
miniRandImg.x = 300
miniRandImg.y = 150
miniRandImg.isVisible = false

local m16RandImg = display.newImageRect(uiGroup, "m16.png", 150, 60 ) 
m16RandImg.x = 300
m16RandImg.y = 150
m16RandImg.isVisible = false

local ppshRandImg = display.newImageRect(uiGroup, "ppsh.png", 200, 150 ) 
ppshRandImg.x = 300
ppshRandImg.y = 150
ppshRandImg.isVisible = false

local famasRandImg = display.newImageRect(uiGroup, "famas.png", 150, 100 ) 
famasRandImg.x = 300
famasRandImg.y = 150
famasRandImg.isVisible = false

local pythonRandImg = display.newImageRect(uiGroup, "python.png", 130, 70 ) 
pythonRandImg.x = 300
pythonRandImg.y = 150
pythonRandImg.isVisible = false

local mp5kRandImg = display.newImageRect(uiGroup, "mp5k.png", 150, 100 ) 
mp5kRandImg.x = 300
mp5kRandImg.y = 150
mp5kRandImg.isVisible = false

local glockRandImg = display.newImageRect(uiGroup, "glock.png", 100, 75 ) 
glockRandImg.x = 300
glockRandImg.y = 150
glockRandImg.isVisible = false

local mac11RandImg = display.newImageRect(uiGroup, "mac11.png", 150, 100 ) 
mac11RandImg.x = 300
mac11RandImg.y = 150
mac11RandImg.isVisible = false

local cz75RandImg = display.newImageRect(uiGroup, "cz75.png", 100, 75 ) 
cz75RandImg.x = 300
cz75RandImg.y = 150
cz75RandImg.isVisible = false

local mp7RandImg = display.newImageRect(uiGroup, "mp7.png", 150, 100 ) 
mp7RandImg.x = 300
mp7RandImg.y = 150
mp7RandImg.isVisible = false


local function randGunRemove()
	randomAK47 = false
	randomMossberg = false
	randomUzi = false
	randomM40 = false
	randomMini = false
	randomM16 = false
	randomppsh = false
	randomfamas = false
	randompython = false
	randommp5k = false
	randomglock = false
	randommac11 = false
	randomcz75 = false
	randommp7 = false
end

local function randImgRemove()
	uziRandImg.isVisible = false
	ak47RandImg.isVisible = false
	mossbergRandImg.isVisible = false
	m40RandImg.isVisible = false
	miniRandImg.isVisible = false
	m16RandImg.isVisible = false
	ppshRandImg.isVisible = false
	famasRandImg.isVisible = false
	pythonRandImg.isVisible = false
	mp5kRandImg.isVisible = false
	glockRandImg.isVisible = false
	mac11RandImg.isVisible = false
	cz75RandImg.isVisible = false
	mp7RandImg.isVisible = false
end

local function randPurchase()
	if score >= 1000 then
		if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 55) and (reticle.y < 105) then
			--score = score - 1000
			scoreText.text = "score:" ..score
			randStart = true
			local randGun = math.random(14)
			if randGun == 1 then
				randImgRemove()
				ak47RandImg.isVisible = true
				randGunRemove()
				randomAK47 = true
			elseif randGun == 2 then
				randImgRemove()
				uziRandImg.isVisible = true
				randGunRemove()
				randomUzi = true
			elseif randGun == 3 then
				randImgRemove()
				mossbergRandImg.isVisible = true
				randGunRemove()
				randomMossberg = true
			elseif randGun == 4 then
				randImgRemove()
				m40RandImg.isVisible = true
				randGunRemove()
				randomM40 = true
			elseif randGun == 5 then
				randImgRemove()
				miniRandImg.isVisible = true
				randGunRemove()
				randomMini = true
			elseif randGun == 6 then
				randImgRemove()
				m16RandImg.isVisible = true
				randGunRemove()
				randomM16 = true
			elseif randGun == 7 then
				randImgRemove()
				ppshRandImg.isVisible = true
				randGunRemove()
				randomPpsh = true
			elseif randGun == 8 then
				randImgRemove()
				famasRandImg.isVisible = true
				randGunRemove()
				randomFamas = true
			elseif randGun == 9 then
				randImgRemove()
				pythonRandImg.isVisible = true
				randGunRemove()
				randomPython = true
			elseif randGun == 10 then
				randImgRemove()
				mp5kRandImg.isVisible = true
				randGunRemove()
				randomMp5k = true
			elseif randGun == 11 then
				randImgRemove()
				glockRandImg.isVisible = true
				randGunRemove()
				randomGlock = true
			elseif randGun == 12 then
				randImgRemove()
				mac11RandImg.isVisible = true
				randGunRemove()
				randomMac11 = true
			elseif randGun == 13 then
				randImgRemove()
				cz75RandImg.isVisible = true
				randGunRemove()
				randomCz75 = true
			elseif randGun == 14 then
				randImgRemove()
				mp7RandImg.isVisible = true
				randGunRemove()
				randomMp7 = true
			end
		end
	end
end	

local function randPickup() --functions can only hold 60 variales (more then 60 upvalues)
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
		elseif randomM40 == true then
			m40Purchased = true
			m40Equiped()
			m40RandImg.isVisible = false
			randomM40 = false
			m402Text.isVisible = false
		elseif randomMini == true then
			miniPurchased = true
			miniEquiped()
			miniRandImg.isVisible = false
			randomMini = false
			mini2Text.isVisible = false
		elseif randomM16 == true then
			m16Purchased = true
			m16Equiped()
			m16RandImg.isVisible = false
			randomM16 = false
			m162Text.isVisible = false
		elseif randomPpsh == true then
			ppshPurchased = true
			ppshEquiped()
			ppshRandImg.isVisible = false
			randomPpsh = false
			ppsh2Text.isVisible = false
		elseif randomFamas == true then
			famasPurchased = true
			famasEquiped()
			famasRandImg.isVisible = false
			randomFamas = false
			famas2Text.isVisible = false
		elseif randomPython == true then
			pythonPurchased = true
			pythonEquiped()
			pythonRandImg.isVisible = false
			randomPython = false
			python2Text.isVisible = false
		elseif randomMp5k == true then
			mp5kPurchased = true
			mp5kEquiped()
			mp5kRandImg.isVisible = false
			randomMp5k = false
			mp5k2Text.isVisible = false
		elseif randomGlock == true then
			glockPurchased = true
			glockEquiped()
			glockRandImg.isVisible = false
			randomGlock	= false
			glock2Text.isVisible = false
		end
	end
end

local function randPickup2() --functions can only hold 60 variales (more then 60 upvalues)
	if (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 105) and (reticle.y < 155) then
		if randomMac11 == true then
			mac11Purchased = true
			mac11Equiped()
			mac11RandImg.isVisible = false
			randomMac11 = false
			mac112Text.isVisible = false
		elseif randomCz75 == true then
			cz75Purchased = true
			cz75Equiped()
			cz75RandImg.isVisible = false
			randomCz75 = false
			cz752Text.isVisible = false
		elseif randomMp7 == true then
			mp7Purchased = true
			mp7Equiped()
			mp7RandImg.isVisible = false
			randomMp7 = false
			mp72Text.isVisible = false
		end
	end
end

local function switchGun1()
	if ( gunN1 == false) then
		if loadBall.x == 1320 then
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
	
	if (leftClickIsPressed and canFireSemiAutomatic) then
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
		
				transition.to(loadBall, {x=1200, y=1200, time = fireSpeed})
				transition.to(loadBall, {delay = fireSpeed, x=1320, y=1200, time = fireSpeed})
				
				if (currentGun == "ruger" or currentGun == "mossberg" or currentGun == "python" or currentGun == "glock" or currentGun == "m40") then
					canFireSemiAutomatic = false
				end
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

inAir2 = 2
local function inAirJump()
	if inAir == false then
		inAir2 = 2
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
		elseif (event.keyName == "w" and inAir2 > 0) then
			player:setLinearVelocity(0,0)
			player:applyLinearImpulse(0, -0.5, player.x, player.y)
			wIsPressed = true
			inAir2 = inAir2 - 1
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
			m40Purchase()
			--miniPurchase()
			--m16Purchase()
			--ppshPurchase()
			--famasPurchase()
			--pythonPurchase()
			--mp5kpurchase()
			--glockPurchase()
			--mac11Purchase()
			--cz75Purchase()
			--mp7Purchase()
			randPurchase()
			randPickup()
			randPickup2()
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

--spawn enemies
currentWave = 1

local function spawnZombie()

	local newZombie = display.newImageRect(mainGroup, "redSquare.png", 50, 50)
	physics.addBody(newZombie, "dynamic", {bounce = 0.0})
	newZombie.isFixedRotation = true
	newZombie.myName = "zombie"
	
	local newHealth = 500

	table.insert(zombiesTable, newZombie)
	table.insert(zombiesHealth, newHealth)
	
	local spawnPoint = math.random(2)
	if (spawnPoint == 1) then
		newZombie.x = display.contentCenterX - 1300
		newZombie.y = platform5.y - 50
	elseif (spawnPoint == 2) then
		newZombie.x = display.contentCenterX + 1300
		newZombie.y = platform5.y - 50	
	end

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
						if next(zombiesTable) == nil then
							currentWave = currentWave + 1
							startWave()
						end
					end
				end
			end
		end
	end

end

function startWave()
	timer.performWithDelay(2000, spawnZombie, math.pow(currentWave, 2) - currentWave + 5)
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
local m40Text = display.newText( "[F] m40 (500)", 150 , 30, native.systemFont, 20 )
m40Text:setFillColor( 1, 1, 1 )
m40Text.isVisible = false
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
	if (reticle.x > 125) and (reticle.x < 175) and (reticle.y > 55) and (reticle.y < 105) then
			m40Text.isVisible = true
	elseif (reticle.x < 125) or (reticle.x > 175)or (reticle.y < 55) or (reticle.y > 105) then
			m40Text.isVisible = false
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
		elseif randomM40 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				m402Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				m402Text.isVisible = false
			end
		elseif randomMini == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				mini2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				mini2Text.isVisible = false
			end
		elseif randomM16 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				m162Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				m162Text.isVisible = false
			end
		elseif randomPpsh == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				ppsh2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				ppsh2Text.isVisible = false
			end
		elseif randomFamas == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				famas2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				famas2Text.isVisible = false
			end
		elseif randomPython == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				python2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				python2Text.isVisible = false
			end
		elseif randomMp5k == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				mp5k2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				mp5k2Text.isVisible = false
			end
		elseif randomGlock == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				glock2Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				glock2Text.isVisible = false
			end
		elseif randomMac11 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				mac112Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				mac112Text.isVisible = false
			end
		elseif randomCz75 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				cz752Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				cz752Text.isVisible = false
			end
		elseif randomMp7 == true then
			if  (reticle.x > 275) and (reticle.x < 325) and (reticle.y > 125) and (reticle.y < 175) then
				mp72Text.isVisible = true
			elseif (reticle.x < 275) or (reticle.x > 325)or (reticle.y < 125) or (reticle.y > 175) then
				mp72Text.isVisible = false
			end
		end
end
		

local reloadText = display.newText( "", display.contentCenterX, display.contentCenterY, native.systemFont, 100 )
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
	elseif currentGun == "m40" then
		gunNameText.text = "M40"
	elseif currentGun == "mini" then
		gunNameText.text = "MINI GUN"
	elseif currentGun == "m16" then
		gunNameText.text = "M16"
	elseif currentGun == "ppsh" then
		gunNameText.text = "PPSH-41"
	elseif currentGun == "famas" then
		gunNameText.text = "FAMAS"
	elseif currentGun == "python" then
		gunNameText.text = "PYTHON"
	elseif currentGun == "mp5k" then
		gunNameText.text = "MP5K"
	elseif currentGun == "glock" then
		gunNameText.text = "GLOCK"
	elseif currentGun == "mac11" then
		gunNameText.text = "MAC11"
	elseif currentGun == "cz75" then
		gunNameText.text = "CZ75"
	elseif currentGun == "mp7" then
		gunNameText.text = "MP7"
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
gameLoopTimer = timer.performWithDelay(17, fireLaser, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopReload, 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopEquiped, 0)
timer.performWithDelay(1000, reloadGun(), 0)
gameLoopTimer = timer.performWithDelay(100, gameLoopUziReload, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopPurchase, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopRandPickup, 0)
gameLoopTimer = timer.performWithDelay(50, moveBackground, 0)
gameLoopTimer = timer.performWithDelay(50, gameLoopDrift, 0)
gameLoopTimer = timer.performWithDelay(100, inAirJump, 0)
Runtime:addEventListener("enterFrame", onEnterFrame)
Runtime:addEventListener("enterFrame", move)
startWave()