local Action = {}

function Action:new(o);
    o = o or {}
    setmetatable(o, self)
    self.__index = self;

    self.inputs = {}

    return o;
end

function Action:Press()

end


return Action;