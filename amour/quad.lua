local Node = require 'amour.node'
local Quad = Node:extend()

function Quad:new(x, y, qx, qy, qw, qh, image, color)
    self.image = (type(image) == 'string' and love.graphics.newImage(image)) or image
    self.quad = love.graphics.newQuad(qx, qy, qw, qh, self.image:getDimensions())
    self.color = color or { 1, 1, 1, 1 }
    Quad.super.new(self, x, y, qw, qh)
end

function Quad:realdraw()
    local color = self.color
    local x0, y0 = self:getLeftTop()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.image, self.quad, x0, y0)
end

return Quad