require("engine.config")
require(PHYSICS_ENGINE_PATH .. "CircleBody")
require(MATHS_ENGINE_PATH .. "Vector2")
require(PHYSICS_ENGINE_PATH .. "PolygonBody")
require(PHYSICS_ENGINE_PATH .. "Collision")

World = {
    constant_force = nil,
    collision = nil,
    gameObject = {}
}

World.__index = World

DYNAMIC_BODY = 0
STATIC_BODY = 1
WHITE_ZONE = 2

function World:init(fx, fy)
    local o = setmetatable({}, self)

    o.collision = Collision:init()
    o.constant_force = Vector2:init(fx, fy)

    return o
end

function World:addObject(name, body, type)
    self.gameObject[name] = {}
    self.gameObject[name]['body'] = body
    self.gameObject[name]['type'] = type
end

function World:updateObject(name, body, type)
    self.gameObject[name] = {}
    self.gameObject[name]['body'] = body
    self.gameObject[name]['type'] = type
end

function World:setType(name, type)
    self.gameObject[name]['type'] = type
end

function World:applyForce()

    -- Apply constant force on dynamic object

    for k,v in pairs(self.gameObject) do
        if v['type'] == DYNAMIC_BODY then
            self.gameObject[k]['body']:applyForce(self.constant_force)
            if self.gameObject[k]['body'].appliedForce.y > GRAVITY_MAX then
                self.gameObject[k]['body'].appliedForce.y = GRAVITY_MAX
            end
        end
    end

end

function World:update(time)

    --physics body update

    for k,v in pairs(self.gameObject) do
        if v.type == DYNAMIC_BODY then
            self.gameObject[k].body:update(time)
        end
    end

    --collision management

    for k,v in pairs(self.gameObject) do

        if v['type'] == DYNAMIC_BODY then

            for j,val in pairs(self.gameObject) do
                if k ~= j then

                    --print("Dynamic " .. k .. " collide with " .. val['type'] .. " " .. j)

                    if v['body'].radius == nil then

                        if val.body.radius == nil then

                            local collide, p_vector, p_distance = self.collision:polygonToPolygon(v.body, val.body)
                            --print("World: collision detection between " .. k .. " and " .. j .. " = ")
                            --print(collide)

                            if collide then

                                --print("World: (" .. p_vector.x .. ", " .. p_vector.y .. ") soit " .. p_vector:distance() .. " and distance = " .. p_distance)

                                self.gameObject[k]['body'].velocity = Vector2:init(0, 0)

                                self.gameObject[k]['body']:translate(p_vector.x * p_distance, p_vector.y * p_distance)
                        
                            end

                        end

                    else

                        local collide, p_vector, p_distance = self.collision:circleToPolygon(v.body, val.body)

                        if collide then

                            --print("(" .. p_vector.x .. ", " .. p_vector.y .. ") soit " .. p_vector:distance() .. " and distance = " .. p_distance)

                            self.gameObject[k]['body'].velocity = Vector2:init(0, 0)

                            self.gameObject[k]['body']:translate(p_vector.x * p_distance, p_vector.y * p_distance)
                    
                        end

                    end

                end
            end

        end
        
    end

end

function World:draw()

    for k,v in pairs(self.gameObject) do
        v['body']:draw()
    end

end
