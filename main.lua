WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

PADDLE_SPEED = 200;
--request Library, help on creation of clases/objects
Class = require 'class'

require 'Ball'
require 'Paddle'

function love.load()
	love.window.setTitle("Pong")
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	player1Score = 0
	player2Score = 0

	BALL_SIZE = 14
	ball = Ball(WINDOW_WIDTH/2-BALL_SIZE/2, WINDOW_HEIGHT/2-BALL_SIZE/2, BALL_SIZE, BALL_SIZE)
	paddle1 = Paddle(20, 50, 15, 50)
	paddle2 = Paddle(WINDOW_WIDTH-40, WINDOW_HEIGHT-100, 15, 50)

	gameState = 'start'
end

function love.update(dt)
	-- player 1 movement
	if(love.keyboard.isDown("w")) then	
		paddle1.dy = -PADDLE_SPEED
	elseif(love.keyboard.isDown("s")) then
		paddle1.dy = PADDLE_SPEED
	else
		paddle1.dy = 0
	end
	--player 2 movement
	if(love.keyboard.isDown("up")) then	
		paddle2.dy = -PADDLE_SPEED
	elseif(love.keyboard.isDown("down")) then
		paddle2.dy = PADDLE_SPEED
	else
		paddle2.dy = 0
	end
	paddle1:update(dt)
	paddle2:update(dt)
	if(gameState == 'play') then
		ball:update(dt)
		if ball:collides(paddle1) then
			ball.dx = -ball.dx * 1.05
			ball.x = paddle1.x + paddle1.width
			if(ball.dy < 0 )then
				ball.dy = -math.random(10,150)
			else
				ball.dy = math.random(10,150)
			end 
		end
		if ball:collides(paddle2) then
			ball.dx = -ball.dx * 1.05
			ball.x = paddle2.x - ball.width
			if(ball.dy < 0 )then
				ball.dy = -math.random(10,150)
			else
				ball.dy = math.random(10,150)
			end 
		end
		if(ball.y <= 0)then
			ball.y = 0
			ball.dy = -ball.dy
		end
		if(ball.y >= WINDOW_HEIGHT - ball.width) then
			ball.y = WINDOW_HEIGHT - ball.width
			ball.dy = -ball.dy
		end
		if(ball.x < 0)then
			player2Score = player2Score +1
			ball:reset()
		end
		if(ball.x > WINDOW_WIDTH - ball.width)then
			player1Score = player1Score +1
			ball:reset()
		end
	end
end

function love.keypressed(key)
	if(key == 'escape') then
		love.event.quit();
	elseif(key == 'enter' or key=='return') then
		if(gameState == 'start') then
			gameState = 'play'
		else
			ball:reset()
		end
	end
end

function love.draw()
	--love.graphics.clear(40, 45, 52, 255)
    love.graphics.printf(
		"Hello "..gameState.." State",
		0,
		20,
		WINDOW_WIDTH,
		'center'
	)
	--score
	love.graphics.print(tostring(player1Score), WINDOW_WIDTH/2 -50, WINDOW_HEIGHT/2-30)
	love.graphics.print(tostring(player2Score), WINDOW_WIDTH/2 +50, WINDOW_HEIGHT/2-30)
	--first paddle
	paddle1:render()
	--second paddle
	paddle2:render()
	-- ball
	ball:render()

	displayFPS()
	displaySpeed()
end

function displayFPS()
	love.graphics.setColor(0 , 255, 0, 255)
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()),10,10)
end

function displaySpeed()
	love.graphics.setColor(0 , 255, 0, 255)
	love.graphics.print("Speed: "..tostring(math.floor(ball.dx)),60,10)
end