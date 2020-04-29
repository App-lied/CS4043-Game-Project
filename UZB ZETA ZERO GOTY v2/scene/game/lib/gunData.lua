local M = {}

function M.new(options)
	
	options = options or {}
	
	local reloadSound = audio.loadStream( "scene/game/audio/pistol_reload.wav")
	local shotgunReload = audio.loadStream( "scene/game/audio/shotgun_load.wav" )
	local gun = {}
	gun.clip = options.clip or 0
	gun.reserve = options.reserve or 0
	gun.fireSpeed = options.fireSpeed or 0
	gun.reloadSpeed = options.reloadSpeed or 0
	gun.damage = options.damage or 0
	gun.name = options.name or "ruger"
	gun.ammo = options.clip or 0
	gun.range = options.range or 0
	gun.isSemiAuto = options.isSemiAuto or false
	gun.canPierce = options.canPierce or false
	gun.isReloading = false
	
	gun.fullReserve = options.reserve
	
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
	
	local reloadText = display.newText("[R] RELOAD", display.contentCenterX, display.contentCenterY, font, 100)
	reloadText.isVisible = false
	
	local function enterFrame()
		if currentGun.ammo < 1 then
			reloadText.isVisible = true
		else
			reloadText.isVisible = false
		end
	end
	function gun:setAmmo()
			self.ammo = self.ammo - 1
			text2.text = self.ammo.."/"..self.reserve
	end
	
	function gun:reload()
		if (self.reserve > 0 and not self.isReloading) then
			if (self.ammo < self.clip) then
				if currentGun == mossberg then
					audio.play( shotgunReload )
				else
					audio.play( reloadSound )
				end
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
			reloadText.isVisible = false
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
	
	function gun:refresh()
		self.ammo = self.clip
		self.reserve = self.fullReserve
		text2.text = self.ammo.."/"..self.reserve
	end
	Runtime:addEventListener("enterFrame", enterFrame)
	return gun
end

return M