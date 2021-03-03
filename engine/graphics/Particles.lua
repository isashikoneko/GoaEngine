require("config")

Particles = {
    img = nil,
    body = nil,
    lifetime = 0,
    const_force = nil
}

Particles.__index = Particles

function Particles:init(img, body, lifetime, const_force)
    local o = setmetatable({}, self)

    o.img = img
    o.body = body
    o.lifetime = lifetime
    o.const_force = const_force

    return o 
end

function Particles:update(dt)
    self.body:applyConstantForce(self.const_force)
    self.body:update(dt)
    if self.img ~= nil then
        self.img:synchBody(self.body)
    end

    self.lifetime = self.lifetime - dt
    if self.lifetime < 0 then
        return false 
    else
        return true 
    end
end

function Particles:draw()
    self.body:draw()
    if self.img ~= nil then 
        self.img:draw()
    end
end