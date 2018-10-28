# amour

[![LOVE](https://img.shields.io/badge/L%C3%96VE-11.1-EA316E.svg)](http://love2d.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## What is this?

Basic scene graph library for [LÖVE](https://love2d.org/) game engine.

Please read the [wiki page](https://github.com/flatgames/amour/wiki) for more details on usage.

## Installation

Just copy `amour` into the root folder of your game.

## Dependencies

* [classic](https://github.com/rxi/classic/) for OOP functionalities
* [flux](https://github.com/rxi/flux) (optional) for tweening functionalities

## Limitations

* No support for z-index: child nodes added later will be drawn later.
* Although transform properties like `x`, `y`, `r`, etc. can be read directly, they must be set via `updateXXX()` functions or the transforms won't be updated.
* Usage of `flux` on transform properties must be done via `node:flux()` instead of `flux.to(node, ...)` to make sure node transform is updated.

## Examples

```lua
local Scene = require 'amour.scene'
local Rect = require 'amour.rect'
local Text = require 'amour.text'

local scene

function love.load()
    scene = Scene(480, 320)

    local bg = Rect(scene.w * 0.5, scene.h * 0.5, scene.w, scene.h, { 0.2, 0.2, 0.2, 1 })
    scene:addChild(bg)

    local title = Text(scene.w * 0.5, 10, 14, "Je t'aime!", { 1, 0, 0, 1})
    title:updateAnchor(0.5, 0)
    scene:addChild(title)
end

function love.draw()
    scene:draw()
end
```