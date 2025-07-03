local colour_mt = {
    __index = {
        equals = function (self, other)
            return self.red == other.red and self.green == other.green and self.blue == other.blue and self.alpha == other.alpha
        end,
        tostring = function (self)
            return string.format("(%d, %d, %d, %d)", self.red, self.green, self.blue, self.alpha)
        end
    }
}

function colour(red, green, blue, alpha)
    return setmetatable({red = red, green = green, blue = blue, alpha = alpha}, colour_mt)
end