local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"

---@class Storyline_State
local State = Class("State")

function State:new()
    self.unitName = Rx.Subject.create()
    self.dialogTexts = Rx.BehaviorSubject.create()
    self.amountOfDialogSteps = self.dialogTexts:map(function(dialogTexts)
        return dialogTexts and table.getn(dialogTexts) or 0
    end)
    self.dialogStep = Rx.BehaviorSubject.create(1)
    self.dialogOptions = Rx.Subject.create()
    self.questObjectives = Rx.Subject.create()
    self.questRewards = Rx.Subject.create()
    self.portrait = Rx.Subject.create()
    self.requirements = Rx.Subject.create()
    self.unitIsNPC = Rx.BehaviorSubject.create(false)
    self.nextAction = Rx.BehaviorSubject.create()
end

return State