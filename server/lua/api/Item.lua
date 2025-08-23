Item = {}

Item.SeleneMethods = {
    getType = function(Item)
        if Item.SeleneTile then
            return scriptItem.field
        end
        return scriptItem.notdefined
    end,
    getData = function(Item, Key)
        return "" -- TODO
    end,
    setData = function(Item, Key, Value)
        -- TODO
    end
}

Item.SeleneGetters = {
    id = function(Item)
        if Item.SeleneTile then
            return tonumber(Item.SeleneTile:GetMetadata("itemId"))
        end
        return 0
    end,
    isLarge = function(Item) return false end, -- TODO what is this?
    pos = function(Item)
        if Item.SeleneTile then
            return {
                x = Item.SeleneTile.X,
                y = Item.SeleneTile.Y,
                z = Item.SeleneTile.Z
            }
        end
        return { x = 0, y = 0, z = 0 }
    end,
    number = function(Item)
        if Item.SeleneTile then
            return 1
        end
        return 0
    end,
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
    end
}
