local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

MessageDialog = {}

MessageDialog.SeleneConstructor = nyi("MessageDialog.SeleneConstructor")
MessageDialog.SeleneMethods = {}
MessageDialog.SeleneGetters = {}
MessageDialog.SeleneSetters = {}

MessageDialog.SeleneMetatable = {
    __call = function(self, title, message, callback)
        local o = MessageDialog.SeleneConstructor(title, message, callback)
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    __index = function(table, key)
        local method = MessageDialog.SeleneMethods[key]
        if method then
            return method
        end
        local getter = MessageDialog.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = MessageDialog.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(MessageDialog, MessageDialog.SeleneMetatable)
