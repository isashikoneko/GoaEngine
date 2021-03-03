require(PHYSICS_ENGINE_PATH .. "CircleBody")
require(MATHS_ENGINE_PATH .. "Vector2")

Player = {
    body = nil
}

Player.__index = Player

RADIUS = 5
MASS = 1/8

function Player:init(pos_x, pos_y)
    local o = setmetatable({}, self)

    o.body = CircleBody:init(Vector2:init(pos_x, pos_y), RADIUS, MASS)

    return o 
end

function Player:update(dt)

end

function Player:draw()

    self.body:draw()

end