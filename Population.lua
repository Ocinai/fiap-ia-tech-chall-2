Population = Class {}

function Population:init(popSize)
    self.rockets = {}
    self.mattingPool = {}
    self.bestFit = 0
    self.totalFitness = 0
    self.rocketCrashed = 0

    for i = 1, popSize do
        rocket = Rocket()
        table.insert(self.rockets, rocket)
    end

end

function Population:run(cnt, dt)
    for i, rocket in ipairs(self.rockets) do
        rocket:update(cnt, dt)
        rocket:render()
    end
end

function Population:evaluate()

    maxFit = 0
    totalFit = 0

    for i, rocket in ipairs(self.rockets) do
        rocket:calculateFitness(target)
        totalFit = totalFit + rocket.fitness
        if rocket.fitness > maxFit then
            maxFit = rocket.fitness
        end
    end

    self.totalFitness = 0
    for _, rocket in ipairs(self.rockets) do
        self.totalFitness = self.totalFitness + rocket.fitness
    end

end

function Population:selection()
    local newRockets = {}

    local bestRocket = nil
    local bestFitness = -math.huge
    for _, rocket in ipairs(self.rockets) do
        if rocket.fitness > bestFitness then
            bestFitness = rocket.fitness
            bestRocket = rocket
        end
    end
    table.insert(newRockets, Rocket(bestRocket.dna))

    for i = 2, #self.rockets do
        local parent1 = self:selectParent()
        local parent2 = self:selectParent()
        local childDNA = parent1:crossover(parent2)
        childDNA:mutate()
        table.insert(newRockets, Rocket(childDNA))
    end

    self.rockets = newRockets
end

function Population:selectParent()
    local r = math.random() * self.totalFitness
    local index = 1

    while r > 0 and index <= #self.rockets do
        r = r - self.rockets[index].fitness
        index = index + 1
    end

    return self.rockets[math.max(index - 1, 1)].dna
end

function Population:update(target)
    for i, rocket in ipairs (self.rockets) do
        d = rocket.pos:dist(target)
        if d < 60 and not rocket.completed then
            rocket.completed = true
            self.rocketCrashed = self.rocketCrashed + 1
            rocket.audio:play()
            rocket.pos = target:clone()
            rocket.vel = rocket.vel * 0
        end
    end
end