
require(PHYSICS_ENGINE_PATH .. "Collision")

EventField = {
    body = nil,
    collision = nil
}

EventField.__index = EventField

function EventField:init(body)
    local o = setmetatable({}, self)

    o.body = body
    o.collision = Collision:init()

    return o
end

function EventField:enterEvent(body)
    local collide = false
    if body.radius == nil then 
        collide = self.collision:PolygonToPolygon(body, self.body)
    else
        collide = self.collision:circleToPolygon(body, self.body)
    end
    return collide
end

function EventField:draw()
    love.graphics.setColor(0, 255, 0, 255)

    self.body:draw()

    love.graphics.setColor(255, 255, 255, 255)
end