local Registries = require("selene.registries")

Item = {}

local allTiles = Registries.FindAll("tiles")
for _, Tile in ipairs(allTiles) do
    if string.startsWith(Tile.Name, "illarion:item_") then
        local name = Tile:GetMetadata("name")
        local id = Tile:GetMetadata("id")
        if name and id then
            Item[name] = tonumber(id)
        end
    end
end

scriptItem = {
    notdefined = 0,
    field = 3,
    inventory = 4,
    belt = 5,
    container = 6
}

local ItemMethods = {
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

local ItemGetters = {
    id = function(Item)
        if Item.SeleneTile then
            return tonumber(Item.SeleneTile:GetMetadata("id"))
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

local ItemSetters = {}

local ItemMT = {
    __index = function(table, key)
        local method = ItemMethods[key]
        if method then
            return method
        end
        local getter = ItemGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = ItemSetters[key]
        if setter then
            setter(table, value)
            return
        end
    end
}

function Item.fromSeleneTile(Tile)
    return setmetatable({SeleneTile = Tile}, ItemMT)
end

function Item.fromSeleneEmpty()
    return setmetatable({SeleneTile = nil}, ItemMT)
end