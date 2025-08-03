
Rocket = Class {}

function Rocket:init(dna)
    self.pos = Vector.new(love.graphics.getWidth() / 2, love.graphics.getHeight())
    self.vel = Vector.new(0, 0)
    self.acc = Vector.new(0, 0)
    if dna then
        self.dna = dna
    else
        self.dna = DNA(200)
    end
    self.count = 1
    self.fitness = 0
    self.img = love.graphics.newImage('assets/rocket.png')
    self.scaleX = 50 / self.img:getWidth()
    self.scaleY = 50 / self.img:getHeight()
end

function Rocket:applyForce(force)
    self.acc = self.acc + force
end

function Rocket:update(cnt)
    self.count = cnt
    self:applyForce(self.dna.genes[self.count])
    self.vel = self.vel + self.acc      
    self.pos = self.pos + self.vel     
    self.acc = self.acc * 0
end

function Rocket:calculateFitness(target)
    distance = self.pos:dist(target)
    w = love.graphics.getWidth()
    self.fitness = 1 / (distance * distance + 1)
    if distance < 10 then
        self.fitness = self.fitness * 10
    end
end

function Rocket:render()
    love.graphics.push()
    love.graphics.translate(self.pos.x, self.pos.y)
    love.graphics.rotate(math.atan2(self.vel.y, self.vel.x))   
    love.graphics.setColor(1, 1, 1) 
    love.graphics.draw(self.img, 0, 0, 0, self.scaleX, self.scaleY)
    love.graphics.pop()
end

function map(value, in_min, in_max, out_min, out_max)
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end


function dottedLine(x1, y1, x2, y2, size, interval)
    size = size or 5
    interval = interval or 2

    dx = (x1-x2)*(x1-x2)
    dy = (y1-y2)*(y1-y2)
    length = math.sqrt(dx+dy)
    t = size/interval

    for i = 1, math.floor(length/size) do
        if i % interval == 0 then
            love.graphics.line(x1+t*(i-1)*(x2-x1), y1+t*(i-1)*(y2-y1),
                               x1+t*i*(x2-x1), y1*t*i*(y2-y1))
        end
    end
end