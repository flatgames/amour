local Node = require 'amour.node'
local Text = Node:extend()

function Text:new(x, y, font, textString, color)
    self.textString = textString
    self.color = color or { 1, 1, 1, 1 }
    self.font = (type(font) == 'table' and font) or love.graphics.newFont(font)
    self.text = love.graphics.newText(self.font, self.textString)
    Text.super.new(self, x, y, self.text:getWidth(), self.text:getHeight())
end

function Text:getString()
    return self.textString
end

function Text:setString(textString, wrapLimit, alignMode)
    self.textString = textString
    if wrapLimit ~= nil and alignMode ~= nil then
        self.text:setf(textString, wrapLimit, alignMode)
    else
        self.text:set(textString)
    end
    self:updateSize(self.text:getDimensions())
end

function Text:realdraw()
    local color = self.color
    local x0, y0 = self:getLeftTop()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.text, x0, y0)
end

return Text