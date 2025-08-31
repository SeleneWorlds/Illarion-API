local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

Item = {}

Item.SeleneMethods = {
    getType = nyi("getType"),
    getData = nyi("getData"),
    setData = nyi("setData")
}

Item.SeleneGetters = {
    id = nyi("id"),
    isLarge = nyi("isLarge"),
    owner = nyi("owner"),
    pos = nyi("pos"),
    itempos = nyi("itempos"),
    inside = nyi("inside"),
    number = nyi("number")
}

Item.SeleneSetters = {}

Item.SeleneMetatable = {
    __index = function(table, key)
        local method = Item.SeleneMethods[key]
        if method then
            return method
        end
        local getter = Item.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = Item.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}
