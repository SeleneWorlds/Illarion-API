function LongTimeEffect(id, n)
    return {
        effectId = 0,
        effectName = "",
        nextCalled = 0, -- writable
        numberCalled = 0,
        addValue = function(key, value) end,
        findValue = function(key) return false, nil end,
        removeValue = function(key) end
    }
end