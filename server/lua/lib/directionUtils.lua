local m = {}

function m.IllaToSelene(direction)
    if direction == Character.north then
        return "north"
    elseif direction == Character.south then
        return "south"
    elseif direction == Character.east then
        return "east"
    elseif direction == Character.west then
        return "west"
    end
end

function m.SeleneToIlla(direction)
    if direction == "north" then
        return Character.north
    elseif direction == "south" then
        return Character.south
    elseif direction == "east" then
        return Character.east
    elseif direction == "west" then
        return Character.west
    end
end

return m