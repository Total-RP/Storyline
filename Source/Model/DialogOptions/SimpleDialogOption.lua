local Class = require "Libraries.Self"
local DialogOption = require "Model.DialogOptions.DialogOption"

---@class SimpleDialogOption: DialogOption
local SimpleDialogOption = Class("SimpleDialogOption", DialogOption)

function SimpleDialogOption:new(text, type, execute)
    DialogOption.new(self)
    self.text = text
    self.type = type
    self.execute = execute
end

function SimpleDialogOption:GetIcon()
    return ([[Interface\GossipFrame\%s]]):format(self.type)
end

function SimpleDialogOption:GetText()
    return self.text
end

function SimpleDialogOption:Choose()
    self.execute()
end

return SimpleDialogOption