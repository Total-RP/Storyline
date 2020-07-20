local Class = require "Libraries.Self"
local Events = require "Actions"
local U = require "Utils"
local Rx = require "Libraries.WoWRx"

---@class CloseButton
local CloseButton = Class("CloseButton")

---@param actions Storyline_Actions
function CloseButton:new(actions)
    self.button = U.CreateButton()
    self.button:SetSize(32, 32)
    self.button:SetDisabledTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Disabled]])
    self.button:SetNormalTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
    self.button:SetPushedTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
    self.button:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]], "ADD")

    Rx.Script(self.button, "OnClick"):bindTo(actions.CLOSE_BUTTON_CLICKED)
end

return CloseButton