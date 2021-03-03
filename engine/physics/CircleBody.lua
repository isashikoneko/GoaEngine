require(MATHS_ENGINE_PATH .. "Vector2")

CircleBody = {
    center = nil,
    radius = 0,
    mass = 0,
    velocity = nil,
    acceleration = nil,
    appliedForce = nil
}

CircleBody.__index = CircleBody

function CircleBody:init(center, r, mass)
    local o = setmetatable({}, self)

    o.center = center
    o.radius = r 
    o.mass = mass
    o.velocity = Vector2:init(0, 0)
    o.acceleration = Vector2:init(0, 0)
    o.appliedForce = Vector2:init(0, 0)

    return o
end

function CircleBody:update(dt)

    self.acceleration = self.appliedForce:scalar(1 / self.mass)

    self.velocity.x = self.acceleration.x * dt
    self.velocity.y = self.acceleration.y * dt

    --print("Player velocity = " .. self.velocity:toString() .. " and dt = " .. dt)

    self:translate((1 / 2) * (self.acceleration.x * dt * dt), (1 / 2) * (self.acceleration.y * dt * dt))

end

function CircleBody:applyForce(f)

    self.appliedForce = self.appliedForce:add(f)

end

function CircleBody:applyConstantForce(f)
    self.appliedForce = f
end

function CircleBody:translate(vx, vy)
    self.center:translate(Vector2:init(vx, vy))
end

function CircleBody:draw()
    love.graphics.circle("line", self.center.x, self.center.y, self.radius)
end