local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local AutoWidthButton = require "UI.AutoWidthButton"

---@class PreviousStepButton: AutoWidthButton
local PreviousStepButton = Class("PreviousStepButton", AutoWidthButton)

---@param state Storyline_State
---@param actions Storyline_Actions
function PreviousStepButton:new(state, actions)
    AutoWidthButton.new(self)
    self:SetText("Previous")

    self.button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    Rx.Click(self.button):bindTo(actions.GO_TO_PREVIOUS_STEP)
    Rx.RightClick(self.button):bindTo(actions.GO_TO_FIRST_STEP)


    -- Hide button if the current step is 1
    state.dialogStep
         :map(function(currentStep)
            return currentStep > 1
        end)
         :bindTo(Rx.Visibility(self.button))

end

return PreviousStepButton
