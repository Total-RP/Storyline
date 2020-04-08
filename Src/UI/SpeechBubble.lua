local Frame = require "Libraries.Ellyb.Src.UI.Widgets.Frame"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Animator = require "Libraries.Ellyb.Src.Tools.Animator"
local WoWScheduler = require "Libraries.Ellyb.Src.Internals.Rx.WoWScheduler"

---@class SpeechBubble: Ellyb_Frame
local SpeechBubble = Class("SpeechBubble", Frame)

---@param questState Observable
function SpeechBubble:initialize(questState)
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

    local bubbleTail = self:CreateTexture(nil, "OVERLAY")
    bubbleTail:SetTexture([[Interface\Tooltips\CHATBUBBLE-TAIL]])
    bubbleTail:SetTexCoord(1, 0, 1, 0)
    bubbleTail:SetSize(30, 28)
    bubbleTail:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -20, -3)
    bubbleTail:SetAlpha(0.85)

    local NPCNameBackground = self:CreateTexture(nil, "ARTWORK")
    NPCNameBackground:SetAtlas("Objective-Header")
    NPCNameBackground:SetTexCoord(1, 0, 0, 1)
    NPCNameBackground:SetPoint("TOP", self, "TOP", 0, 13)
    NPCNameBackground:SetPoint("RIGHT", self, "RIGHT", 8, 0)
    NPCNameBackground:SetSize(250, 95)

    local NPCName = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    NPCName:SetPoint("TOP", self, "TOP", 0, -10)
    NPCName:SetPoint("RIGHT", self, "RIGHT", -30, 0)
    NPCName:SetTextColor(1, 0.75, 0)


    local DialogText = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    DialogText:SetJustifyV("TOP")
    DialogText:SetJustifyH("LEFT")
    DialogText:SetSpacing(3)
    DialogText:SetPoint("TOP", NPCName, "TOP", 0, -35)
    DialogText:SetPoint("LEFT", self, "LEFT", 30, 0)
    DialogText:SetPoint("RIGHT", self, "RIGHT", -30, 0)

    questState =  questState:debounce(0.1, WoWScheduler)

    local heightAnimator = Animator()
    local textAlphaAnimator = Animator()
    function SpeechBubble:UpdateHeight(animated)
        local height = NPCName:GetHeight() + 35 + DialogText:GetStringHeight() + 15
        if height == self:GetHeight() then
            return
        end
        if animated then
            heightAnimator:RunValue(self:GetHeight(), height, 0.1, function(height)
                self:SetHeight(height)
            end)
            DialogText:SetAlpha(0)
            textAlphaAnimator:RunValue(0, 1, 0.2, function(alpha)
                DialogText:SetAlpha(alpha)
            end)
        else
            self:SetHeight(height)
        end
    end

    questState
        :subscribe(function(state)
        if state and state.npcName and state.npcName:len() > 0 then
            NPCName:SetText(state.npcName)
            NPCNameBackground:Show()
            bubbleTail:Show()
            DialogText:SetText(state.text)
        else
            NPCName:SetText("")
            NPCNameBackground:Hide()
            bubbleTail:Hide()
            DialogText:SetText("")
        end
        self:UpdateHeight(true)
    end)

    local alphaAnimator = Animator()

    questState
        :map(function(state) return state ~= nil end)
        :distinct()
        :subscribe(function(hasQuest)
        if hasQuest then
            self:Show()
            self:SetAlpha(0)
            alphaAnimator:RunValue(0, 1, 0.3, function(alpha)
                self:SetAlpha(alpha)
            end)
        else
            alphaAnimator:RunValue(0, 1, 0.3, function(alpha)
                alpha = 1 - alpha
                self:SetAlpha(alpha)
                if alpha == 0 then
                    self:Hide()
                end
            end)
        end
    end)
end

return SpeechBubble