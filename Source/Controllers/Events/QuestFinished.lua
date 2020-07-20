local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"

---@class QuestFinished: Event
local QuestFinished = Class("QuestFinished", Event)

function QuestFinished:new(state, actions)
    Event.new(self, "QUEST_FINISHED", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function QuestFinished:Observe(event, state, actions)
    event:mapTo(nil):bindTo(state.unitName)
    event:mapTo(nil):bindTo(state.dialogTexts)
    event:bindTo(actions.WINDOW_CLOSE)
    actions.CLOSE_BUTTON_CLICKED:subscribe(CloseQuest)
end

return QuestFinished