local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

Field = {}
Field.SeleneGetters = {}
Field.SeleneSetters = {}

Field.SeleneMethods = {
    tile = nyi("tile"),
    getStackItem = nyi("getStackItem"),
    countItems = nyi("countItems"),
    isPassable = nyi("isPassable"),
    isWarp = nyi("isWarp"),
    setWarp = nyi("setWarp"),
    removeWarp = nyi("removeWarp"),
    getContainer = nyi("getContainer")
}

Field.SeleneMetatable = {
    __index = function(table, key)
        local method = Field.SeleneMethods[key]
        if method then
            return method
        end
        local getter = Field.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = Field.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end
    end
}
