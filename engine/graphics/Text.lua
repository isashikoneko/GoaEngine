require("engine_config")

Text = {
    text = nil,
    font = nil,
    --size = 1,
    font_name = ""
}

Text.__index = Text

function Text:new(text, size)
    local this = setmetatable({}, self)

    --this.size = size
    this.font_name = DEFAULT_FONT
    this.font = love.graphics.newFont(this.font_name, size)
    this.text = love.graphics.newText(this.font, text)

    return this
end

function Text:newWithFont(text, font_name, size)
    local this = setmetatable({}, self)

    --this.size = size
    this.font_name = font_name
    this.font = love.graphics.newFont(this.font_name, size)
    this.text = love.graphics.newText(this.font, text)

    return this
end

function Text:resize(size)
    self.font = love.graphics.newFont(self.font_name, size)
    self.text:setFont(self.font)
end

function Text:setText(text)
    self.text:set(text)
end

function Text:getLength()
    return self.text:getWidth()
end

function Text:draw(x, y)

    love.graphics.draw(self.text, x, y)

end