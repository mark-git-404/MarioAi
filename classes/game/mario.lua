local Player = {}

function Player:new(o)
    o = o or {};
    setmetatable(o, self)

    self.__index = self;

    -- * Properties
    self.form = memory.readbyte(0x19);      -- Player PowerUP (0 = Mini, 1 = HumanSize, etc )

    self.x = 0;                             -- Player X Position
    self.y = 0;                             -- Player Y Position

    self.layerX = memory.read_s16_le(0x1A); -- ?Camera X Position 
    self.layerY = memory.read_s16_le(0x1C); -- ?Camera Y Position

    -- Remember: Axis on 2nd quadrant ( x = Left ,y = Top )
    self.xScreen = self.x - self.layerX;    -- Player X Position on Screen
    self.yScreen = self.y - self.layerY;    -- Player Y Position on Camera
    
    self.xVel = memory.readbyte(0x7B);      -- Player X Velocity
    self.yVel = memory.readbyte(0x7D);      -- Player Y Velocity

    self.isDead = Player:CheckLife();       -- Player Status

    self.inputs = Player:GetInputs();       -- All Inputs;

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
    
    self.inputs = a;

    return a;

end

function Player:CheckLife()
    local isDead = (memory.readbyte(0x13E0) == 62);
    self.isDead = isDead;

    return self.isDead;
end

function Player:GetPosition()
    local x = memory.read_s16_le(0x94);
    local y = memory.read_s16_le(0x96);

    self.x = x;
    self.y = y;

    return self.x, self.y;
end

function Player:GetLayerPosition()
    local xLayer = memory.read_s16_le(0x1A);
    local yLayer = memory.read_s16_le(0x1C);

    self.xLayer = xLayer;
    self.yLayer = yLayer;

    return self.x, self.y;
end


function Player:Update()
    self:CheckLife();
    self:GetInputs();
    self:GetPosition();
    self:GetLayerPosition();
end


return Player;
