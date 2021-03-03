require("config")
require(MATHS_ENGINE_PATH .. "Vector2")
require(PHYSICS_ENGINE_PATH .. "CircleBody")
require(PHYSICS_ENGINE_PATH .. "PolygonBody")
require(GRAPHICS_ENGINE_PATH .. "Particles")

ParticleSystem = {
    img = nil,
    body = nil,
    nb_max = 0,
    current_nb = 0,
    particles = {},
    lifetime = {},
    state = PARTICLESYSTEM_STOPPED,
    force = {}
}

ParticleSystem.__index = ParticleSystem

function ParticleSystem:init(img, body, nb)
    local o = setmetatable({}, self)

    local const_force = 10

    o.particles = {}
    o.img = img
    o.body = body 
    o.nb_max = nb
    o.current_nb = 0
    o.lifetime = {min = 2, max = 5}
    o.state = PARTICLESYSTEM_STOPPED
    o.force = {min = Vector2:init(-const_force, -const_force), max = Vector2:init(const_force, const_force)}

    return o 
end

function ParticleSystem:emit()
    self.state = PARTICLESYSTEM_RUNNING
end

function ParticleSystem:stop()
    self.state = PARTICLESYSTEM_STOPPED
end

function ParticleSystem:translate(v)
    self.body:translate(v.x, v.y)
end

function ParticleSystem:setParticleLifeTime(min, max)
    self.lifetime.min = min 
    self.lifetime.max = max
end

function ParticleSystem:setLinearForce(min_x, min_y, max_x, max_y)
    self.force = {min = Vector2:init(min_x, min_y), max = Vector2:init(max_x, max_y)}
end

function ParticleSystem:update(dt)

    if self.state == PARTICLESYSTEM_RUNNING then 
        if self.current_nb < self.nb_max then 
            local lifetime = math.random(self.lifetime.min, self.lifetime.max)
            local force = Vector2:init(math.random(self.force.min.x, self.force.max.x), math.random(self.force.min.y, self.force.max.y))
            local body = self.body

            if body.center == nil then 
                table.insert( self.particles, Particles:init(self.img, PolygonBody:init(body.pos.x, body.pox.y, body.vertex, body.mass), lifetime, force))
            else
                table.insert( self.particles, Particles:init(self.img, CircleBody:init(Vector2:init(body.center.x, body.center.y), body.radius, body.mass), lifetime, force))
            end
            self.current_nb  = self.current_nb + 1
        end

        for i,v in ipairs(self.particles) do
            --print(i .. " particle : " .. v.body.center:toString())
            if not self.particles[i]:update(dt) then
                table.remove( self.particles, i)
                self.current_nb = self.current_nb - 1
            end
        end
        print(#self.particles)
    end

end

function ParticleSystem:draw()
    for i,v in ipairs(self.particles) do
        self.particles[i]:draw()
    end
end