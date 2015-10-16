local sti = require "libs.STI"
local bump = require "libs.bump"

function love.load()


	-- Set Physics Meter
	world = bump.newWorld(64)
	-- Load map
	map = sti.new("maps/test1.lua", { "bump" })
	
	map:bump_init(world)

	--[[player = {

}--]]
	--world:add()

end

function love.update(dt)
	map:update(dt)
end

function love.draw()
	
	love.graphics.setColor( 255,255,255,255 )
	map:setDrawRange(0, 0, 800, 600)
	map:draw()

	love.graphics.setColor(255, 255, 0, 255)
	map:bump_draw(world,collidables)

end

function love.resize(w, h)
	map:resize(w, h)
end
