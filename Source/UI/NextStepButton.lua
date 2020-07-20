local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local AutoWidthButton = require "UI.AutoWidthButton"

---@class NextStepButton: AutoWidthButton
local NextStepButton = Class("NextStepButton", AutoWidthButton)

---@param state Storyline_State
---@param actions Storyline_Actions
function NextStepButton:new(state, actions)
    AutoWidthButton.new(self)
    self:SetText("Next")

    self.button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    Rx.Click(self.button):bindTo(actions.GO_TO_NEXT_STEP)
    Rx.RightClick(self.button):bindTo(actions.GO_TO_LAST_STEP)

    -- Hide button if the current step is the last step
    state.dialogStep
            :combineLatest(state.amountOfDialogSteps)
            :map(function(currentStep, amountOfDialogSteps)
                return currentStep < amountOfDialogSteps
            end)
            :bindTo(Rx.Visibility(self.button))

end

return NextStepButton
