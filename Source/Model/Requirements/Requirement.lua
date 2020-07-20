local Class = require "Libraries.Self"

---@class Requirement
local Requirement = Class("Requirement")

function Requirement:new()

end

function Requirement:GetIcon()
    error("Override this method.")
end

function Requirement:GetText()
    error("Override this method.")
end

function Requirement:GetAmount()
    error("Override this method.")
end

function Requirement:GetStringRepresentation()
    local icon = self:GetIcon()
    local iconMarkup = ("|T%s:20:20|t"):format(icon)
    return iconMarkup .. " " .. self:GetAmount() .. " " .. self:GetText()
end

return Requirement