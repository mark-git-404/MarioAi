local Action = {}

function Action:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self;

    self.inputs = {}
    self.buttons = joypad.get();
    return o;
end

function Action:Press()
    return nil;
end


return Action;