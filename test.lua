local Level = require "./classes/game/level";
local Player = require "./classes/game/mario";
local Action = require "./classes/game/actions";

local Neural = require "./classes/ai/ai";
local Generation = require "./classes/ai/generation"

local Mario = Player:new();
local Level = Level:new();
local Neural = Neural:new();
local Action = Action:new();
local Generation = Generation:new(12)

local Species = Generation.CreateSpecies();

function Main()
    local actualSpecie = Generation.GetActualSpecie();

    if Mario.isDead or Level.isGone then 
        Generation.score = Level.score;
        
        Generation.NextSpecie()
        savestate.loadslot(1);
        return -1;
    end
    
    local inputs = Mario.GetInputs();
    Neural.inputs = inputs;
    Neural.weights = actualSpecie.genome;

    output = Neural.feedFoward(); -- return output

    Action.Press(output);

    emu.frameadvance()
end

while true do Main() end

