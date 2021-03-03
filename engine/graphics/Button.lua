
Button = {
    image = nil,
    text = nil,
    name = "",
    x = 0,
    y = 0,
    w = 0,
    h = 0,
    isSelected = false
}

Button.__index = Button

function Button:new(path, x, y, name, content)
    local this = setmetatable({}, self)

    this.x = x 
    this.y = y

    if content == nil then
        this.name = name
        this.image = love.graphics.newImage(path)
        this.w = this.image:getWidth()
        this.h = this.image:getHeight()
    else
        this.name = name
        this.image = nil
        if content.size ~= nil then
            this.text = Text:new(content.text, content.size)
        else
            this.text = Text:new(content.text, 12)
        end
        this.w = content.w
        this.h = content.h
    end

    return this
end

function Button:update(dt, camera)

    local bool = self:isIn(love.mouse.getX(), love.mouse.getY(), camera)

    if love.mouse.isDown(1, 1) and bool then 
        return true 
    else
        return false
    end

end

function Button:isIn(x, y, camera)

    x = x * camera.scalex
    y = y * camera.scaley

    if x > self.x and x < self.x + self.w and y > self.y and y < self.y + self.h then 
        self.isSelected = true
        return true 
    else
        self.isSelected = false
        return false 
    end

end

function Button:draw()

    local x = self.x + self.w / 2 - self.text.text:getWidth() / 2
    local y = self.y + self.h / 2 - self.text.text:getHeight() / 2

    if self.image ~= nil then
        love.graphics.draw(self.image, self.x, self.y)
    else
        if self.isSelected then
            love.graphics.setColor(50, 50, 255, 255)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

        self.text:draw(x, y)
    end

    love.graphics.setColor(255, 255, 255, 255)

end