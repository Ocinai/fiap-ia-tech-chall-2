Class = require 'libs.class'
Vector = require 'libs.vector'

require 'Rocket'
require 'Population'
require 'DNA'

count = 0

function love.load()

    math.randomseed(os.time())

    rocket = Rocket()
    pop = Population(50)
    target = Vector.new(love.graphics.getWidth() / 2, 50)
    gen = 1
end

function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.circle('fill', target.x, target.y, 18, 18)
    count = count + 1
    pop:run(count)

    if count == 200 then
        count = 0
        pop:evaluate(target)
        pop:selection()
        gen = gen + 1
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.print("Gen: " .. tostring(gen))
   -- love.graphics.print("Best Fit: " .. tostring(pop.bestFit), 0, 20)

end
