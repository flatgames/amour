local Node = require 'amour.node'
local Scene = Node:extend()

function Scene:new(designWidth, designHeight, sizeMode)
    local screenWidth, screenHeight = love.graphics.getWidth(), love.graphics.getHeight()
    local x, y = screenWidth * 0.5, screenHeight * 0.5
    local w, h = designWidth or screenWidth, designHeight or screenHeight
    local sw, sh = screenWidth / w, screenHeight / h
    local scaleFactor = 1
    sizeMode = sizeMode or 'expand'
    if sizeMode == 'expand' then
        scaleFactor = math.min(sw, sh)
        if sw >= sh then
            w = h * screenWidth / screenHeight
        else
            h = w * screenHeight / screenWidth
        end
    elseif sizeMode == 'cut' then
        scaleFactor = math.max(sw, sh)
        if sw >= sh then
            h = w * screenHeight / screenWidth
        else
            w = h * screenWidth / screenHeight
        end
    elseif sizeMode == 'width' then
        scaleFactor = sw
        h = w * screenHeight / screenWidth
    elseif sizeMode == 'height' then
        scaleFactor = sh
        w = h * screenWidth / screenHeight
    end
    Scene.super.new(self, x, y, w, h)
    self:updateScale(scaleFactor, scaleFactor)
end

return Scene