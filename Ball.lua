Ball = Class{}

BALL_SPEED = 200
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and -BALL_SPEED or BALL_SPEED
    self.dy = math.random(-50,50)
end

function Ball:reset()
    self.x = WINDOW_WIDTH/2-ball.width/2
	self.y = WINDOW_HEIGHT/2-ball.width/2
	
	self.dx = math.random(2) == 1 and -BALL_SPEED or BALL_SPEED
	self.dy = math.random(-50,50)

    gameState = 'start'
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:collides(paddle)
    if(self.x > paddle.x + paddle.width or paddle.x > self.x + self.width) then
        return false
    end 
    if(self.y > paddle.y + paddle.height or paddle.y > self.y + self.height) then
        return false
    end
    return true
end