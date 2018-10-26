local Node = require 'amour.node'
local Wrapper = Node:extend()

function Wrapper:new(x, y, w, h, target, renderer)
    Wrapper.super.new(self, x, y, w, h)
    self.target = target
    self.renderer = renderer
end

function Wrapper:realdraw()
    if self.renderer ~= nil then
        local x0, y0 = self:getLeftTop()
        self.renderer(self.target, x0, y0)
    end
end

return Wrapper