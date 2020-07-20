local Class = require "Libraries.Self"

---@class DialogOption
local DialogOption = Class("DialogOption")

function DialogOption:new()
end

function DialogOption:GetIcon()
    return error("Override this method.")
end

function DialogOption:GetText()
    return error("Override this method.")
end

function DialogOption:Choose()
    return error("Override this method.")
end

function DialogOption:GetStringRepresentation()
    local icon = self:GetIcon()
    if icon:find("Interface") then
        icon = CreateTextureMarkup(icon, 16, 16, 16, 16, 0, 1, 0, 1, 0, 0)
    else
        icon = CreateAtlasMarkup(icon, 16, 16)
    end
    return icon .. " " .. self:GetText()
end

return DialogOption