local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

MerchantDialog = {}

MerchantDialog.SeleneMethods = {
    addOffer = nyi("addOffer"),
    addPrimaryRequest = nyi("getData"),
    addSecondaryRequest = nyi("addSecondaryRequest"),
    getResult = nyi("getResult"),
    getPurchaseIndex = nyi("getPurchaseIndex"),
    getPurchaseAmount = nyi("getPurchaseAmount"),
    getSaleItem = nyi("getSaleItem"),
    getLookAtList = nyi("getLookAtList")
}

MerchantDialog.SeleneGetters = {}
MerchantDialog.SeleneSetters = {}

MerchantDialog.SeleneMetatable = {
    __call = function(self, title, callback)
        local o = {
            title = title,
            callback = callback
        }
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    __index = function(table, key)
        local method = MerchantDialog.SeleneMethods[key]
        if method then
            return method
        end
        local getter = MerchantDialog.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = MerchantDialog.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(MerchantDialog, MerchantDialog.SeleneMetatable)
