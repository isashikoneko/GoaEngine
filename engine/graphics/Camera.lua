
require(MATHS_ENGINE_PATH .. "Vector2")

Camera = {
    layers = {},
}

Camera.__index = Camera

function Camera:init()
    local o = setmetatable({}, self)

    o.layers = {}

    return o 
end

function Camera:addLayer(name, offsetx, offsety, positionx, positiony, limitx, limity, zoomx, zoomy)
    self.layers[name] = {
        offset = Vector2:init(offsetx, offsety),
        limit = Vector2:init(limitx, limity),
        position = Vector2:init(positionx, positiony),
        zoom = Vector2:init(zoomx, zoomy),
        rotation = 0
    }
end

function Camera:move(name, x, y)
    self.layers[name].position.x = self.layers[name].position.x + x 
    self.layers[name].position.y = self.layers[name].position.y + y
end

function Camera:scale(name, x, y)

    if x ~= 0 and y ~= 0 then 
        self.layers[name].zoom.x = self.layers[name].zoom.x * x 
        self.layers[name].zoom.y = self.layers[name].zoom.y * y
    end

end

function Camera:rotate(name, r)
    self.layers[name].rotation = self.layers[name].rotation + r
end

function Camera:set(name)
    love.graphics.push()

    love.graphics.rotate(self.layers[name].rotation)
    love.graphics.scale(self.layers[name].zoom.x, self.layers[name].zoom.y)
    love.graphics.translate(-self.layers[name].position.x, -self.layers[name].position.y)
    
end

function Camera:unset()
    love.graphics.pop()
end
