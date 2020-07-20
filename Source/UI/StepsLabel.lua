local Class = require "Libraries.Self"
local U = require "Utils"
local Rx = require "Libraries.WoWRx"

---@class StepsLabel
local StepsLabel = Class("StepsLabel")

---@param state Storyline_State
function StepsLabel:new(state)
    self.container = U.CreateFrame()
    self.container:SetSize(50, 30)

    self.label = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.label:SetAllPoints(self.container)

    state.dialogStep
        :combineLatest(state.amountOfDialogSteps)
        :map(function(currentStep, totalSteps)
            return currentStep .. "/" .. totalSteps
        end)
        :map(U.First(self.label))
        :subscribe(self.label.SetText)

    -- Hide when there's only 1 step
    state.amountOfDialogSteps
        :map(function(amountOfSteps)
            return amountOfSteps > 1
        end)
        :bindTo(Rx.Visibility(self.container))
end

return StepsLabel