Population = Class {}

function Population:init(popSize)
    self.rockets = {}
    self.mattingPool = {}
    self.bestFit = 0

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
        end
    end

    for i, rocket in ipairs(self.rockets) do
        rocket.fitness = rocket.fitness / maxFit
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
    newRockets = {}
    idx = 1
    for i, rocket in ipairs(self.rockets) do
        if #self.mattingPool > 0 then
            idx = math.random(1, #self.mattingPool)
            parent1 = self.mattingPool[idx].dna
            idx = math.random(1, #self.mattingPool)
            parent2 = self.mattingPool[idx].dna
            gene = parent1:crossover(parent2)
            
            table.insert(newRockets, Rocket(c))
        end
    
    end
    self.rockets = newRockets
    if #self.rockets == #newRockets then
        print("Opaaa  ")
    end
end