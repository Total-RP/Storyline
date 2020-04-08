local Frame = require "Libraries.Ellyb.Src.UI.Widgets.Frame"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Colors = require "Libraries.Ellyb.Src.Enums.Colors"

---@class QuestTitle: Ellyb_Frame
local QuestTitle = Class("QuestTitle", Frame)

---@param questState Observable
function QuestTitle:initialize(questState)
    self.super.initialize(self)

    self:SetSize(384, 96)

    local bannerTexture = self:CreateTexture()
    bannerTexture:SetAllPoints(self)
    bannerTexture:SetDrawLayer("BACKGROUND")
    bannerTexture:SetAtlas("GarrMission_RewardsBanner-Desaturate")

    local text = self:CreateFontString(nil, nil, 'GameFontNormalLarge')
    text:SetSize(200, 50) -- TODO: Dynamic size with faction emblem
    text:SetPoint("CENTER", self, "CENTER", 0, 8)
    text:SetTextColor(Colors.WHITE:GetRGB())
    text:SetText("Quest Title")

    questState
        :filter(function(state) return state ~= nil end)
        :map(function(state)
            return state.title
        end)
        :subscribe(function(questText)
            text:SetText(questText)
        end)

    questState:subscribe(function(state)
        if state and state.title then
            self:Show()
        else
            self:Hide()
        end
    end)
end

return QuestTitle

