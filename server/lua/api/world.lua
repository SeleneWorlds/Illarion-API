local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

world = {}

world.SeleneMethods = {
    LoS = nyi("LoS"),
    deleteNPC = nyi("deleteNPC"),
    createDynamicNPC = nyi("createDynamicNPC"),
    getPlayersOnline = nyi("getPlayersOnline"),
    getPlayerIdByName = nyi("getPlayerIdByName"),
    getNPCS = nyi("getNPCS"),
    getCharactersInRangeOf = nyi("getCharactersInRangeOf"),
    getPlayersInRangeOf = nyi("getPlayersInRangeOf"),
    getMonstersInRangeOf = nyi("getMonstersInRangeOf"),
    getNPCSInRangeOf = nyi("getNPCSInRangeOf"),
    getArmorStruct = nyi("getArmorStruct"),
    getWeaponStruct = nyi("getWeaponStruct"),
    getNaturalArmor = nyi("getNaturalArmor"),
    getMonsterAttack = nyi("getMonsterAttack"),
    changeQuality = nyi("changeQuality"),
    changeItem = nyi("changeItem"),
    isCharacterOnField = nyi("isCharacterOnField"),
    getCharacterOnField = nyi("getCharacterOnField"),
    getField = nyi("getField"),
    makePersistentAt = nyi("makePersistentAt"),
    removePersistenceAt = nyi("removePersistenceAt"),
    isPersistentAt = nyi("isPersistentAt"),
    getTime = nyi("getTime"),
    erase = nyi("erase"),
    increase = nyi("increase"),
    swap = nyi("swap"),
    createItemFromId = nyi("createItemFromId"),
    createItemFromItem = nyi("createItemFromItem"),
    createMonster = nyi("createMonster"),
    gfx = nyi("gfx"),
    makeSound = nyi("makeSound"),
    getItemStats = nyi("getItemStats"),
    getItemStatsFromId = nyi("getItemStatsFromId"),
    setWeather = nyi("setWeather"),
    isItemOnField = nyi("isItemOnField"),
    getItemOnField = nyi("getItemOnField"),
    changeTile = nyi("changeTile"),
    getItemName = nyi("getItemName"),
    createSavedArea = nyi("createSavedArea"),
    broadcast = nyi("broadcast"),
    sendMonitoringMessage = nyi("sendMonitoringMessage")
}

world.SeleneGetters = {
    weather = nyi("weather")
}

world.SeleneSetters = {
    weather = nyi("weather")
}

world.SeleneMetatable = {
    __index = function(table, key)
        local method = world.SeleneMethods[key]
        if method then
            return method
        end
        local getter = world.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = world.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(world, world.SeleneMetatable)