local Frame = require "Libraries.Ellyb.Src.UI.Widgets.Frame"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Animator = require "Libraries.Ellyb.Src.Tools.Animator"
local WoWScheduler = require "Libraries.Ellyb.Src.Internals.Rx.WoWScheduler"
local U = require "Utils.Utils"
local F = require "Libraries.Ellyb.Src.Tools.Functions"
local private = require "Libraries.Ellyb.Src.Internals.PrivateStorage"

---@class SpeechBubble: Ellyb_Frame
local SpeechBubble = Class("SpeechBubble", Frame)

---@param state Storyline_State
function SpeechBubble:initialize(state)
    self.super.initialize(self)

    self:SetBackdrop({
        bgFile = [[Interface\Tooltips\CHATBUBBLE-BACKGROUND]],
        edgeFile = [[Interface\Tooltips\CHATBUBBLE-BACKDROP]],
        tile = true,
        tileEdge = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 16, right = 16, top = 16, bottom = 16 },
    })

    self:SetBackdropBorderColor(0.75, 0.75, 0.75, 1)

    self.bubbleTail = self:CreateTexture(nil, "OVERLAY")
    self.bubbleTail:SetTexture([[Interface\Tooltips\CHATBUBBLE-TAIL]])
    self.bubbleTail:SetTexCoord(1, 0, 1, 0)
    self.bubbleTail:SetSize(30, 28)
    self.bubbleTail:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -20, -3)
    self.bubbleTail:SetAlpha(0.85)

    self.NPCNameBackground = self:CreateTexture(nil, "ARTWORK")
    self.NPCNameBackground:SetAtlas("Objective-Header")
    self.NPCNameBackground:SetTexCoord(1, 0, 0.2, 1)
    self.NPCNameBackground:SetPoint("TOP", self, "TOP", 0, -8)
    self.NPCNameBackground:SetPoint("RIGHT", self, "RIGHT", 8, 0)
    self.NPCNameBackground:SetSize(250, 85)

    self.NPCName = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.NPCName:SetPoint("TOP", self, "TOP", 0, -10)
    self.NPCName:SetPoint("RIGHT", self, "RIGHT", -30, 0)
    self.NPCName:SetTextColor(1, 0.75, 0)


    self.DialogText = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.DialogText:SetJustifyV("TOP")
    self.DialogText:SetJustifyH("LEFT")
    self.DialogText:SetSpacing(3)
    self.DialogText:SetPoint("TOP", self.NPCName, "TOP", 0, -35)
    self.DialogText:SetPoint("LEFT", self, "LEFT", 30, 0)
    self.DialogText:SetPoint("RIGHT", self, "RIGHT", -30, 0)

    state.targetUnit
        :filter(U.Not(U.IsNil))
        :map(UnitName)
        :subscribe(F.bind(self.SetUnitName, self))

    state.targetUnit
        :startWith(nil)
        :filter(U.IsNil)
        :subscribe(F.bind(self.HideUnitName, self))

    state.dialogText
        :filter(U.Not(U.IsNil))
        :subscribe(F.bind(self.SetDialogText, self))

    state.dialogText
        :startWith(nil)
        :filter(U.IsNil)
        :subscribe(F.bind(self.HideDialogText, self))

    state.dialogText
    :withPrevious(nil)
    :debounce(0.01, WoWScheduler)
    :filter(function()
        return self:GetHeight() ~= self:GetDesiredHeight()
    end)
    :subscribe(function(previousValue)
        if previousValue then
            self:AnimatedHeightRefresh()
        else
            self:RefreshHeight()
        end
    end)
end

function SpeechBubble:SetUnitName(unitName)
    self.NPCName:SetText(unitName)
    self.NPCNameBackground:Show()
    self.bubbleTail:Show()
end

function SpeechBubble:HideUnitName()
    self.NPCName:SetText("")
    self.NPCNameBackground:Hide()
    self.bubbleTail:Hide()
end

function SpeechBubble:SetDialogText(dialogText)
    self.DialogText:SetText(dialogText)
    self:Show()
end

function SpeechBubble:HideDialogText()
    self.DialogText:SetText("")
    self:Hide()
end

function SpeechBubble:GetDesiredHeight()
    return self.NPCName:GetHeight() + 35 + self.DialogText:GetStringHeight() + 15
end

local heightAnimator = Animator()
local textAlphaAnimator = Animator()
function SpeechBubble:AnimatedHeightRefresh()
    local desiredHeight = self:GetDesiredHeight()
    if self:GetHeight() == desiredHeight then
        return
    end

    heightAnimator:RunValue(self:GetHeight(), desiredHeight, 0.1, function(height)
        self:SetHeight(height)
    end)
    self.DialogText:SetAlpha(0)
    textAlphaAnimator:RunValue(0, 1, 0.3, function(alpha)
        self.DialogText:SetAlpha(alpha)
    end)
end

function SpeechBubble:RefreshHeight()
    self:SetHeight(self:GetDesiredHeight())
end

return SpeechBubble