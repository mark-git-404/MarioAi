local Network = {}
local matrix = require "./libs/matrix";

function Network:new(o, pattern, inputs, weights)
    local o = o or {}
    setmetatable(o, self);
    self.__index = self;
    --[[
    Parametros:

        Pattern >  {i, h, n, o}
            i = Número de Neurônios no Input da Rede
            h = Número de Neurônios na HiddenLayer da Rede
            n = Número de Camadas de HiddenLayer da Rede
            o = Número de Neurônios no Output da Rede
        
        Inputs  > Matrix  1 x i
            e.g = matrix:new( 1 x i )

        Weights > Table of Matrix
            e.g = { matrix[1], matrix[2], matrix[3], ... , matrix[( n + 1 )] }


    ]]--                        I  ---- W ---- H1 -- W -- H2 -- W -- H(n)-- W -- O                
    local _i = pattern[1]; --   []             []         []         []          []
    local _h = pattern[2]; --   []	           []         []         []          []
    local _n = pattern[3]; --   []             []         []         []          []
    local _o = pattern[4]; --   []             []         []         []          []
--                            i x 1 | i x h | h x 1 |w| h x 1 |w|  h x 1  |w| o x 1   
--                                   (  w  )            

    self.inputs = inputs or matrix:new( 1 , _i);     -- Matrix 1 x I  
    self.weights = weights or _createWeights(_i, _h, _n); -- Matrix i X h 

    self.data = {}
    
    return o;

end

function Network:feedFoward()
    local input = self.inputs;
    local weights = self.weights;

    

    return nil;
end

function Network:backPropagation()

end

function Network:sigmoid(x)
    return 1/(1+ math.exp(2.7, (x * -1)))
end

-- Utils Functions;
function _nHiddenLayers(pattern)
    return (#pattern - 2); 
end
function _createWeights(i,h, n)
    local weights = {};

    for i = 1, n do 
        weights[i] = matrix:new(i, h);
    end

    return weights; 
end


return Network;
