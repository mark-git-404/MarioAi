local Specie = require "./classes/ai/specie"

local Generation = {}

function Generation:new(o, n )
    o = o or {};
    setmetatable(o, self);

    self.__index = self;        
    
    self.nSpecies = n;          -- Contains the number of Species in Generation
                                -- Equivalent to #species;

    self.species = {};          -- Contains All Species of that Generation
    self.actual = 1;            -- Actual Specie;
    self.actualGeneration = 1;  -- Actual Generation;

    return o;
end

function Generation:CreateSpecies()
    for i = 1, self.nSpecies do
        self.species[i] = Specie:new();
    end

    return self.species;
end


function Generation:GetBestSpecie()
    local p = 1;
    for i = 1, #self.species do
        if self.species[i].Score > self.species[p].score then
            p = i;
        end
    end
    self.bestSpecie = self.species[p]

    return self.bestSpecie;
end

function Generation:NextSpecie()
    self.actual = self.actual + 1;

    return self.species[self.actual];
end

function Generation:GetActualSpecie()
    return self.species[self.actual];
end

function Generation:NextGeneration()
    self.actual = 1;
    self.actualGeneration = self.actualGeneration + 1;

    return self.actualGeneration;
end

return Generation;