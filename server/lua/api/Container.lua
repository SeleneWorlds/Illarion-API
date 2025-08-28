local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

Container = {}

setmetatable(Container, {
    __call = function(self, id)
        return Container.SeleneConstructor(id)
    end
})

Container.SeleneConstructor = nyi("Container.SeleneConstructor")
Container.SeleneGetters = {}
Container.SeleneSetters = {}
Container.SeleneMethods = {
    getSlotCount = nyi("getSlotCount"),
    takeItemNr = nyi("takeItemNr"),
    viewItemNr = nyi("viewItemNr"),
    changeQualityAt = nyi("changeQualityAt"),
    insertContainer = nyi("insertContainer"),
    insertItem = nyi("insertItem"),
    countItem = nyi("countItem"),
    eraseItem = nyi("eraseItem"),
    increaseAtPos = nyi("increaseAtPos"),
    swapAtPos = nyi("swapAtPos"),
    weight = nyi("weight")
}

Container.SeleneMetatable = {
    __index = function(table, key)
        local method = Container.SeleneMethods[key]
        if method then
            return method
        end
        local getter = Container.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = Container.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}
