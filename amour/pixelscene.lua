local Node = require 'amour.node'
local PixelScene = Node:extend()

function PixelScene:new(designWidth, designHeight)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local biggerScreenDim = math.max(screenWidth, screenHeight)
    local biggerDesignDim = math.max(designWidth, designHeight)
    
    local scale = 1
    while true do
        local size = biggerDesignDim * scale
        if size > biggerScreenDim then
            scale = scale - 1
            break
        else
            scale = scale + 1
        end
    end

    if scale == 0 then scale = 1 end

    local scaledWidth, scaledHeight = designWidth * scale, designHeight * scale
    local dx, dy = screenWidth - scaledWidth, screenHeight - scaledHeight

    local x, y = screenWidth * 0.5, screenHeight * 0.5
    local w, h = designWidth + dx / scale, designHeight + dy / scale
    PixelScene.super.new(self, x, y, w, h)
    self:updateScale(scale, scale)
end

return PixelScene