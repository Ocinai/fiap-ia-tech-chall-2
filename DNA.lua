--[[
    Author: Inacio Ribeiro - RM362328
    FIAP - IA para devs
    Algoritimos Geneticos
]]--


DNA = Class {}

function DNA:init(genes)
    if dna then
        self.genes = genes
    else
        self.genes = {}
        for i = 1, 200 do
            table.insert(self.genes, Vector.randomDirection(.25))
        end
    end
end

function DNA:crossover(partner)
    genes = {}
    cutoff = math.random(1, #self.genes)
    for i = 1, #self.genes do
        if i < cutoff then
            table.insert(genes, self.genes[i])
        else
            table.insert(genes, partner.genes[i])
        end
    end
    return DNA(genes)
end

function DNA:mutate()
    local mutationRate = 0.5
    for i = 1, #self.genes do
        if math.random() < mutationRate then
            self.genes[i] = Vector.randomDirection(0.25)
        end
    end
end
