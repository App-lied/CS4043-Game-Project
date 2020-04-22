local composer = require("composer")

local M = {}

function M.new(gun, options) 
	
	local scene = composer.getScene(composer.getSceneName("current"))
	
	local instance = {}
	
	local x, y = options.x or 0, options.y or 0
	local name, width, height = options.name or "", options.width or 0, options.height or 0
	local gunName = gun.name
	local price = options.price or 1000
	
	if options.name then
		
		local name = options.name
		width, height = options.width, options.height
		local filename = "scene/game/img/"..name..".png"
		instance = display.newImageRect(filename, width, height)
		instance.x, instance.y = x, y
		
		local font = "scene/game/font/Equalize.ttf"
		instance.text = display.newText("[F] "..string.upper(gunName), x, y, font, 22)
		instance.text.isVisible = false
		
	else
		
		width = 50
		height = 100
		instance = display.newRect(x, y, width, height)
		local colour = options.colour or {0, 0, 0}
		instance:setFillColor(unpack(colour))
		
		local font = "scene/game/font/Equalize.ttf"
		instance.text = display.newText("[F] "..string.upper(gunName), x, y - 75, font, 22)
		
	end
	
	
	local canBuy = false
	local function mouse(event)
		
		local cornerX, cornerY = instance:localToContent(-width/2, -height/2)
		
		local bound1 = event.x > cornerX and event.x < cornerX + width
		local bound2 = event.y > cornerY and event.y < cornerY + height
		
		if (bound1 and bound2) then
			
			local x1, y1 = instance:localToContent(0, 0)
			instance.text.x = x1
			instance.text.y = y1 - 75
			instance.text.isVisible = true
			canBuy = true
		else
			instance.text.isVisible = false
			canBuy = false
		end
	end
	
	local function key(event)
		if (event.phase == "down") then
			if (event.keyName == "f" and canBuy and scene.score:get() >= price) then
				scene.score:subtract(price)
				if (gunName == "random") then
					if (currentGun == gunN1) then
						local n = math.random(15)
						currentGun:hide()
						gunList[n]:refresh()
						gunN1 = gunList[n]
						currentGun = gunN1
						currentGun:show()	
					elseif (currentGun == gunN2) then	
						local n = math.random(15)
						currentGun:hide()
						gunList[n]:refresh()
						gunN2 = gunList[n]
						currentGun = gunN2
						currentGun:show()
					end
				else
					for i = #gunList, 1, -1 do
						if (gunName == gunList[i].name) then
							if (currentGun == gunN1) then
								currentGun:hide()
								gunList[i]:refresh()
								gunN1 = gunList[i]
								currentGun = gunN1
								currentGun:show()
							elseif (currentGun == gunN2) then
								currentGun:hide()
								gunList[i]:refresh()
								gunN2 = gunList[i]
								currentGun = gunN2		
								currentGun:show()		
							end
						end
					end
				end
			end
		end
	end
	
	Runtime:addEventListener("mouse", mouse)
	Runtime:addEventListener("key", key)
	
	return instance 
end

return M