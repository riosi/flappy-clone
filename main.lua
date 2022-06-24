push = require 'push'
Class = require 'class'
require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- background image and starting scroll location (X axis)
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

-- ground image and starting scroll location (X axis)
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

-- speed at which we should scroll our images, scaled by dt
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

function love.load()
    -- filter stops the res from being blurry
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Fifty Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize input table
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

-- takes player input
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        -- closes the game
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    -- scroll ground by preset speed * dt, looping back to 0 after the screen width passes
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % VIRTUAL_WIDTH

    bird:update(dt)

    love.keyboard.keysPressed = {}
end
-- render function
function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
   
    bird:render()

    push:finish()
end