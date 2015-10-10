--- Simple and fast Tiled map loader and renderer.
-- @module sti
-- @author Landon Manning
-- @copyright 2015
-- @license MIT/X11

local STI = {
	_LICENSE     = "MIT/X11",
	_URL         = "https://github.com/karai17/Simple-Tiled-Implementation",
	_VERSION     = "0.14.1.3",
	_DESCRIPTION = "Simple Tiled Implementation is a Tiled Map Editor library designed for the *awesome* LÖVE framework."
}

local path = (...):gsub('%.init$', '') .. "."
local Map  = require(path .. "map")

--- Instance a new map.
-- @param path Path to the map file.
-- @param plugins A list of plugins to load.
-- @return table The loaded Map.
function STI.new(map, plugins)
	-- Check for valid map type
	local ext = map:sub(-4, -1)
	assert(ext == ".lua", string.format(
		"Invalid file type: %s. File must be of type: lua.",
		ext
	))

	-- Get path to map
	local path = map:reverse():find("[/\\]") or ""
	if path ~= "" then
		path = map:sub(1, 1 + (#map - path))
	end

	-- Load map
	map = love.filesystem.load(map)
	setfenv(map, {})
	map = setmetatable(map(), {__index = Map})

	map:init(path, plugins)

	return map
end

return STI
