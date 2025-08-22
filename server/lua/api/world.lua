local Sounds = require("selene.sounds")
local Registries = require("selene.registries")
local Dimensions = require("selene.dimensions")
local Players = require("selene.players")
local Entities = require("selene.entities")

world = {}

function world:getTime(timeType)
    local illarionBirthTime = 950742000
    local illarionTimeFactor = 3

    if timeType == "unix" then
        return os.time()
    end

    local curr_unixtime = os.time()
    local timestamp = os.date("*t", curr_unixtime)
    local illaTime = curr_unixtime
    local secondsInHour = 60 * 60

    if timestamp.isdst then
        illaTime = illaTime + secondsInHour
    end

    illaTime = (illaTime - illarionBirthTime) * illarionTimeFactor

    if timeType == "illarion" then
        return illaTime
    end

    local secondsInYear = 60 * 60 * 24 * 365
    local year = math.floor(illaTime / secondsInYear)
    illaTime = illaTime - year * secondsInYear

    local secondsInDay = 60 * 60 * 24
    local day = math.floor(illaTime / secondsInDay)
    illaTime = illaTime - day * secondsInDay
    day = day + 1

    local daysInIllarionMonth = 24
    local daysInLastIllarionMonth = 5
    local monthsInIllarionYear = 16
    local month = math.floor(day / daysInIllarionMonth)
    day = day - month * daysInIllarionMonth

    if day == 0 then
        if month > 0 and month < monthsInIllarionYear then
            day = daysInIllarionMonth
        else
            day = daysInLastIllarionMonth
        end
    else
        month = month + 1
    end

    if month == 0 then
        month = monthsInIllarionYear
        year = year - 1
    end

    if timeType == "year" then
        return year
    elseif timeType == "month" then
        return month
    elseif timeType == "day" then
        return day
    end

    local hour = math.floor(illaTime / secondsInHour)
    illaTime = illaTime - hour * secondsInHour

    local secondsInMinute = 60
    local minute = math.floor(illaTime / secondsInMinute)
    illaTime = illaTime - minute * secondsInMinute

    if timeType == "hour" then
        return hour
    elseif timeType == "minute" then
        return minute
    elseif timeType == "second" then
        return illaTime
    end

    return -1
end

function world:getItemStatsFromId(itemId)
    local itemDef = Registries.FindByMetadata("illarion:items", "id", itemId)
    if itemDef then
        return {
          AgeingSpeed = tonumber(itemDef:GetField("agingSpeed") or 0),
          Brightness = tonumber(itemDef:GetField("brightness") or 0),
          BuyStack = tonumber(itemDef:GetField("buyStack") or 0),
          English = itemDef:GetField("nameEnglish"),
          EnglishDescription = itemDef:GetField("descriptionEnglish"),
          German = itemDef:GetField("nameGerman"),
          GermanDescription = itemDef:GetField("descriptionGerman"),
          id = tonumber(itemDef:GetField("itemId") or 0),
          Level = tonumber(itemDef:GetField("level") or 0),
          MaxStack = tonumber(itemDef:GetField("maxStack") or 0),
          ObjectAfterRot = tonumber(itemDef:GetField("objectAfterRot") or 0),
          Rareness = tonumber(itemDef:GetField("rareness") or 0),
          rotsInInventory = itemDef:GetField("rotsInInventory"),
          Weight = tonumber(itemDef:GetField("weight") or 0),
          Worth = tonumber(itemDef:GetField("worth") or 0)
        }
    end
    return ItemStruct()
end

function world:isItemOnField(position)
    local dimension = Dimensions.GetDefault()
    local tiles = dimension:GetTilesAt(position)
    for _, tile in ipairs(tiles) do
        if tile:HasTag("illarion:item") then
            return true
        end
    end
    local entities = dimension:GetEntitiesAt(position)
    for _, entity in ipairs(entities) do
        if entity:HasTag("illarion:item") then
            return true
        end
    end
    return false
end

function world:getItemOnField(position)
    local dimension = Dimensions.GetDefault()
    local entities = dimension:GetEntitiesAt(position)
    for _, entity in ipairs(entities) do
        if entity:HasTag("illarion:item") then
            return Item.fromSeleneEntity(entity)
        end
    end

    local tiles = dimension:GetTilesAt(position)
    for _, tile in ipairs(tiles) do
        if tile:HasTag("illarion:item") then
            return Item.fromSeleneTile(tile)
        end
    end

    return Item.fromSeleneEmpty()
end

function world:changeItem(item)
    if item.SeleneEntity ~= nil then
        item.SeleneEntity:UpdateVisuals()
    end
end

function world:getPlayersInRangeOf(pos, range)
    local dimension = Dimensions.GetDefault()
    local players = Players.GetOnlinePlayers()
    local result = {}
    for _, player in ipairs(players) do
        local entity = player.ControlledEntity
        if entity.Coordinate:GetHorizontalDistance(pos) <= range then
            table.insert(result, Character.fromSelenePlayer(player))
        end
    end
    return result
end

function world:erase(item, amount)
    local TileDef = Registries.FindByMetadata("tiles", "itemId", item.id)
    if TileDef == nil then
        print("No such tile " .. item.id) -- TODO throw an error
        return
    end

    if item:getType() == scriptItem.field then
        local dimension = Dimensions.GetDefault()
        -- TODO erase from entity items if found
        if dimension:HasTile(tile.Coordinate, TileDef.Name) then
            dimension.Map:RemoveTile(tile.Coordinate, TileDef.Name)
            return true
        end
    elseif item:getType() == scriptItem.inventory or item:getType() == scriptItem.belt then
        local blockedItemId = 228
        if item.itempos == Character.right_tool and (item.owner:GetItemAt(Character.left_tool)).id == blockedItemId then
            item.owner:increaseAtPos(Character.left_tool, -250);
        elseif item.itempos == Character.left_tool and (item.owner:GetItemAt(Character.right_tool)).id == blockedItemId then
            item.owner:increaseAtPos(Character.right_tool, -250);
        end

        item.owner:increaseAtPos(item.itempos, -amount);
        return true
    elseif item:getType() == scriptItem.container then
        item.inside:increaseAtPos(item.itempos, -amount)
    end
end

function world:gfx(id, pos)
    local entityType = Registries.FindByMetadata("entities", "gfxId", id)
    if entityType == nil then
        print("No entity for gfx id " .. id) -- TODO throw an error
        return
    end

    local entity = Entities.CreateTransient(entityType.Name)
    entity:SetCoordinate(pos)
    entity:Spawn()
end

function world:getPlayersOnline()
    local result = {}
    local players = Players.GetOnlinePlayers()
    for _, player in ipairs(players) do
        table.insert(result, Character.fromSelenePlayer(player))
    end
    return result
end

function world:swap(item, newId, newQuality)
    local NewTileDef = Registries.FindByMetadata("tiles", "itemId", newId)
    if NewTileDef == nil then
        print("No such tile " .. newId) -- TODO throw an error
        return
    end

    if item:getType() == scriptItem.field then
        if item.SeleneTile ~= nil then
            local map = item.SeleneTile.Dimension.Map
            map:SwapTile(item.SeleneTile.Coordinate, item.SeleneTile.Name, NewTileDef.Name)
        end
    elseif item:getType() == scriptItem.inventory or item:getType() == scriptItem.belt then
        item.owner:swapAtPos(item.itempos, newId, newQuality)
    elseif item:getType() == scriptItem.container then
        item.inside:swapAtPos(item.itempos, newId, newQuality)
    end
end

function world:makeSound(soundId, pos)
    local sound = Registries.FindByMetadata("sounds", "soundId", soundId)
    if sound ~= nil then
        Sounds.PlaySoundAt(pos.x, pos.y, pos.z, sound.Name)
    end
end

function world:getItemName(ItemId, Language)
    local tile = Registries.FindByMetadata("tiles", "itemId", ItemId)
    if tile then
        if Language == Player.german then
            return tile:GetMetadata("nameGerman")
        elseif Language == Player.english then
            return tile:GetMetadata("nameEnglish")
        else
            return tile:GetMetadata("nameEnglish")
        end
    end

    return "unknown_item_" .. ItemId
end

function world:getField(pos)
    local dimension = Dimensions.GetDefault()
    return Field.fromSelenePosition(dimension, pos)
end

function world:isCharacterOnField(pos)
    local dimension = Dimensions.GetDefault()
    local entities = dimension:GetEntitiesAt(pos)
    for _, entity in ipairs(entities) do
        if entity:HasTag("illarion:player") then
            return true
        end
    end
    return false
end

function world:createItemFromId(itemId, count, pos, always, quality, data)
    print("createItemFromId", itemId, count, pos, always, quality, table.tostring(data))
    return Item.fromSeleneEmpty()
end

function world:getMonstersInRangeOf(pos, range)
    print("getMonstersInRangeOf", pos, range)
    return {}
end