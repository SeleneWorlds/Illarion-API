local Interface = require("illarion-api.server.lua.interface")

function log(message)
    Interface.Logger.Log(message)
end

setmetatable(debug, {
    __call = function(_, message)
        Interface.Logger.LogDebug(message)
    end
})