
Rocket = Class {}

function Rocket:init(dna)
    self.pos = Vector.new(love.graphics.getWidth() / 2, love.graphics.getHeight())
    self.vel = Vector.new(0, 0)
    self.acc = Vector.new(0, 0)
    self.count = 1
    self.fitness = 0
    self.img = love.graphics.newImage('assets/rocket.png')
    self.scaleX = 50 / self.img:getWidth()
    self.scaleY = 50 / self.img:getHeight()
    self.w = self.img:getWidth()
    self.h = self.img:getHeight()
    self.completed = false
    self.trail = {}
    if dna then
        self.dna = dna
    else
        self.dna = DNA(200)
    end
    self.audio = love.audio.newSource('assets/boom.wav', 'static')
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

    table.insert(self.trail, self.pos:clone())
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
    self:renderTrail()  
    love.graphics.push()
    love.graphics.translate(self.pos.x, self.pos.y)
    love.graphics.rotate(math.atan2(self.vel.y, self.vel.x)) 
    love.graphics.setColor(1, 1, 1) 
    love.graphics.draw(self.img, 0, 0, 0, self.scaleX, self.scaleY, self.w / 2, self.h / 2)
    love.graphics.pop()
end

function map(value, in_min, in_max, out_min, out_max)
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end


function dottedLine(x1, y1, x2, y2, dashLength, gap)
    dashLength = dashLength or 5
    gap = gap or 3

    local dx, dy = x2 - x1, y2 - y1
    local distance = math.sqrt(dx * dx + dy * dy)
    local angle = math.atan2(dy, dx)

    local currentLength = 0
    while currentLength < distance do
        local startX = x1 + math.cos(angle) * currentLength
        local startY = y1 + math.sin(angle) * currentLength
        local endX = x1 + math.cos(angle) * math.min(currentLength + dashLength, distance)
        local endY = y1 + math.sin(angle) * math.min(currentLength + dashLength, distance)

        love.graphics.line(startX, startY, endX, endY)

        currentLength = currentLength + dashLength + gap
    end
end

function Rocket:renderTrail()
    love.graphics.setColor(1, 1, 1, 0.3)
    for i = 1, #self.trail - 1 do
        local p1 = self.trail[i]
        local p2 = self.trail[i + 1]
        dottedLine(p1.x, p1.y, p2.x, p2.y, 4, 6)
    end
end