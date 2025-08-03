Population = Class {}

function Population:init(popSize)
    self.rockets = {}
    self.mattingPool = {}
    self.bestFit = 0
    self.totalFitness = 0

    for i = 1, popSize do
        rocket = Rocket()
        table.insert(self.rockets, rocket)
    end

end

function Population:run(cnt)
    for i, rocket in ipairs(self.rockets) do
        rocket:update(cnt)
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
            self.bestFit = maxFit
        end
    end

    local totalFitness = 0
    for _, rocket in ipairs(self.rockets) do
        totalFitness = totalFitness + rocket.fitness
    end


    self.mattingPool = {}
    for i, rocket in ipairs(self.rockets) do
        n = math.floor(rocket.fitness * 100)
        for i = 1, n do
            table.insert(self.mattingPool, rocket)
        end
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