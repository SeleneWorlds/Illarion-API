local Sounds = require("selene.sounds")
local Registries = require("selene.registries")

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

function world:getItemStatsFromId(foodId)
    return {
        Level = 0
    }
end

function world:isItemOnField(position)
   return false
end

function world:getItemOnField(position)
    return {
        id = 0,
        wear = 0,
        number = 0
    }
end

function world:changeItem(item)
end

function world:getPlayersInRangeOf(pos, range)
    return {}
end

function world:erase(item, amount)
end

function world:gfx(id, pos)
end

function world:getPlayersOnline()
    return {}
end

function world:swap(item, newId, newQuality)
    local NewTileDef = Registries.FindByMetadata("tiles", "id", tostring(newId))
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
        -- TODO swapAtPos
    elseif item:getType() == scriptItem.container then
        -- TODO swapAtPos
    end
end

function world:makeSound(soundId, pos)
    local sound = Registries.FindByMetadata("illarion:sounds", "id", tostring(soundId))
    if sound ~= nil then
        Sounds.PlaySoundAt(pos.x, pos.y, pos.z, sound.Name)
    end
end