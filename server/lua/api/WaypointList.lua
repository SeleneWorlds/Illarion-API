WaypointList = {}

local function nyi(name)
    return function() error(name .. " not yet implemented") end
end

WaypointList.SeleneMethods = {
    addFromList = nyi("addFromList"),
    addWaypoint = nyi("addWaypoint"),
    getWaypoints = nyi("getWaypoints"),
    clear = nyi("clear")
}

WaypointList.SeleneMetatable = {
    __index = function(table, key)
        local method = WaypointList.SeleneMethods[key]
        if method then
            return method
        end

        return rawget(table, key)
    end
}
