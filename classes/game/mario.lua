local Player = {}

function Player:new(o)
    o = o or {};
    setmetatable(o, self)

    self.__index = self;

    -- * Properties
    self.form = memory.readbyte(0x19);

    self.y = memory.read_s16_le(0x96);
    self.x = memory.read_s16_le(0x94);

    self.layerX = memory.read_s16_le(0x1A);
    self.layerY = memory.read_s16_le(0x1C);

    self.xScreen = self.x - self.layerX;
    self.yScreen = self.y - self.layerY;

    self.xVel = memory.readbyte(0x7B);
    self.yVel = memory.readbyte(0x7D);

    self.isDead = (memory.readbyte(0x13E0) == 62);

    return o;
end

function Player:GetInputs()

    local a = {}

    local i = 1;
    for k, v in pairs(Player) do
        if type(v) ~= "function" and type(v) ~= "table" then
            i = i + 1;
            a[i] = k;
        end
    end
    
    return a;

end

return Player;
