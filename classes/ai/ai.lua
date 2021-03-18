local Network = {}

-- Pattern = {I, HL1, HL1, O} // Number of Neurons;

function Network:new(o, pattern, inputs, weights)
    local o = o or {}

    setmetatable(o, self);
    self.__index = self;

    self.inputs = inputs or {}; -- always 1 row

    self.hiddenLayer = {{}} or {weights};

    return o;

end
-- self.inputs = inputs;

function Network:feedFoward()
    local input = self.inputs;
    local output;

    

    return output;
end

function Network:backPropagation()

end

function Network:sigmoid(x)
    return 1/(1+ math.exp(2.7, (x * -1)))
end

return Network;
