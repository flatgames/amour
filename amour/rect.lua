local Node = require 'amour.node'
local Rect = Node:extend()

function Rect:new(x, y, w, h, color, mode, lineWidth)
    Rect.super.new(self, x, y, w, h)
    self.color = color or { 1, 1, 1, 1 }
    self.mode = mode or 'fill'
    self.lineWidth = lineWidth or 1
end

function Rect:realdraw()
    local color = self.color
    local x0, y0 = self:getLeftTop()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.setLineWidth(self.lineWidth)
    love.graphics.rectangle(self.mode, x0, y0, self.w, self.h)
end

return Rect