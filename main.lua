Class = require 'libs.class'
Vector = require 'libs.vector'

require 'Rocket'
require 'Population'
require 'DNA'

count = 0

function love.load()
    math.randomseed(os.time())

    background = love.graphics.newImage('assets/background-space.png')
    moon = love.graphics.newImage('assets/moon.png')
    love.window.setTitle('Moon Crasher')

    scaleX = 100 / moon:getWidth()
    scaleY = 100 / moon:getHeight()

    love.window.setMode(background:getWidth(), background:getHeight())
    target = Vector.new(love.graphics.getWidth() / 2, 50)
    gen = 1
    pop = Population(50)
    delta = 0
end

function love.update(dt)
    delta = dt
    pop:update(target)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.draw(background, 0, 0)
    love.graphics.setColor(1, 1, 1, 1)
    count = count + 1
    pop:run(count, delta)
    love.graphics.draw(moon, target.x - 36, target.y - 36, 0, scaleX, scaleY)

    if count == 200 then
        count = 0
        pop:evaluate(target)
        pop:selection()
        gen = gen + 1
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.print("Gen: " .. tostring(gen))
    love.graphics.print("Best Fit: " .. string.format("%.4f", pop.totalFitness), 0, 20)
end
