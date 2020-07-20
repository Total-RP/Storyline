local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"

---@class LabeledInputBox
local LabeledInputBox = Class("LabeledInputBox")

---@param labelText string
---@param inputSubscription Subscription
function LabeledInputBox:new(labelText, inputSubscription)
    self.container = CreateFrame("FRAME")
    self.container:SetSize(150, 42)

    self.label = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
    self.label:SetPoint("TOPLEFT")
    self.label:SetHeight(12)
    self.label:SetText(labelText)

    ---@type EditBox
    self.editBox = CreateFrame("EditBox", nil, self.container, "InputBoxTemplate")
    self.editBox:SetPoint("TOPLEFT", self.label, "BOTTOMLEFT")
    self.editBox:SetSize(150, 30)

    Rx.Script(self.editBox, "OnEnterPressed")
        :mapTo(self.editBox)
        :map(self.editBox.GetText)
        :bindTo(inputSubscription)
end

return LabeledInputBox