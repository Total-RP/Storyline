local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local U = require "Utils"
local SimpleDialogOption = require "Model.DialogOptions.SimpleDialogOption"

---@class QuestProgress: Event
local QuestProgress = Class("QuestProgress", Event)

function QuestProgress:new(state, actions)
    Event.new(self, "QUEST_PROGRESS", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function QuestProgress:Observe(event, state, actions)
    event:mapTo("questnpc"):bindTo(state.targetUnit)
    event:mapTo("questnpc"):map(UnitName):bindTo(state.unitName)
    event:map(GetProgressText):map(U.Split):bindTo(state.dialogTexts)
    event:mapTo(true):bindTo(state.unitIsNPC)

    event:map(function()
        if IsQuestCompletable() then
            return SimpleDialogOption(CONTINUE, "ActiveQuestIcon" , CompleteQuest)
        else
            return SimpleDialogOption(CLOSE, "IncompleteQuestIcon" , CloseQuest)
        end
    end):bindTo(state.nextAction)

    event:bindTo(actions.GO_TO_FIRST_STEP)
    event:bindTo(actions.WINDOW_OPEN)
end


return QuestProgress