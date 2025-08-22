Field = {}

function Field.fromSelenePosition(Dimension, Position)
    return {
        tile = function() return 0 end,
        countItems = function() return 0 end,
        getStackItem = function(stackPosition) return Item.fromSeleneEmpty() end,
        isPassable = function() return false end,
        isWarp = function() return false, nil end,
        setWarp = function(destination) end,
        removeWarp = function() end
    }
end
