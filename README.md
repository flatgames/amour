## What is this?

Basic scene graph for [LÖVE](https://love2d.org/) game engine.

## Usage

Just copy `amour` into the root folder of your game.

## Required libraries

- [classic](https://github.com/rxi/classic/) for OOP functionalities
- [flux](https://github.com/rxi/flux) (optional) for tweening functionalities

## Limitations

- No support for z-index: child nodes added later will be drawn later.
- Although transform properties like `x`, `y`, `r`, etc. can be read directly, they must be set via `updateXXX()` functions or the transforms won't be updated.
- Usage of `flux` on transform properties must be done via `node:flux()` instead of `flux.to(node, ...)` to make sure node transform is updated.

## Examples

```lua
local Scene = require 'amour.scene'
local Text = require 'amour.text'

local scene

function love.load()
    scene = Scene(480, 320)

    -- creates a grey background
    local bg = Rect(scene.w * 0.5, scene.h * 0.5,
        scene.w, scene.h, { 0.5, 0.5, 0.5, 1 })
    scene:addChild(bg)

    -- creates a title on the upper part of the screen
    local title = Text(scene.w * 0.5, 10,
        12, 'A LoveNode example', { 0, 0, 0, 1 })
    title:updateAnchor(0.5, 0)
    scene:addChild(title)
end

function love.draw()
    scene:draw()
end
```