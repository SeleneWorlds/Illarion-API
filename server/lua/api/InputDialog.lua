function InputDialog(title, description, multiline, maxChars, callback)
    local dialog = {
        title = title,
        description = description,
        multiline = multiline,
        maxChars = maxChars,
        callback = callback,
        input = "",
        success = false
    }
    function dialog:getSuccess()
        return self.success
    end
    function dialog:getInput()
        return self.input
    end
    return dialog
end