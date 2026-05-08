local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

MenuStruct = {}

MenuStruct.SeleneConstructor = nyi("MenuStruct.SeleneConstructor")
MenuStruct.SeleneMethods = {
    addItem = nyi("addItem")
}

MenuStruct.SeleneGetters = {}
MenuStruct.SeleneSetters = {}

MenuStruct.SeleneMetatable = {
    __call = function(self, title, callback)
        local o = MenuStruct.SeleneConstructor(title, callback)
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    __index = function(table, key)
        local method = MenuStruct.SeleneMethods[key]
        if method then
            return method
        end
        local getter = MenuStruct.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = MenuStruct.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(MenuStruct, MenuStruct.SeleneMetatable)
