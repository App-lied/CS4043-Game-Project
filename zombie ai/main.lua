-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local horizontalLine11 = display.newRect( display.contentScaleX + 40, display.contentCenterY - 80, 70, 5)
local horizontalLine12 = display.newRect( display.contentScaleX + 40, display.contentCenterY , 70, 5)
local horizontalLine32 = display.newRect( display.contentScaleX + 200, display.contentCenterY , 70, 5)
local horizontalLine41 = display.newRect( display.contentScaleX + 280, display.contentCenterY - 80, 70, 5)
local verticalLine21 = display.newRect( display.contentScaleX + 160, display.contentCenterY - 120, 5, 70)
local verticalLine24 = display.newRect( display.contentScaleX + 160, display.contentCenterY + 120, 5, 70)
local verticalLine34 = display.newRect( display.contentScaleX + 240, display.contentCenterY + 120, 5, 80)
local horizontalLine44 = display.newRect( display.contentScaleX + 280, display.contentCenterY + 80, 80, 5)

local spots = {}
local player = true -- player goes first

for i = 1, 16 do
	spots[i] = display.newRect(0, 0, 70, 70)
	spots[i]:setFillColor( 0.2, 0.2, 0.2)
	spots[i].x = ( i - 1 ) % 4 * 80 + 40
	spots[i].y = math.floor((i - 1) / 4 ) * 80 + 120
end

local isDead = false

local blueBall = display.newCircle( spots[13].x , spots[13].y , 30 )
blueBall:setFillColor(0,0,1)

local redBall = display.newCircle( spots[4].x, spots[4].y , 30 )
redBall:setFillColor(1,0,0)

local function handleMoveSpot1( event ) --code to travel to spot 1
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if blueBall.x == ( spots[2].x)then
				if blueBall.y == spots[2].y then
					transition.to(blueBall, {x = spots[1].x, y = spots[1].y })
					player = false
				end	
			end
		end			
	end	
	end
end

local function handleMoveSpot2( event ) --code to travel to spot 2
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[1].x and blueBall.y == spots[1].y) or (blueBall.x ==  spots[6].x and blueBall.y == spots[6].y)) then
				transition.to(blueBall, {x = spots[2].x, y = spots[2].y })
				player = false
			end	
		end
	end
	end	
end	

local function handleMoveSpot3( event ) --code to travel to spot 3
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[4].x and blueBall.y == spots[4].y) or (blueBall.x ==  spots[7].x and blueBall.y == spots[7].y)) then
				transition.to(blueBall, {x = spots[3].x, y = spots[3].y })				
				player = false
			end	
		end
	end
	end
end	

local function handleMoveSpot4( event ) --code to travel to spot 4
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if blueBall.x == ( spots[3].x)then
				if blueBall.y == spots[3].y then
					transition.to(blueBall, {x = spots[4].x, y = spots[4].y })				
					player = false
				end	
			end
		end			
	end
	end
end

local function handleMoveSpot5( event ) --code to travel to spot 5
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if blueBall.x == ( spots[6].x)then
				if blueBall.y == spots[6].y then
					transition.to(blueBall, {x = spots[5].x, y = spots[5].y })				
					player = false
				end	
			end
		end			
	end	
	end
end

local function handleMoveSpot6( event ) --code to travel to spot 6
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[2].x and blueBall.y == spots[2].y) or (blueBall.x ==  spots[5].x and blueBall.y == spots[5].y) or (blueBall.x == spots[7].x and blueBall.y == spots[7].y) or (blueBall.x == spots[10].x and blueBall.y == spots[10].y)) then
				transition.to(blueBall, {x = spots[6].x, y = spots[6].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot7( event ) --code to travel to spot 7
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[3].x and blueBall.y == spots[3].y) or (blueBall.x ==  spots[6].x and blueBall.y == spots[6].y) or (blueBall.x == spots[8].x and blueBall.y == spots[8].y)) then
				transition.to(blueBall, {x = spots[7].x, y = spots[7].y })				
				player = false
			end	
		end
	end
	end
end	

local function handleMoveSpot8( event ) --code to travel to spot 8
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[7].x and blueBall.y == spots[7].y) or (blueBall.x ==  spots[12].x and blueBall.y == spots[12].y)) then
				transition.to(blueBall, {x = spots[8].x, y = spots[8].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot9( event ) --code to travel to spot 9
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[10].x and blueBall.y == spots[10].y) or (blueBall.x ==  spots[13].x and blueBall.y == spots[13].y)) then
				transition.to(blueBall, {x = spots[9].x, y = spots[9].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot10( event ) --code to travel to spot 10
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[6].x and blueBall.y == spots[6].y) or (blueBall.x ==  spots[9].x and blueBall.y == spots[9].y) or (blueBall.x == spots[11].x and blueBall.y == spots[11].y) or (blueBall.x == spots[14].x and blueBall.y == spots[14].y)) then
				transition.to(blueBall, {x = spots[10].x, y = spots[10].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot11( event ) --code to travel to spot 11
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[10].x and blueBall.y == spots[10].y) or (blueBall.x ==  spots[12].x and blueBall.y == spots[12].y) or (blueBall.x == spots[15].x and blueBall.y == spots[15].y)) then
				transition.to(blueBall, {x = spots[11].x, y = spots[11].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot12( event ) --code to travel to spot 12
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[8].x and blueBall.y == spots[8].y) or (blueBall.x ==  spots[11].x and blueBall.y == spots[11].y) or (blueBall.x == spots[16].x and blueBall.y == spots[16].y)) then
				transition.to(blueBall, {x = spots[12].x, y = spots[12].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot13( event ) --code to travel to spot 13
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[9].x and blueBall.y == spots[9].y) or (blueBall.x ==  spots[14].x and blueBall.y == spots[14].y)) then
				transition.to(blueBall, {x = spots[13].x, y = spots[13].y })				
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot14( event ) --code to travel to spot 14
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if ((blueBall.x ==  spots[10].x and blueBall.y == spots[10].y) or (blueBall.x ==  spots[13].x and blueBall.y == spots[13].y)) then
				transition.to(blueBall, {x = spots[14].x, y = spots[14].y })
				player = false
			end	
		end
	end	
	end
end	

local function handleMoveSpot15( event ) --code to travel to spot 15
	if player == true then
	if isDead == false then
		if event.phase == "began" then
			if blueBall.x == ( spots[11].x)then
				if blueBall.y == spots[11].y then
					transition.to(blueBall, {x = spots[15].x, y = spots[15].y })				
					player = false
				end	
			end
		end			
	end	
	end
end


spots[1]:addEventListener( "touch", handleMoveSpot1 )
spots[2]:addEventListener( "touch", handleMoveSpot2 )
spots[3]:addEventListener( "touch", handleMoveSpot3 )
spots[4]:addEventListener( "touch", handleMoveSpot4 )
spots[5]:addEventListener( "touch", handleMoveSpot5 )
spots[6]:addEventListener( "touch", handleMoveSpot6 )
spots[7]:addEventListener( "touch", handleMoveSpot7 )
spots[8]:addEventListener( "touch", handleMoveSpot8 )
spots[9]:addEventListener( "touch", handleMoveSpot9 )
spots[10]:addEventListener( "touch", handleMoveSpot10 )
spots[11]:addEventListener( "touch", handleMoveSpot11 )
spots[12]:addEventListener( "touch", handleMoveSpot12 )
spots[13]:addEventListener( "touch", handleMoveSpot13 )
spots[14]:addEventListener( "touch", handleMoveSpot14 )
spots[15]:addEventListener( "touch", handleMoveSpot15 )
	
-- redBall at spot 1
local function gameLoop1()
	if player == false then
		if isDead == false then
		if (redBall.x == spots[1].x and redBall.y == spots[1].y)
			then
				transition.to(redBall, {x = spots[2].x, y = spots[2].y })
				player = true
		end
		end
	end
end	

-- redBall at spot 2
local function gameLoop2()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[2].x and redBall.y == spots[2].y) then
			if (blueBall.x == spots[1].x and blueBall.y == spots[1].y) then
					transition.to(redBall, {x = spots[1].x, y = spots[1].y })
					player = true
				else transition.to(redBall, {x = spots[6].x, y = spots[6].y })
					player = true
			end
		end
	end
	end
end

-- redBall at spot 3
local function gameLoop3()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[3].x and redBall.y == spots[3].y) then
			if (blueBall.x == spots[4].x and blueBall.y == spots[4].y) then
					transition.to(redBall, {x = spots[4].x, y = spots[4].y })
					player = true
				else transition.to(redBall, {x = spots[7].x, y = spots[7].y })
					player = true
			end
		end
	end
	end
end

-- redBall at spot 4
local function gameLoop4()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[4].x and redBall.y == spots[4].y)
			then
				transition.to(redBall, {x = spots[3].x, y = spots[3].y })
				player = true
		end
	end
	end
end	

-- redBall at spot 5
local function gameLoop5()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[5].x and redBall.y == spots[5].y)
			then
				transition.to(redBall, {x = spots[6].x, y = spots[6].y })
				player = true
		end
	end
	end
end	

-- redBall at spot 6
local function gameLoop6()
	local randomMove = math.random(2)
	if player == false then	
	if isDead == false then
		if (redBall.x == spots[6].x and redBall.y == spots[6].y) then
			if ( blueBall.x == spots[1].x and blueBall.y == spots[1].y) or ( blueBall.x == spots[2].x and blueBall.y == spots[2].y )
				then
					transition.to(redBall, {x = spots[2].x, y = spots[2].y })
					player = true
			elseif (blueBall.x == spots[5].x and blueBall.y == spots[5].y )
				then transition.to(redBall, {x = spots[5].x, y = spots[5].y })
					player = true
			elseif ( blueBall.x == spots[3].x and blueBall.y == spots[3].y) or ( blueBall.x == spots[4].x and blueBall.y == spots[4].y ) or ( blueBall.x == spots[1].x and blueBall.y == spots[1].y) or ( blueBall.x == spots[7].x and blueBall.y == spots[7].y ) or ( blueBall.x == spots[1].x and blueBall.y == spots[1].y) or ( blueBall.x == spots[8].x and blueBall.y == spots[8].y )
				then transition.to(redBall, {x = spots[7].x, y = spots[7].y })
					player = true
			elseif (blueBall.x == spots[12].x and blueBall.y == spots[12].y) or ( blueBall.x == spots[16].x and blueBall.y == spots[16].y )  then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[7].x, y = spots[7].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[10].x, y = spots[10].y })
					player = true
				end	
			elseif ( blueBall.x == spots[9].x and blueBall.y == spots[9].y) or ( blueBall.x == spots[10].x and blueBall.y == spots[10].y ) or ( blueBall.x == spots[11].x and blueBall.y == spots[11].y) or ( blueBall.x == spots[13].x and blueBall.y == spots[13].y ) or ( blueBall.x == spots[14].x and blueBall.y == spots[14].y) or ( blueBall.x == spots[15].x and blueBall.y == spots[15].y )
				then transition.to(redBall, {x = spots[10].x, y = spots[10].y })	
					player = true
			end
		end
	end
	end
end

-- redBall at spot 7
local function gameLoop7()
	local randomMove = math.random(2)
	if player == false then
	if isDead == false then
		if (redBall.x == spots[7].x and redBall.y == spots[7].y) then
			if ( blueBall.x == spots[3].x and blueBall.y == spots[3].y) or ( blueBall.x == spots[4].x and blueBall.y == spots[4].y )
				then
					transition.to(redBall, {x = spots[3].x, y = spots[3].y })
					player = true
			elseif (blueBall.x == spots[8].x and blueBall.y == spots[8].y ) or ( blueBall.x == spots[12].x and blueBall.y == spots[12].y ) or ( blueBall.x == spots[16].x and blueBall.y == spots[16].y )
				then transition.to(redBall, {x = spots[8].x, y = spots[8].y })
					player = true
			elseif ( blueBall.x == spots[1].x and blueBall.y == spots[1].y) or ( blueBall.x == spots[2].x and blueBall.y == spots[2].y ) or ( blueBall.x == spots[5].x and blueBall.y == spots[5].y) or ( blueBall.x == spots[6].x and blueBall.y == spots[6].y ) or ( blueBall.x == spots[9].x and blueBall.y == spots[9].y) or ( blueBall.x == spots[10].x and blueBall.y == spots[10].y ) or ( blueBall.x == spots[13].x and blueBall.y == spots[13].y ) or ( blueBall.x == spots[14].x and blueBall.y == spots[14].y )
				then transition.to(redBall, {x = spots[6].x, y = spots[6].y })
					player = true
			elseif (blueBall.x == spots[11].x and blueBall.y == spots[11].y) or ( blueBall.x == spots[15].x and blueBall.y == spots[15].y )  then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[6].x, y = spots[6].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[8].x, y = spots[8].y })
					player = true
				end	
			
			end
		end
	end
	end
end

-- redBall at spot 8
local function gameLoop8()
	local randomMove = math.random(2)
	if player == false then
	if isDead == false then
		if (redBall.x == spots[8].x and redBall.y == spots[8].y) then
			if (blueBall.x <= spots[8].x and blueBall.y <= spots[8].y) then
					transition.to(redBall, {x = spots[7].x, y = spots[7].y })
					player = true
			elseif (blueBall.x == spots[11].x and blueBall.y == spots[11].y ) or ( blueBall.x == spots[12].x and blueBall.y == spots[12].y )  or ( blueBall.x == spots[15].x and blueBall.y == spots[15].y )  or ( blueBall.x == spots[16].x and blueBall.y == spots[16].y ) then
				transition.to(redBall, {x = spots[12].x, y = spots[12].y })
				player = true
			elseif (blueBall.x == spots[9].x and blueBall.y == spots[9].y) or ( blueBall.x == spots[10].x and blueBall.y == spots[10].y ) or (blueBall.x == spots[13].x and blueBall.y == spots[13].y) or ( blueBall.x == spots[14].x and blueBall.y == spots[14].y ) then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[7].x, y = spots[7].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[12].x, y = spots[12].y })
					player = true
				end	
			end
		end
	end
	end
end

-- redBall at spot 9
local function gameLoop9()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[9].x and redBall.y == spots[9].y) then
			if (blueBall.x == spots[13].x and blueBall.y == spots[13].y) then
					transition.to(redBall, {x = spots[13].x, y = spots[13].y })
					player = true
				else transition.to(redBall, {x = spots[10].x, y = spots[10].y })
					player = true
			end
		end
	end
	end
end

-- redBall at spot 10
local function gameLoop10()
	local randomMove = math.random(2)
	if player == false then	
	if isDead == false then
		if (redBall.x == spots[10].x and redBall.y == spots[10].y) then
			if ( blueBall.x <= spots[7].x and blueBall.y <= spots[7].y)
				then
					transition.to(redBall, {x = spots[6].x, y = spots[6].y })
					player = true
			elseif (blueBall.x == spots[9].x and blueBall.y == spots[9].y )
				then transition.to(redBall, {x = spots[9].x, y = spots[9].y })
					player = true
			elseif ( blueBall.x == spots[11].x and blueBall.y == spots[11].y) or ( blueBall.x == spots[12].x and blueBall.y == spots[12].y ) or ( blueBall.x == spots[15].x and blueBall.y == spots[15].y) or ( blueBall.x == spots[16].x and blueBall.y == spots[16].y )
				then transition.to(redBall, {x = spots[11].x, y = spots[11].y })
					player = true
			elseif (blueBall.x == spots[8].x and blueBall.y == spots[8].y)then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[6].x, y = spots[6].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[11].x, y = spots[11].y })
					player = true
				end	
			elseif ( blueBall.x == spots[14].x and blueBall.y == spots[14].y)
				then transition.to(redBall, {x = spots[14].x, y = spots[14].y })	
					player = true
			elseif (blueBall.x == spots[13].x and blueBall.y == spots[13].y)then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[9].x, y = spots[9].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[14].x, y = spots[14].y })
					player = true
				end	
			end
		end
	end
end

-- redBall at spot 11
local function gameLoop11()
	local randomMove = math.random(2)
	if player == false then
		if (redBall.x == spots[11].x and redBall.y == spots[11].y) then
			if (blueBall.x == spots[1].x and blueBall.y == spots[1].y) or (blueBall.x == spots[2].x and blueBall.y == spots[2].y) or (blueBall.x == spots[5].x and blueBall.y == spots[5].y) or (blueBall.x == spots[6].x and blueBall.y == spots[6].y) or (blueBall.x == spots[9].x and blueBall.y == spots[9].y) or (blueBall.x == spots[10].x and blueBall.y == spots[10].y) or (blueBall.x == spots[13].x and blueBall.y == spots[13].y) or (blueBall.x == spots[14].x and blueBall.y == spots[14].y) then
					transition.to(redBall, {x = spots[10].x, y = spots[10].y })
					player = true
			elseif (blueBall.x == spots[8].x and blueBall.y == spots[8].y) or ( blueBall.x == spots[12].x and blueBall.y == spots[12].y ) or (blueBall.x == spots[16].x and blueBall.y == spots[16].y) then
				transition.to(redBall, {x = spots[12].x, y = spots[12].y })
				player = true
			elseif (blueBall.x == spots[3].x and blueBall.y == spots[3].y) or ( blueBall.x == spots[4].x and blueBall.y == spots[4].y ) or (blueBall.x == spots[7].x and blueBall.y == spots[7].y) then
				if randomMove == 1 then
					transition.to(redBall, {x = spots[10].x, y = spots[10].y })
					player = true
				elseif randomMove == 2 then
					transition.to(redBall, {x = spots[12].x, y = spots[12].y })
					player = true
				end	
			elseif ( blueBall.x == spots[15].x and blueBall.y == spots[15].y)
				then transition.to(redBall, {x = spots[15].x, y = spots[15].y })	
					player = true	
			end
		end
	end
	end
end

-- redBall at spot 12
local function gameLoop12()
	if player == false then
	if isDead == false then
		if (redBall.x == spots[12].x and redBall.y == spots[12].y) then
			if ( blueBall.x <= spots[8].x and blueBall.y <= spots[8].y)
				then
					transition.to(redBall, {x = spots[8].x, y = spots[8].y })
					player = true
			elseif (blueBall.x == spots[16].x and blueBall.y == spots[16].y )
				then transition.to(redBall, {x = spots[16].x, y = spots[16].y })
					player = true
			else transition.to(redBall, {x = spots[11].x, y = spots[11].y })
				player = true
			end
		end
	end
	end
end

-- redBall at spot 13
local function gameLoop13()
	local randomMove = math.random(2)
	if player == false then
	if isDead == false then
		if (redBall.x == spots[13].x and redBall.y == spots[13].y) then
			if randomMove == 1 then
				transition.to(redBall, {x = spots[9].x, y = spots[9].y })
				player = true
			elseif randomMove == 2 then
					transition.to(redBall, {x = spots[14].x, y = spots[14].y })
					player = true
			end	
		end
	end
	end
end

-- redBall at spot 14
local function gameLoop14()
	if player == false then	
	if isDead == false then
		if (redBall.x == spots[14].x and redBall.y == spots[14].y) then
			if ( blueBall.x == spots[13].x and blueBall.y == spots[13].y)
				then
					transition.to(redBall, {x = spots[13].x, y = spots[13].y })
					player = true
				else transition.to(redBall, {x = spots[10].x, y = spots[10].y })
					player = true
			end
		end
	end
	end
end

-- redBall at spot 15
local function gameLoop15()
	if player == false then 
	if isDead == false then
		if (redBall.x == spots[15].x and redBall.y == spots[15].y)
			then
				transition.to(redBall, {x = spots[11].x, y = spots[11].y })
				player = true
		end
	end
	end
end	

-- redBall at spot 16
local function gameLoop16()
	if player == false then 
	if isDead == false then
		if (redBall.x == spots[16].x and redBall.y == spots[16].y)
			then
				transition.to(redBall, {x = spots[11].x, y = spots[11].y })
				player = true
		end
	end
	end
end	

-- Game over
local function gameLoop17()
	if (redBall.x == blueBall.x and redBall.y == blueBall.y) then
		isDead = true
		local myText = display.newText( "GAME OVER", display.contentCenterX, 50, native.systemFont, 50 )
	end
end
	
gameLoopTimer = timer.performWithDelay(2000, gameLoop1, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop2, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop3, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop4, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop5, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop6, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop7, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop8, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop9, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop10, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop11, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop12, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop13, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop14, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop15, 0)
gameLoopTimer = timer.performWithDelay(2000, gameLoop16, 0)
gameLoopTimer = timer.performWithDelay(500, gameLoop17, 0)

