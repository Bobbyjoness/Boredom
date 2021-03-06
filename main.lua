local sti = require "libs.STI"
local bump = require "libs.bump"
local cols,player,GRAVITY,map,world
local debug = " "
function love.load()


	-- Set Physics Meter
	world = bump.newWorld(64)
	-- Load map
	map = sti.new("maps/test1.lua", { "bump" })
	
	map:bump_init(world)

	player = {
	x = 400,
	y = 300,
	w = 32,
	h = 32,
	xvel = 0,
	yvel = 0,
	speed = 100,
	maxVelocityX = 200,
	maxVelocityY = 64,
	direction    = 1,
	grounded = false


	}

	GRAVITY = 9.8
	world:add(player, player.x, player.y, player.w, player.h)

end

function love.update(dt)
	map:update(dt)
	if love.keyboard.isDown( "d" ) then
		player.xvel = player.xvel + player.speed
		player.direction = 1
		if player.direction == -1 then
			player.xvel = 0
		end
	elseif love.keyboard.isDown("a") then
		player.xvel = player.xvel + player.speed
		player.direction = -1
		if player.direction == 1 then
			player.xvel = 0
		end
	end

	player.xvel = player.xvel - 50
	
	player.yvel = player.yvel + GRAVITY

	if player.xvel > player.maxVelocityX then player.xvel = player.maxVelocityX end

	if player.xvel < 0 then player.xvel = 0 end

	player.x = player.x + player.direction*player.xvel*dt

	player.y = player.y + (player.yvel)*dt

	player.x, player.y, cols = world:move( player, player.x, player.y )

	for i,v in ipairs (cols) do
		if cols[i].normal.y == -1 then
			player.yvel = 0
			player.grounded = true
			debug = debug.."Collided "
		elseif cols[i].normal.y == 1 then
			player.yvel = -player.yvel/4
		end
		if cols[i].normal.x ~= 0 then
			player.xvel = 0
		end
	end

end

function love.draw()
	
	love.graphics.setColor( 255,255,255,255 )
	map:setDrawRange(0, 0, 800, 600)
	map:draw()
	love.graphics.rectangle( "fill",player.x,player.y,player.w,player.h )
	love.graphics.setColor(255, 255, 0, 255)
	map:bump_draw(world)
	love.graphics.print(player.yvel..debug..tostring(player.grounded))
	love.graphics.print(player.x,0,12)
	love.graphics.print(player.y,0,24)
	debug = " "

end

function love.mousepressed( x,y,button )
	if button == 'l' and player.grounded then
		player.yvel = player.yvel - 200 --this is your jump juice
		player.grounded = false
		debug = debug.." Jumped "
	end
end
function love.resize(w, h)
	map:resize(w, h)
end
