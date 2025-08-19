function SelectionDialog(title, message, callback)
    local dialog = {
        title = title,
        message = message,
        callback = callback,
        closeOnMove = false,
        options = {},
        success = false,
        selectedIndex = 0
    }
    function dialog:addOption(item, name)
        table.insert(dialog.options, { item = item, name = name })
    end
    function dialog:setCloseOnMove()
        self.closeOnMove = true
    end
    function dialog:getSuccess()
        return self.success
    end
    function dialog:getSelectedIndex()
        return self.selectedIndex
    end
    return dialog
end