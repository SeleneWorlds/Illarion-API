function uniform(min, max)
    return min and max and math.random(min, max) or math.random()
end

function normal(mean, standard_deviation)
    local u1 = math.random()
    local u2 = math.random()
    local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
    return mean + standard_deviation * z0
end
