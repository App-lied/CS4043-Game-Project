local M = {}

function M.new(options)
	
	options = options or {}
	
	local gun = {}
	gun.clip = options.clip or 0
	gun.reserve = options.reserve or 0
	gun.fireSpeed = options.fireSpeed or 0
	gun.reloadSpeed = options.reloadSpeed or 0
	gun.damage = options.damage or 0
	gun.name = options.name or "ruger"
	gun.ammo = options.clip or 0
	gun.isSemiAuto = options.isSemiAuto or false
	gun.isReloading = false
	
	local width = options.width or 0
	local height = options.height or 0
	local x, y = options.x or 1200, options.y or 1000
	
	local filename = "scene/game/img/guns/".. gun.name ..".png"
	local img = display.newImageRect(filename, width, height)
	img.x, img.y = x, y
	img.isVisible = false
	
	local font = "scene/game/font/Equalize.ttf"
	local text = display.newText(string.upper(gun.name), x, y + 90, font, 22)
	local text2 = display.newText(gun.ammo.."/"..gun.reserve, x + 200, y + 90, font, 22)
	text.isVisible = false
	text2.isVisible = false
	
	function gun:getAmmo()
		return self.ammo
	end
	
	function gun:getClip()
		return self.clip
	end
	
	function gun:getReserve()
		return self.reserve
	end
	
	function gun:getFireSpeed()
		return self.fireSpeed
	end

	function gun:getReloadSpeed()
		return self.reloadSpeed
	end
	
	function gun:getDamage()
		return self.damage
	end
	
	
	function gun:setAmmo()
			self.ammo = self.ammo - 1
			text2.text = self.ammo.."/"..self.reserve
	end
	
	function gun:reload()
		if (self.reserve > 0 and not self.isReloading) then
			if (self.ammo < self.clip) then
				if(self.reserve >= self.clip) then
					local ammoAdded = self.clip - self.ammo
					self.reserve = self.reserve - ammoAdded
					self.ammo = self.clip
					text2.text = self.ammo.."/"..self.reserve
				elseif(self.reserve < self.clip) then
					if (self.ammo + self.reserve >= self.clip) then
						self.reserve = (self.ammo + self.reserve) - self.clip
						self.ammo = self.clip
						text2.text = self.ammo.."/"..self.reserve
					elseif (self.ammo + self.reserve < self.clip) then
						self.ammo = self.ammo + self.reserve
						self.reserve = 0
						text2.text = self.ammo.."/"..self.reserve
					end
				end
			end
		end	
	end
	
	function gun:show()
		img.isVisible = true
		text.isVisible = true
		text2.isVisible = true
	end
	
	function gun:hide()
		img.isVisible = false
		text.isVisible = false
		text2.isVisible = false
	end
	
	return gun
end

return M