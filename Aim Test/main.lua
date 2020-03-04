-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local background = display.newImageRect("background.jpg", 1100, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local asteroidsTable = {}

local i = 0
local ship
local physics = require("physics")

physics.start()
physics.addBody(background, "static", {radius=50000})

local sheetOptions =
{
  frames =
  {
    {
      x = 0,
      y = 0,
      width = 102,
      height = 85
    },
    {
      x = 0,
      y = 85,
      width = 90,
      height = 83
    },
    {
      x = 0,
      y = 265,
      width = 98,
      height = 79
    },
    {
      x = 98,
      y = 265,
      width = 14,
      height = 40
    },

    },
  }
  local objectSheet = graphics.newImageSheet("gameObjects.png", sheetOptions)

local backgroup = display.newGroup()
local blast = display.newGroup()
local ship = display.newGroup()

ship = display.newImageRect(ship, objectSheet, 3, 49, 36.5)
ship.x = display.contentCenterX
ship.y = display.contentCenterY

local circle = display.newCircle( 5, 5, 10 )
  circle:setFillColor( 0, 1, 0 )
  local x1 = (display.contentCenterX)
  local y1 = (display.contentCenterY)

  local function aim( event )
    circle.x = event.x
    circle.y = event.y
    local length = math.sqrt((circle.x-x1)^2+(circle.y-y1)^2)
    local sine = (circle.y-y1)
    local degrees = (math.asin(sine/length))*(180/math.pi)
    print("Circle x:"..circle.x)
    print("Circle y:"..circle.y)
    print("ship x:"..x1)
    print("ship Y:"..y1)
    print("sine:"..sine)
    print("length:"..length)
    print("degrees:"..degrees)
    if (circle.x<x1) then
    ship.rotation = 180-degrees+90
  end
    if (circle.x>x1) then
      ship.rotation = degrees+90
    end
  end

local function fireLaser(Shoot)
  if (Shoot.isPrimaryButtonDown) then
    circle.x = Shoot.x
    circle.y = Shoot.y
    local newLaser = display.newImageRect(blast, objectSheet, 4, 14, 40)
    newLaser.isBullet = true
    newLaser.myName = "laser"

    newLaser.x = ship.x
    newLaser.y = ship.y
    newLaser:toBack()

      local sine = math.abs(circle.y-y1)
      local cose = math.abs(circle.x-x1)
      print(sine.."  "..cose)
      local length = math.sqrt((circle.x-x1)^2+(circle.y-y1)^2)
      local degrees = math.deg(math.atan(sine/cose))
      print(degrees)
      if (circle.y<y1) then
        if(circle.x>x1) then
          newLaser.rotation = 180-degrees+90
        else
          newLaser.rotation = degrees+90
        end
      end
      if (circle.y>=y1) then
        if(circle.x>x1) then
          newLaser.rotation = degrees+90
        else
          newLaser.rotation = 360-degrees+90
        end
      end

      local x2 = (5*circle.x-(4*x1))/(1)
      local y2 = (5*circle.y-(4*y1))/(1)
      local time = (length*2)
      transition.to( newLaser, {x=x2, y=y2, time=time,
          onComplete = function()display.remove(newLaser)end
      })
end
end

--[[local function createAsteroid()

  local newAsteroid = display.newImageRect(ship, objectSheet, 1, 102, 85)
  table.insert( asteroidsTable, newAsteroid)
  physics.addBody( newAsteroid, "dynamic", {radius=40, bounce=0.8})
  newAsteroid.myName = "asteroid"

  local whereFrom = math.random(3)

  if (whereFrom == 1) then
    newAsteroid.x = -60
    newAsteroid.y = math.random(500)
    newAsteroid:setLinearVelocity(math.random(40,120),math.random(20,60))
  elseif (whereFrom == 3) then
    newAsteroid.x = math.random(display.contentWidth)
    newAsteroid.y = -60
    newAsteroid:setLinearVelocity(math.random(-40,40),math.random(40,120))
  elseif (whereFrom == 3) then
    newAsteroid.x = display.contentWidth+60
    newAsteroid.y = math.random(500)
    newAsteroid:setLinearVelocity(math.random(-120,-40),math.random(20,60))
  end

  newAsteroid:applyTorque(math.random(-6,6))
end

local function gameLoop()

createAsteroid()

  for i = #asteroidsTable, 1, -1 do
    local thisAsteroid = asteroidsTable[i]

    if (thisAsteroid.x < -100 or
       thisAsteroid.x > display.contentWidth +100 or
       thisAsteroid.y < -100 or
       thisAsteroid.y > display.contentHeight+100)
    then
      display.remove(thisAsteroid)
      table.remove(asteroidsTable, i)

    end
  end
end

gameLoopTimer = timer.performWithDelay(1000, gameLoop, 0)
]]


background:addEventListener("mouse",fireLaser)
background:addEventListener("mouse", aim )
