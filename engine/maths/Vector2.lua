Vector2 = {
    x = 0,
    y = 0
}

Vector2.__index = Vector2

function Vector2:init(x, y)
    local o = setmetatable({}, self)

    o.x = x
    o.y = y

    return o
end

function Vector2:translate(v)
    self.x = self.x + v.x
    self.y = self.y + v.y
end

function Vector2:add(v)
    return Vector2:init(self.x + v.x, self.y + v.y)
end

function Vector2:scalar(s)
    return Vector2:init(self.x * s, self.y * s)
end

function Vector2:dot(v)
    return self.x * v.x + self.y * v.y
end

function Vector2:distance()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector2:getNormal()
    return Vector2:init(self.y, -self.x)
end

function Vector2:distanceTo(v)
    return math.sqrt((self.x - v.x) * (self.x - v.x) + (self.y - v.y) * (self.y - v.y))
end

function Vector2:getVector(p1, p2)
    return Vector2:init(p2.x - p1.x, p2.y - p1.y)
end

function Vector2:getNormalize()
    local d = self:distance()
    return Vector2:init(self.x / d, self.y / d)
end

function Vector2:toString()
    return "(" .. self.x .. ", " .. self.y .. ")"
end