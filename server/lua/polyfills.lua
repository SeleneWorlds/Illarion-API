if not table.pack then
    function table.pack(...)
        return { n = select("#", ...), ... }
    end
end