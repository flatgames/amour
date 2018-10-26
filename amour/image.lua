local Node = require 'amour.node'
local Image = Node:extend()

function Image:new(x, y, image, color)
    self.image = (type(image) == 'string' and love.graphics.newImage(image)) or image
    self.color = color or { 1, 1, 1, 1 }
    Image.super.new(self, x, y, self.image:getDimensions())
end

function Image:realdraw()
    local color = self.color
    local x0, y0 = self:getLeftTop()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.image, x0, y0)
end

return Image