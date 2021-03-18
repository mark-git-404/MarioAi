local matrix = require "matrix";
local luigi = require "luigi";

-- Utils
local Utils = {}
function Utils.tableConcat(array1, array2)
    for i = 1, #array2 do array1[#array1 + 1] = array2[i]; end
end
-- Mario
local Mario = {
    xPos = 0,
    yPos = 0,
    xScreenPos = 0,
    yScreenPos = 0,
    xVel = 0,
    yVel = 0
}

function Mario.isDead()
    -- read mario animation state, if 62 its the dead mario frame and we're dead
    return (memory.readbyte(0x13E0) == 62)
end

function Mario.getPlayerStatus()
    local marioPowerUp = memory.readbyte(0x19);
    local xVel = memory.readbyte(0x7B);
    local yVel = memory.readbyte(0x7D);

    local mtx = {marioPowerUp, xVel, yVel};
    return mtx;
end

function Mario.getPositions()
    marioX = memory.read_s16_le(0x94)
    marioY = memory.read_s16_le(0x96)

    layer1x = memory.read_s16_le(0x1A);
    layer1y = memory.read_s16_le(0x1C);

    layer2x = memory.read_s16_le(0x1E);
    layer2y = memory.read_s16_le(0x20)

    screenX = marioX - layer1x
    screenY = marioY - layer1y

    local mtxPositions = {marioX, marioY, layer1x, layer1y, screenX, screenY};

    return mtxPositions;
end

function Mario.getSpritesPositions()
    local sprites = {};
    for s = 0, 11 do -- 12 bytes 
        local status = memory.readbyte(0x14C8 + s);

        spriteXPos = 0;
        spriteYPos = 0;

        if status ~= 0 then
            local xPosLow = memory.readbyte(0xE4 + s);
            local xPosHigh = memory.readbyte(0x14E0 + s);

            local yPosLow = memory.readbyte(0xD8 + s);
            local yPosHigh = memory.readbyte(0x14D4 + s);

            spriteXPos = xPosLow + xPosHigh * 256;
            spriteYPos = (yPosLow + yPosHigh * 256) - 16;

        else
            spriteXPos = marioX;
            spriteYPos = marioY;
        end

        sprites[#sprites + 1] = status; -- 1 4 7
        sprites[#sprites + 2] = spriteXPos - marioX; -- 2 5 8
        sprites[#sprites + 3] = marioY - spriteYPos; -- 3 6 9
    end

    return sprites;

end


-- Level
-- Neural Network
local NeuralNet = {};

function NeuralNet.newWeight(inputMtx, hiddenLayerSize)

    local matrixR, matrixC = matrix.size(inputMtx); -- Row And Collumns;

    local weightMTX = matrix:new(matrixC, hiddenLayerSize);

    matrix.random(weightMTX);

    return weightMTX;
end

function NeuralNet.feedFoward(inputs, weights)
    local weightMTX = matrix:new()

    local matrix = matrix.random();

    return output;
end

function NeuralNet.sigmoid(x)
    return 2 / (1 + math.exp(-4.9 * x)) - 1 -- TODO: porque ta nesse formado???? Checar
end

-- Pattern
local Pattern = {
    InputNeurons = 0,
    HiddenLayerCount = 0,
    HiddenLayerNeurons = 0,
    OutputNeurons = 0
};

function Pattern.init(inputNeurons, hiddenLayerCount, hiddenLayerNeurons, outputNeurons)
    Pattern.InputNeurons = inputNeurons;
    Pattern.HiddenLayerCount = hiddenLayerCount;
    Pattern.HiddenLayerNeurons = hiddenLayerNeurons;
    Pattern.OutputNeurons = outputNeurons;
end

-- Specie
local Specie = {
    -- index = 1 and index = #Weights (last) are I/O weights
    HiddenLayers = {}
};

function Specie.init(Pattern)

    local specie = {
        Pattern,
        Score,
        Weights = {} 
    }

    specie.Pattern = Pattern;
    specie.Score = 0;

    for i = 1, specie.Pattern.hiddenLayerCount + 1 do
       specie.Weights[i] = WeightNeuralNet.newWeight(inputNeurons, specie.Pattern.HiddenLayerNeurons);
    end

    return specie;
end
-- Genomes
local Generation = {
    Count,
    Species = {}
};

function Generation.init(SpeciesCount)
    Count = SpeciesCount;

    return Generation;
end

function Generation.AddSpecie(Specie)
    -- return Genome.Species

    Generation.Species[#Gnome.Species + 1] = Specie;

    return Gnome.Species;
end

function Generation.CreateRandomSpecies(Count)
    -- reset all the species
    -- then
    -- return Genome.Species

    Generation.Species = {};

    for i = 1, Count do
        Generation.Species[i] = Specie.init();
    end
    

end



--[[  -----------------  MAIN FUNCTION  -------------------------
    => Routine:
        - Create a new Random Genome with X species

        - Check if Mario is Dead or the Game still running
            -> if not 
]]--

function Main()

    local M = luigi:new();
    M:getPos(1);
    console.log(M.positions[1])

    local numberOfSpecies = 12;
    local genome;

    if Mario.isDead() or Level.isGone() then
        genome = Generation.init(numberOfSpecies);

        savestate.loadslot(1) -- load new save    

        Level.ResetScore()

        return;
    end

    local inputs = Mario.getInputs();
    local inputsMatrix = matrix:new({inputs});

    local weightMatrix = NeuralNet.newWeight(inputsMatrix, 100);

    local FhiddenLayer = matrix.mul(inputsMatrix, weightMatrix);

    --matrix.print(FhiddenLayer);

    for i = 1, #inputs do
        gui.text(1600, 10 + (17 * (i - 1)), inputsMatrix[1][i]);
    end
    Graphics.drawText();

    Level.setScore();

    emu.frameadvance()
end

while true do Main(); end
