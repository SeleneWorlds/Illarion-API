function InputDialog(title, description, multiline, maxChars, callback)
    return {
        getSuccess = function() return false end,
        getInput = function() return "" end
    }
end