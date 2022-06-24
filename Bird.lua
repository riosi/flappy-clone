Bird = Class{}


-- the less the gravity is the slower the bird will fall
local GRAVITY = 20

-- initializes the class
function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- where are we putting the bird (middle of the screen)
    -- divide the width by 2 and shift it to the left 
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Bird:update(dt)
    -- apply gravity to velocity
    self.dy = self.y + GRAVITY * dt

    -- if space was pressed it adds -5 to velocity, going up on Y position
    if love.keyboard.wasPressed('space') then
        self.dy = -5
    end

    -- apply current velocity to Y position
    self.y = self.y + self.dy

end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end