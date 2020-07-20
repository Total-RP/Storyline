local Class = require "Libraries.Self"
local U = require "Utils"

---@class AutoWidthButton
local AutoWidthButton = Class("AutoWidthButton")

function AutoWidthButton:new()
    self.button = U.CreateButton("UIPanelButtonTemplate")
    self.button:SetHeight(30)
end

function AutoWidthButton:SetText(text)
    self.button:SetText(text)
    self.button:SetWidth(self.button:GetTextWidth() + 20)
end


return AutoWidthButton