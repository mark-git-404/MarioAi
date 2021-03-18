local Specie = {}

function Specie:new(o)
    local o = o or {}
    setmetatable(o, self);

    self.__index = self;

    self.score = 0;

    self.genome = {}

end

function Specie:SetScore(score)
    self.score = score;
end


return Specie;
