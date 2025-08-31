local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

InputDialog = {}

InputDialog.SeleneMethods = {
    getInput = nyi("getInput"),
    getSuccess = nyi("getSuccess")
}
InputDialog.SeleneGetters = {}
InputDialog.SeleneSetters = {}

InputDialog.SeleneMetatable = {
    __call = function(self, title, description, multiline, maxChars, callback)
        local o = {
            title = title,
            description = description,
            multiline = multiline,
            maxChars = maxChars,
            callback = callback
        }
        setmetatable(o, self)
        self.__index = self
    end,
    __index = function(table, key)
        local method = InputDialog.SeleneMethods[key]
        if method then
            return method
        end
        local getter = InputDialog.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = InputDialog.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(InputDialog, InputDialog.SeleneMetatable)
