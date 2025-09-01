local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

CraftingDialog = {}
CraftingDialog.playerAborts = 0
CraftingDialog.playerCrafts = 1
CraftingDialog.playerLooksAtItem = 2
CraftingDialog.playerLooksAtIngredient = 3
CraftingDialog.playerCraftingComplete = 4
CraftingDialog.playerCraftingAborted = 5

CraftingDialog.SeleneConstructor = nyi("CraftingDialog.SeleneConstructor")
CraftingDialog.SeleneMethods = {
    clearGroupsAndProducts = nyi("clearGroupsAndProducts"),
    addGroup = nyi("addGroup"),
    addCraftable = nyi("addCraftable"),
    addCraftableIngredient = nyi("addCraftableIngredient"),
    getResult = nyi("getResult"),
    getCraftableId = nyi("getCraftableId"),
    getCraftableAmount = nyi("getCraftableAmount"),
    getIngredientIndex = nyi("getIngredientIndex")
}

CraftingDialog.SeleneGetters = {}
CraftingDialog.SeleneSetters = {}

CraftingDialog.SeleneMetatable = {
    __call = function(self, title, sfx, sfxDuration, callback)
        local o = CraftingDialog.SeleneConstructor(title, sfx, sfxDuration, callback)
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    __index = function(table, key)
        local method = CraftingDialog.SeleneMethods[key]
        if method then
            return method
        end
        local getter = CraftingDialog.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = CraftingDialog.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(CraftingDialog, CraftingDialog.SeleneMetatable)
