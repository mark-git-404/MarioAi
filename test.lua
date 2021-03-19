local Level = require "./classes/game/level";
local Player = require "./classes/game/mario";
local Action = require "./classes/game/actions";

local Neural = require "./classes/ai/ai";
local Generation = require "./classes/ai/generation"

function Start()
    -- Player
    Mario = Player:new();

    -- Level
    Level = Level:new({}, Mario);

    -- Generation
    number_of_species = 12; -- Número de Especies por Geração;
    Generation = Generation:new({}, number_of_species)
    
    -- All Species
    Species = Generation:CreateSpecies();
    
    -- Actions 
    Action = Action:new();
    buttons = joypad.get();
    
    -- Neural Network
    pattern = {1, 3, 3, #buttons}
    Neural = Neural:new({}, pattern);

    -- Other
    tick = 1;
    time_stuck_avoid = 300 * 60;
end

function Thick()

    local actualSpecie = Generation:GetActualSpecie();

    --[[
    console.log(#buttons);

    for k, v in pairs(buttons) do
        console.log(k .. " -- " .. tostring(v));
    end
]] --
    Mario:Update();

    Level:Update();

    gui.text(30, 100, "Generation     :" .. Generation.actualGeneration);
    gui.text(30, 117, "Especie        :" .. Generation.actual);
    gui.text(30, 134, "Score          :" .. Level.score);

    -- console.log(tick);
    if Mario.isDead or Level.isGone or tick == time_stuck_avoid then

        Generation.score = Level.score;

        if Generation.actual < number_of_species then
            Generation:NextSpecie()
        else
            local bestSpecie = Generation:GetBestSpecie();
            Generation:NextGeneration();
        end

        Level:ResetScore();

        savestate.loadslot(1);
        tick = 1;
        return -1;
    end

    local inputs = Mario:GetInputs();
    -- Neural.inputs = inputs;
    -- Neural.weights = actualSpecie;

    -- output = Neural:feedFoward(); -- return output
    Action.Press(output);

    tick = tick + 1;
    emu.frameadvance()
end

function Routine()
    Start()

    while true do 
        Thick()
    end
end

Routine();

