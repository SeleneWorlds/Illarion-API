local Interface = require("illarion-api.server.lua.interface")

LongTimeEffect = {}

setmetatable(LongTimeEffect, {
    __call = function(self, id, nextCalled)
        return Interface.LTE.Create(id, nextCalled)
    end
})

local LongTimeEffectGetters = {
    effectId = function(effect)
        return tonumber(effect.SeleneEffectDefinition:GetMetadata("id"))
    end,
    effectName = function(effect)
        return effect.SeleneEffectDefinition:GetMetadata("name")
    end,
    nextCalled = function(effect)
        return Interface.LTE.GetNextCalled(effect)
    end,
    numberCalled = function(effect)
        return Interface.LTE.GetNumberCalled(effect)
    end
}

local LongTimeEffectSetters = {
    nextCalled = function(effect, value)
        Interface.LTE.SetNextCalled(effect, value)
    end
}

local LongTimeEffectMethods = {
    addValue = function(effect, key, value)
        Interface.LTE.AddValue(effect, key, value)
    end,
    findValue = function(effect, key)
        return Interface.LTE.FindValue(effect, key)
    end,
    removeValue = function(effect, key)
        Interface.LTE.RemoveValue(effect, key)
    end
}

LongTimeEffectMT = {
    __index = function(table, key)
        local method = LongTimeEffectMethods[key]
        if method then
            return method
        end
        local getter = LongTimeEffectGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = LongTimeEffectSetters[key]
        if setter then
            setter(table, value)
            return
        end
    end
}
