local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local ActiveQuestOption = require "Model.DialogOptions.ActiveQuestOption"
local AvailableQuestOption = require "Model.DialogOptions.AvailableQuestOption"
local U = require "Utils"

---@class QuestGreeting: Event
local QuestGreeting = Class("QuestGreeting", Event)

function QuestGreeting:new(state, actions)
    Event.new(self, "QUEST_GREETING", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function QuestGreeting:Observe(event, state, actions)
    event:mapTo("questnpc"):bindTo(state.targetUnit)
    event:mapTo("questnpc"):map(UnitName):bindTo(state.unitName)
    event:map(GetGreetingText):map(U.Split):bindTo(state.dialogTexts)
    event:mapTo(true):bindTo(state.unitIsNPC)

    event:map(function()
        if GetNumAvailableQuests() > 0 then
            local isTrivial, frequency, isRepeatable, isLegendary, questID = GetAvailableQuestInfo(1)
            return AvailableQuestOption(
                    GetAvailableTitle(1),
                    questID,
                    nil, -- level
                    false,
                    false, frequency, isRepeatable, isLegendary, isTrivial,
                    C_CampaignInfo.IsCampaignQuest(questID),
                    C_QuestLog.IsQuestCalling(questID),
                    U.CallWith(SelectAvailableQuest, 1)
            )
        end
        if GetNumActiveQuests() > 0 then
            local title, isComplete = GetActiveTitle(1)
            local questId = GetActiveQuestID(1);
            return ActiveQuestOption(
                    title,
                    questId,
                    nil, -- level
                    isComplete,
                    false, -- isIgnored
                    false, -- isLegendary
                    IsActiveQuestTrivial(1),
                    C_CampaignInfo.IsCampaignQuest(questId),
                    C_QuestLog.IsQuestCalling(questId),
                    U.CallWith(SelectActiveQuest, 1)
            )
        end
    end)
    :bindTo(state.nextAction)

    event:bindTo(actions.GO_TO_FIRST_STEP)
    event:bindTo(actions.WINDOW_OPEN)
end

return QuestGreeting