local Class = require "Libraries.Self"
local U = require "Utils"
local Rx = require "Libraries.WoWRx"
local AutoWidthButton = require "UI.AutoWidthButton"

---@class NextActionButton: AutoWidthButton
local NextActionButton = Class("NextActionButton", AutoWidthButton)

---@param state Storyline_State
---@param actions Storyline_Actions
function NextActionButton:new(state, actions)
    AutoWidthButton.new(self)
    self.button:SetText("Next")

    ---@param nextAction DialogOption
    state.nextAction
            :filter(U.Not(U.IsNil))
            :map(function(nextAction)
                return nextAction:GetStringRepresentation()
            end)
            :debug()
            :map(U.First(self))
            :subscribe(self.SetText)

    Rx.Click(self.button):bindTo(actions.NEXT_AUTO_ACTION)
end

return NextActionButton