local Interface = require("illarion-api.server.lua.interface")

function log(message)
    Interface.Logger.Log(message)
end

function debug(message)
    Interface.Logger.LogDebug(message)
end

function error(message)
    Interface.Logger.LogError(message)
end
