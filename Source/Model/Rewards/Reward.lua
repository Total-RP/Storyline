local Class = require "Libraries.Self"

---@class Reward
local Reward = Class("Reward")

function Reward:new()

end

function Reward:GetText()
    error("Override this method.")
end

function Reward:GetIcon()
    error("Override this method.")
end

function Reward:GetStringRepresentation()
    local icon = self:GetIcon()
    local iconTextureMarkup = ("|T%s:20:20|t"):format(icon)
    return iconTextureMarkup .. " " .. self:GetText()
end

return Reward