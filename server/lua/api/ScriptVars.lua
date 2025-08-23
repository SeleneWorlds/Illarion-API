ScriptVars = {}

local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

ScriptVars.find = nyi("ScriptVars.find")
ScriptVars.remove = nyi("ScriptVars.remove")
ScriptVars.save = nyi("ScriptVars.save")
ScriptVars.set = nyi("ScriptVars.set")
