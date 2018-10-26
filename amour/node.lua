local Object = require 'classic'
local Node = Object:extend()

function Node:new(x, y, w, h)
    Node.super.new(self)
    self.x = x or 0
    self.y = y or 0
    self.r = 0
    self.w = w or 0
    self.h = h or 0
    self.sx = 1
    self.sy = 1
    self.ax = 0.5
    self.ay = 0.5
    self.visible = true
    self.transform = love.math.newTransform(self.x, self.y, self.r, self.sx, self.sy)
end

function Node:updatePosition(x, y)
    self.x, self.y = x, y
    self:updateTransform()
end

function Node:updateRotation(rotation)
    self.r = rotation
    self:updateTransform()
end

function Node:updateSize(w, h)
    self.w, self.h = w, h
    self:updateTransform(true)
end

function Node:updateScale(sx, sy)
    self.sx, self.sy = sx, sy
    self:updateTransform()
end

function Node:updateAnchor(ax, ay)
    self.ax, self.ay = ax, ay
    self:updateTransform(true)
end

function Node:getLeftTop()
    return -self.w * self.ax, -self.h * self.ay
end

function Node:draw()
    if not self.visible then return end

    love.graphics.push()
    love.graphics.applyTransform(self.transform)

    self:realdraw()

    if self.children ~= nil then
        for i = 1, #self.children do
            self.children[i]:draw()
        end
    end
    love.graphics.pop()
end

function Node:realdraw()
end

function Node:addChild(node)
    if node.parent ~= nil then
        node.parent:removeChild(node)
    end

    self.children = self.children or {}
    table.insert(self.children, node)
    node.parent = self
    node.indexInParent = #self.children

    node:updateTransform(true)
end

function Node:removeChild(node)
    if node.parent ~= self then
        error('Node parent is different')
        return
    end
    
    table.remove(self.children, node.indexInParent)
    for i = index, #self.children do
        self.children[i].indexInParent = i
    end
    
    node.parent = nil
    node.indexInParent = nil
    node:updateTransform()
end

function Node:reorderChild(node, index)
    if node.parent ~= self then
        error('Node parent is different')
        return
    elseif index < 1 or index > #self.children then
        error('Index is out of range')
        return
    elseif index == node.indexInParent then
        return
    end

    table.remove(self.children, node.indexInParent)
    table.insert(self.children, index, node)
    for i = 1, #self.children do
        self.children[i].indexInParent = i
    end
end

function Node:updateTransform(needPropagation)
    local x, y = self.x, self.y
    if self.parent ~= nil then
        local p = self.parent
        x, y = x - p.w * p.ax, y - p.h * p.ay
    end
    self.transform:setTransformation(x, y, self.r, self.sx, self.sy)
    self.finalTransform = nil

    if needPropagation and self.children ~= nil then
        for i = 1, #self.children do
            self.children[i]:updateTransform(true)
        end
    end
end

function Node:containsPoint(gx, gy)
    local finalTransform = self.finalTransform
    if finalTransform == nil then
        local nodes = { self }
        local parent = self.parent
        while parent ~= nil do
            table.insert(nodes, parent)
            parent = parent.parent
        end
        finalTransform = nodes[#nodes].transform:clone()
        for i = #nodes - 1, 1, -1 do
            finalTransform:apply(nodes[i].transform)
        end
        self.finalTransform = finalTransform
    end

    local left, top = finalTransform:transformPoint(-self.w * self.ax, -self.h * self.ay)
    local right, bottom = finalTransform:transformPoint(self.w * (1 - self.ax), self.h * (1 - self.ay))
    return gx >= left and gx <= right and gy >= top and gy <= bottom
end

function Node:checkMousePressed(x, y)
    if self:containsPoint(x, y) then
        if self.onMousePressed then
            self:onMousePressed(x, y)
            return true
        end
    end
    return false
end

function Node:checkMouseReleased(x, y)
    if self.onMouseReleased then
        self:onMouseReleased(x, y)
        return true
    end
    return false
end

function Node:flux(duration, changes, group)
    group = group or require 'flux'
    if changes.w or changes.h then
        return group.to(self, duration, changes):onupdate(function() self:updateTransform(true) end)
    else
        return group.to(self, duration, changes):onupdate(function() self:updateTransform() end)
    end
end

return Node