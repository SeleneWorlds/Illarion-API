ItemLookAt = {
    commonItem = 1,
    uncommonItem = 2,
    rareItem = 3,
    epicItem = 4
}

setmetatable(ItemLookAt, {
    __call = function()
        return {
            name = "",
            rareness = ItemLookAt.commonItem,
            description = "",
            craftedBy = "",
            type = "",
            level = 0,
            usable = true,
            weight = 0,
            worth = 0,
            qualityText = "",
            durabilityText = "",
            durabilityValue = 0,
            diamondLevel = 0,
            emeraldLevel = 0,
            rubyLevel = 0,
            sapphireLevel = 0,
            amethystLevel = 0,
            obsidianLevel = 0,
            topazLevel = 0,
            bonus = 0
        }
    end
})
