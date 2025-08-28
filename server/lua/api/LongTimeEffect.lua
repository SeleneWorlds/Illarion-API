LongTimeEffect = {}

setmetatable(LongTimeEffect, {
    __call = function(self, id, nextCalled)
        return LongTimeEffect.SeleneConstructor(id, nextCalled)
    end
})

local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

LongTimeEffect.SeleneGetters = {
    effectId = nyi("effectId"),
    effectName = nyi("effectName"),
    nextCalled = nyi("nextCalled"),
    numberCalled = nyi("numberCalled")
}

LongTimeEffect.SeleneConstructor = nyi("LongTimeEffect.SeleneConstructor")

LongTimeEffect.SeleneSetters = {
    nextCalled = nyi("nextCalled")
}

LongTimeEffect.SeleneMethods = {
    addValue = nyi("addValue"),
    findValue = nyi("findValue"),
    removeValue = nyi("removeValue")
}

LongTimeEffect.SeleneMetatable = {
    __index = function(table, key)
        local method = LongTimeEffect.SeleneMethods[key]
        if method then
            return method
        end
        local getter = LongTimeEffect.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = LongTimeEffect.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}
