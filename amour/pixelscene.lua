local Node = require 'amour.node'
local PixelScene = Node:extend()

function PixelScene:new(designWidth, designHeight)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local sw, sh = screenWidth / designWidth, screenHeight / designHeight
    local scale = math.floor(math.min(sw, sh))
    
    local scaledWidth, scaledHeight = designWidth * scale, designHeight * scale
    local dx, dy = screenWidth - scaledWidth, screenHeight - scaledHeight
    
    local x, y = screenWidth * 0.5, screenHeight * 0.5
    local w, h = designWidth + dx / scale, designHeight + dy / scale
    PixelScene.super.new(self, x, y, w, h)
    self:updateScale(scale, scale)
end

return PixelScene