local Genome = {}

function Genome:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self;

    return o;
end


-- Weights 
function Genome:CreateRandom()
    local genome = {};

    local gene;
    for i =1, n do
        gene = ;
    end



    
    return genome;
end
