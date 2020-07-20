local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local U = require "Utils"
local NextAction = require "Model.NextAction"
local SimpleDialogOption = require "Model.DialogOptions.SimpleDialogOption"

---@class QuestDetail: Event
local QuestDetail = Class("QuestDetail", Event)

function QuestDetail:new(state, actions)
    Event.new(self, "QUEST_DETAIL", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function QuestDetail:Observe(event, state, actions)
    event:mapTo("questnpc"):bindTo(state.targetUnit)
    event:mapTo("questnpc"):map(UnitName):bindTo(state.unitName)
    event:map(GetQuestText):map(U.Split):bindTo(state.dialogTexts)
    event:mapTo(true):bindTo(state.unitIsNPC)

    event:mapTo(SimpleDialogOption(ACCEPT, "GossipGossipIcon", AcceptQuest)):bindTo(state.nextAction)

    event:bindTo(actions.GO_TO_FIRST_STEP)
    event:bindTo(actions.WINDOW_OPEN)
end

return QuestDetail