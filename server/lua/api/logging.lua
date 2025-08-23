function log(message)
    print(message)
end

setmetatable(debug, {
    __call = function(_, message)
        print(message)
    end
})