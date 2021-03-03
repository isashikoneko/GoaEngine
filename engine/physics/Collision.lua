require(MATHS_ENGINE_PATH .. "Vector2")

Collision = {

}

Collision.__index = Collision

function Collision:init()
    local o = setmetatable({}, self)

    return o 
end

local function getAxis(pos, vertex)

    local axis = {}

    for i = 1, #vertex do

        local p1 = vertex[i]
        local p2 = vertex[i + 1] or vertex[1]

        p1 = p1:add(pos)
        p2 = p2:add(pos)

        local edge = Vector2:getVector(p1, p2)

        --print(edge:getString())

        local normal = edge:getNormal()

        normal = normal:getNormalize()

        axis[#axis + 1] = normal

    end

    --print()

    return axis

end

local function project(pos, vertex, axis)
    -- body
    local min = axis:dot(vertex[1]:add(pos))
    local max = min 

    for i = 1, #vertex do

        local proj = axis:dot(vertex[i]:add(pos))

        if proj < min then min = proj end
        if proj > max then max = proj end

    end

    return min, max

end

function Collision:SAT(poly1, poly2)
    
    --print("polygone 1")
    local axis = getAxis(poly1.pos, poly1.vertex)
    --print("polygone 2")
    local axis2 = getAxis(poly2.pos, poly2.vertex)

    local overlap = 9999999999
    local min_axis_penetration = nil
    
    for i = 1, #axis2 do
        axis[#axis + 1] = axis2[i]
    end

    for i = 1, #axis do

        local axis = axis[i]
        local min1, max1 = project(poly1.pos, poly1.vertex, axis)
        local min2, max2 = project(poly2.pos, poly2.vertex, axis)

        --print("polygone 1 : " .. min1 .. ", " .. max1)
        --print("polygone 2 : " .. min2 .. ", " .. max2)

        if max2 < min1 or max1 < min2 then 
            return nil 
        end

        local o = math.min( max1, max2 ) - math.max( min1, min2 )

        if overlap > o then
            overlap = o 
            min_axis_penetration = axis
        end

    end

    --print("min axis penetration = " .. min_axis_penetration:getString() .. " and overlap = " .. overlap)

    return min_axis_penetration, overlap
    
end

function Collision:polygonToPolygon(p1, p2)
    local vector, scale = self:SAT(p1, p2)

    if vector == nil then
        return false, Vector2:init(0, 0), 0
    end

    return true, vector, scale
end

function Collision:circleToPolygon(circle, polygon)

    local collide = false
    local penetration_vector = Vector2:init(0, 0)
    local penetration_distance = 0

    for i=1, #polygon.vertex do

        local k = i + 1
        
        if i == #polygon.vertex then
            k = 1
        end

        local a = polygon.vertex[i]:add(polygon.pos)
        local b = polygon.vertex[k]:add(polygon.pos)
        local o = circle.center

        local ab = Vector2:getVector(a, b)
        local ba = Vector2:getVector(b, a)
        local ao = Vector2:getVector(a, o)
        local bo = Vector2:getVector(b, o)

        local d_ao = ao:distance()
        local d_bo = bo:distance()
        local d_ab = ab:distance()
        local ah = ab:dot(ao) / d_ab
        local bh = ba:dot(bo) / d_ab
        local d_ah = math.abs(ah)
        local d_bh = math.abs(bh)
        local v = ab:getNormalize()
        
        local oh = math.sqrt(ao:distance() * ao:distance() - d_ah * d_ah)

        --[[ print("Distance AH = " .. d_ah .. " < AB + radius soit " .. d_ab + circle.radius)
        print("Distance BH = " .. d_bh .. " < AB + radius soit " .. d_ab + circle.radius)
        print("Distance AB = " .. d_ab)
        print("OH = " .. oh .. " < radius soit " .. circle.radius)
        print("A coordonnee " .. a:toString())
        print("B coordonnee " .. b:toString()) ]]
        
        --[[ print("H coordonnee " .. h:toString())
        print("O coordonnee " .. circle.center:toString()) ]]


        if d_ah < d_ab and d_bh < d_ab then

            if oh < circle.radius then
                penetration_distance = circle.radius - oh
                local h = Vector2:init(
                    a.x + (ah) * v.x, 
                    a.y + (ah) * v.y
                )
                penetration_vector = Vector2:getVector(h, o)
                penetration_vector = penetration_vector:getNormalize()
                return true, penetration_vector, penetration_distance
            end

        elseif d_ah > d_ab and d_ah < d_ab + circle.radius and d_bh > d_ab and d_bh < d_ab + circle.radius then

            if d_ao < center.radius then
                penetration_distance = circle.radius - d_ao
                penetration_vector = Vector2:getVector(a, o)
                penetration_vector = penetration_vector:getNormalize()
                return true, penetration_vector, penetration_distance
            elseif d_bo < center.radius then
                penetration_distance = circle.radius - bh
                penetration_vector = Vector2:getVector(b, o)
                penetration_vector = penetration_vector:getNormalize()
                return true, penetration_vector, penetration_distance
            end

        end

    end

    return false, Vector2:init(0, 0), 0
end
