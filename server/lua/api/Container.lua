function SeleneContainer()
    return {
        getSlotCount = function() return 0 end,
        viewItemNr = function(itempos) return false, nil, nil end,
        takeItemNr = function(itempos, count) return false, nil end,
        changeQualityAt = function(itempos, amount) end,
        insertContainer = function(item, container, itempos) return false end,
        insertItem = function(item, merge) end,
        countItem = function(itemid, data) return 0 end,
        eraseItem = function(itemid, count, data) return 0 end,
        increaseAtPos = function(itempos, value) end,
        swapAtPos = function(itempos, newId, newQuality) return false end,
        weight = function() return 0 end
    }
end