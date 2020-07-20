local Class = require "Libraries.Self"
local U = require "Utils"
local NextStepButton = require "UI.NextStepButton"
local PreviousStepButton = require "UI.PreviousStepButton"
local NextActionButton = require "UI.NextActionButton"
local StepsLabel = require "UI.StepsLabel"
local UnitNameLabel = require "UI.UnitNameLabel"
local Rx = require "Libraries.WoWRx"

---@class DialogView
local DialogView = Class("DialogView")

local MARGINS_SIZE = 20

---@param state Storyline_State
---@param actions Storyline_Actions
function DialogView:new(state, actions)
    ---@type Frame
    self.container = CreateFrame("FRAME")

    --region Setup backdrop
    Mixin(self.container, BackdropTemplateMixin)
    self.container.backdropInfo = BACKDROP_CHAT_BUBBLE_16_16
    self.container.insert = 16
    self.container:OnBackdropLoaded()
    --endregion

    --region Attach speech bubble trail
    self.tail = self.container:CreateTexture()
    self.tail:SetDrawLayer("ARTWORK")
    self.tail:SetTexture([[Interface/Tooltips/ChatBubble-Tail]])
    self.tail:SetTexCoord(1, 0, 1, 0)
    self.tail:SetSize(32, 32)
    self.tail:SetPoint("BOTTOMRIGHT", self.container, "TOPRIGHT", -10, -3)
    --endregion

    self.nextActionButton = NextActionButton(state, actions)
    self.nextActionButton.button:SetParent(self.container)
    self.nextActionButton.button:SetPoint("BOTTOMRIGHT", -3, 3)

    self.nextStepButton = NextStepButton(state, actions)
    self.nextStepButton.button:SetParent(self.container)
    self.nextStepButton.button:SetPoint("BOTTOMRIGHT", self.nextActionButton.button, "BOTTOMLEFT", -5, 0)

    self.previousStepButton = PreviousStepButton(state, actions)
    self.previousStepButton.button:SetParent(self.container)
    self.previousStepButton.button:SetPoint("BOTTOMLEFT", 3, 3)

    self.stepsLabel = StepsLabel(state)
    self.stepsLabel.container:SetParent(self.container)
    self.stepsLabel.container:SetPoint("TOPLEFT",MARGINS_SIZE, -3)

    self.unitNameLabel = UnitNameLabel(state)
    self.unitNameLabel.container:SetParent(self.container)
    self.unitNameLabel.container:SetPoint("TOPRIGHT", -MARGINS_SIZE, -3)
    self.unitNameLabel.container:SetPoint("TOPLEFT", MARGINS_SIZE, -3)

    --region Setup text FontString
    self.dialogText = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.dialogText:SetPoint("BOTTOM", self.nextStepButton.button, "TOP", 0, MARGINS_SIZE)
    self.dialogText:SetPoint("LEFT", self.container, "LEFT", MARGINS_SIZE, 0)
    self.dialogText:SetPoint("RIGHT", self.container, "RIGHT", -MARGINS_SIZE, 0)
    self.dialogText:SetJustifyH("LEFT")
    --endregion

    -- Refresh the height whenever the window is resized
    actions.WINDOW_RESIZING:mapTo(self):subscribe(self.RefreshDynamicHeight)
    -- Refresh height when step changes (lower buttons might change)
    state.dialogStep:mapTo(self):subscribe(self.RefreshDynamicHeight)

    state.unitIsNPC
        :bindTo(Rx.Visibility(self.tail))

    -- Hide while dialog is empty (might be loading)
    state.dialogTexts:map(U.Not(U.IsNil)):bindTo(Rx.Visibility(self.container))

    state.dialogTexts
         :filter(U.Not(U.IsNil))
         :combineLatest(state.dialogStep)
            :map(function(texts, step)
                return texts[step]
            end)
            :map(U.First(self)):subscribe(self.SetDialogText)

    Rx.Script(self.container, "OnMouseWheel"):subscribe(function(_, orientation)
        if orientation > 0 then
            actions.GO_TO_PREVIOUS_STEP()
        else
            actions.GO_TO_NEXT_STEP()
        end
    end)
end

---@param dialogText string
function DialogView:SetDialogText(dialogText)
    self.dialogText:SetText(dialogText)
    self:RefreshDynamicHeight()
end

function DialogView:RefreshDynamicHeight()
    local effectiveHeight = self.dialogText:GetStringHeight()

    effectiveHeight = effectiveHeight + math.max(
        self.nextStepButton.button:GetHeight(),
        self.previousStepButton.button:GetHeight(),
        self.nextActionButton.button:GetHeight()
    )
    effectiveHeight = effectiveHeight + self.unitNameLabel.container:GetHeight()
    effectiveHeight = effectiveHeight + MARGINS_SIZE * 2

    self.container:SetHeight(effectiveHeight)
end

return DialogView