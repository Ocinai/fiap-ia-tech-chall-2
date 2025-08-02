
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
    love.graphics.setColor(1, 1, 1, 150/255)
    love.graphics.rectangle('fill', 0, 0, 25, 5)
    love.graphics.pop()
end

function map(value, in_min, in_max, out_min, out_max)
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
