local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

SelectionDialog = {}

SelectionDialog.SeleneConstructor = nyi("SelectionDialog.SeleneConstructor")
SelectionDialog.SeleneMethods = {
    addOption = nyi("addOption"),
    setCloseOnMove = nyi("setCloseOnMove"),
    getSuccess = nyi("getSuccess"),
    getSelectedIndex = nyi("getSelectedIndex")
}
SelectionDialog.SeleneGetters = {}
SelectionDialog.SeleneSetters = {}

SelectionDialog.SeleneMetatable = {
    __call = function(self, title, message, callback)
        local o = SelectionDialog.SeleneConstructor(title, message, callback)
        setmetatable(o, self)
        self.__index = self
        return o
    end,
    __index = function(table, key)
        local method = SelectionDialog.SeleneMethods[key]
        if method then
            return method
        end
        local getter = SelectionDialog.SeleneGetters[key]
        if getter then
            return getter(table)
        end

        return rawget(table, key)
    end,
    __newindex = function(table, key, value)
        local setter = SelectionDialog.SeleneSetters[key]
        if setter then
            setter(table, value)
            return
        end

        rawset(table, key, value)
    end
}

setmetatable(SelectionDialog, SelectionDialog.SeleneMetatable)
