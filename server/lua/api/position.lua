local position_mt = {
    __index = {
        equals = function (self, other)
            return self.x == other.x and self.y == other.y and self.z == other.z
        end,
        tostring = function (self)
            return string.format("(%d, %d, %d)", self.x, self.y, self.z)
        end
    }
}

function position(x, y, z)
    return setmetatable({x = x, y = y, z = z}, position_mt)
end
