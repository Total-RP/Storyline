local Class = require "Libraries.Self"
local U = require "Utils"
local DialogOption = require "Model.DialogOptions.DialogOption"

---@class DialogController
local DialogController = Class("DialogController")

---@param state Storyline_State
---@param actions Storyline_Actions
function DialogController:new(state, actions)
    actions.GO_TO_NEXT_STEP
           :map(function()
        return math.min(state.dialogStep:getValue() + 1, table.getn(state.dialogTexts:getValue()))
    end)
           :bindTo(state.dialogStep)

    actions.GO_TO_PREVIOUS_STEP
           :map(function()
                return math.max(state.dialogStep:getValue() - 1, 1)
            end)
           :bindTo(state.dialogStep)

    actions.GO_TO_FIRST_STEP
        :mapTo(1)
        :bindTo(state.dialogStep)

    actions.GO_TO_LAST_STEP
        :combineLatest(state.amountOfDialogSteps)
        :map(U.TakeNth(2))
        :bindTo(state.dialogStep)

    ---@param dialogOption DialogOption
    actions.NEXT_AUTO_ACTION
           :map(function() return state.nextAction:getValue() end)
           :filter(U.Not(U.IsNil))
           :subscribe(function(dialogOption)
                dialogOption:Choose()
            end)
end

return DialogController