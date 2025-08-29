position = {}

setmetatable(position, {
    __call = function (self, x, y, z)
        return setmetatable({x = x, y = y, z = z}, position.SeleneMetatable)
    end
})

position.SeleneMetatable = {
    __index = function(self, key)
        local coordinate = rawget(self, "SeleneCoordinate")
        if coordinate then
            return coordinate[key]
        end
        return rawget(self, key)
    end,
    __eq = function (self, other)
        return self.x == other.x and self.y == other.y and self.z == other.z
    end,
    __tostring = function (self)
        return string.format("(%d, %d, %d)", self.x, self.y, self.z)
    end
}

function position.FromSeleneCoordinate(coordinate)
    return setmetatable({SeleneCoordinate = coordinate}, position.SeleneMetatable)
end