local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local U = require "Utils"
local SimpleDialogOption = require "Model.DialogOptions.SimpleDialogOption"

---@class QuestComplete: Event
local QuestComplete = Class("QuestComplete", Event)

function QuestComplete:new(state, actions)
    Event.new(self, "QUEST_COMPLETE", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function QuestComplete:Observe(event, state, actions)
    event:mapTo("questnpc"):map(UnitName):bindTo(state.unitName)
    event:map(GetRewardText):map(U.Split):bindTo(state.dialogTexts)
    event:mapTo(true):bindTo(state.unitIsNPC)

    event:mapTo(SimpleDialogOption(COMPLETE_QUEST, "ActiveQuestIcon", U.CallWith(GetQuestReward, 1))):bindTo(state.nextAction)

    event:bindTo(actions.GO_TO_FIRST_STEP)
    event:bindTo(actions.WINDOW_OPEN)
end

return QuestComplete