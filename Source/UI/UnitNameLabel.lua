local Class = require "Libraries.Self"
local U = require "Utils"

---@class UnitNameLabel
local UnitNameLabel = Class("UnitNameLabel")

---@param state Storyline_State
function UnitNameLabel:new(state)
    self.container = U.CreateFrame()
    self.container:SetHeight(30)

    self.texture = self.container:CreateTexture()
    self.texture:SetDrawLayer("ARTWORK")
    self.texture:SetAtlas("Objective-Header")
    self.texture:SetTexCoord(1, 0, 0, 1)
    self.texture:SetPoint("TOPRIGHT", 25, 19)
    self.texture:SetSize(300, 105)
    self.texture:SetAlpha(0.6)

    self.label = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.label:SetAllPoints(self.container)
    self.label:SetJustifyH("RIGHT")

    state.unitName
        :map(U.First(self.label))
        :subscribe(self.label.SetText)
end

return UnitNameLabel