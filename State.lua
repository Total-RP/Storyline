---@type Storyline
local _, Storyline = ...

local Rx = Storyline.Rx

--- Provides access to Storyline's state as RxLua observables
---@class StorylineState
local StorylineState = {}
Storyline.State = StorylineState

--- Will provide the name of the event that caused storyline to open
StorylineState.eventName = Rx.BehaviorSubject.create()

--- Will provide the quest ID
StorylineState.questId = Rx.BehaviorSubject.create()

--- Will be true when a war campaign quest is currently presented
StorylineState.isWarCampaign = Rx.BehaviorSubject.create()

--- Will provide the title of the quest currently presented
StorylineState.questTitle = Rx.BehaviorSubject.create()

--- Will provide the name of the quest NPC if available
StorylineState.npcName = Rx.BehaviorSubject.create()

--- Will provide all the text chunk for the current dialog
StorylineState.dialogText = Rx.BehaviorSubject.create()

--- Will indicate the current dialog step
StorylineState.dialogStep = Rx.BehaviorSubject.create()

StorylineState.amountOfSteps = Rx.BehaviorSubject.create()

StorylineState.dialogText
              :map(function(text) return #Storyline_API.getLinesFromText(text) end)
              :bindTo(StorylineState.amountOfSteps)

StorylineState.dialogStepText = Rx.Observable.combineLatest(
    StorylineState.dialogText:map(function(text) return Storyline_API.getLinesFromText(text) end),
    StorylineState.dialogStep
)
                                  :map(function(texts, index)
    return texts[index]
end)

StorylineState.nextAction = Rx.BehaviorSubject.create()

function StorylineStateDebug()
    for field, value in pairs(StorylineState) do
        print(field, value:GetValue())
    end
end

-- TODO Move me
local Events = {
    QUEST_PROGRESS = Rx.Observable.createFromGameEvent("QUEST_PROGRESS"),
    QUEST_COMPLETE = Rx.Observable.createFromGameEvent("QUEST_COMPLETE"),
    QUEST_DETAIL = Rx.Observable.createFromGameEvent("QUEST_DETAIL"),
    QUEST_GREETING = Rx.Observable.createFromGameEvent("QUEST_GREETING"),
    GOSSIP_SHOW = Rx.Observable.createFromGameEvent("GOSSIP_SHOW"),
    STORYLINE_REPLAY = Rx.Observable.createFromGameEvent("PLAYER_ENTERING_WORLD")
                         :flatMap(function()
        return Rx.Observable.createFromSecureFunctionHook("QuestMapFrame_OpenToQuestDetails")
    end)
}

--region Event name
Events.QUEST_PROGRESS
      :map(function() return "QUEST_PROGRESS" end)
      :bindTo(StorylineState.eventName)
Events.QUEST_COMPLETE
      :map(function() return "QUEST_COMPLETE" end)
      :bindTo(StorylineState.eventName)
Events.QUEST_DETAIL
      :map(function() return "QUEST_DETAIL" end)
      :bindTo(StorylineState.eventName)
Events.QUEST_GREETING
      :map(function() return "QUEST_GREETING" end)
      :bindTo(StorylineState.eventName)
Events.GOSSIP_SHOW
      :map(function() return "GOSSIP_SHOW" end)
      :bindTo(StorylineState.eventName)
Events.STORYLINE_REPLAY
      :map(function() return "STORYLINE_REPLAY" end)
      :bindTo(StorylineState.eventName)
--endregion

--region Quest ID

Rx.Observable.merge(
    Events.QUEST_PROGRESS,
    Events.QUEST_COMPLETE,
    Events.QUEST_DETAIL,
    Events.QUEST_GREETING
)
  :map(GetQuestID)
  :bindTo(StorylineState.questId)

Events.GOSSIP_SHOW
      :map(function() return nil end)
      :bindTo(StorylineState.questId)


Events.STORYLINE_REPLAY
      :map(function()
    local _, _, _, _, _, _, _, questId, _, _, _, _, _, _, _ = GetQuestLogTitle(GetQuestLogSelection())
    return questId
end)
      :bindTo(StorylineState.questId)

--endregion

--region Quest title

Rx.Observable.merge(
    Events.QUEST_PROGRESS,
    Events.QUEST_COMPLETE,
    Events.QUEST_DETAIL,
    Events.QUEST_GREETING
)
  :map(GetTitleText)
  :bindTo(StorylineState.questTitle)

Events.GOSSIP_SHOW
      :map(function() return nil end)
      :bindTo(StorylineState.questTitle)

Events.STORYLINE_REPLAY
      :map(function()
    local questTitle = GetQuestLogTitle(GetQuestLogSelection())
    return questTitle
end)
      :bindTo(StorylineState.questTitle)

--endregion

--region NPC name

Rx.Observable.merge(
    Events.QUEST_PROGRESS,
    Events.QUEST_COMPLETE,
    Events.QUEST_DETAIL,
    Events.QUEST_GREETING,
    Events.GOSSIP_SHOW
)
  :map(function()
    return UnitName("npc")
end)
  :bindTo(StorylineState.npcName)

Events.STORYLINE_REPLAY
      :map(function() return nil end)
      :bindTo(StorylineState.npcName)

--endregion

--region Dialog texts

Events.QUEST_GREETING
      :map(GetGreetingText)
      :bindTo(StorylineState.dialogText)

Events.QUEST_DETAIL
      :map(GetQuestText)
      :bindTo(StorylineState.dialogText)

Events.QUEST_PROGRESS
      :map(GetProgressText)
      :bindTo(StorylineState.dialogText)

Events.QUEST_COMPLETE
      :map(GetRewardText)
      :bindTo(StorylineState.dialogText)

Events.GOSSIP_SHOW
      :map(GetGossipText)
      :bindTo(StorylineState.dialogText)

Events.STORYLINE_REPLAY
      :map(function()
    local dialogText, _ = GetQuestLogQuestText()
    return dialogText
end)
      :bindTo(StorylineState.dialogText)
--endregion

--region Dialog step
Rx.Observable.merge(
    Events.QUEST_PROGRESS,
    Events.QUEST_COMPLETE,
    Events.QUEST_DETAIL,
    Events.QUEST_GREETING,
    Events.STORYLINE_REPLAY,
    Events.GOSSIP_SHOW
)
  :map(function() return 1 end)
  :bindTo(StorylineState.dialogStep)
--endregion

local loc = Storyline_API.locale.getText
--region Next action
Rx.Observable.combineLatest(
    StorylineState.eventName,
    StorylineState.dialogStep,
    StorylineState.amountOfSteps
)
  :map(function(eventName, step, totalStep)
    if step < totalStep then
        return CONTINUE
    else
        if eventName == "QUEST_DETAIL" then
            return loc("SL_CHECK_OBJ")
        elseif eventName == "QUEST_GREETING" then
            local bestFirstChoice = Storyline_API.dialogs.getFirstChoice(Storyline_API.dialogs.EVENT_TYPES.QUEST_GREETING)
            return bestFirstChoice and bestFirstChoice.title or GOODBYE
        elseif eventName == "GOSSIP_SHOW" then
            local bestFirstChoice = Storyline_API.dialogs.getFirstChoice(Storyline_API.dialogs.EVENT_TYPES.GOSSIP_SHOW)
            return bestFirstChoice and bestFirstChoice.title or GOODBYE
        end
    end
    return UNKNOWN
end)
  :bindTo(StorylineState.nextAction)

--endregion

--region War campaign


StorylineState.questId
    :map(function(questId)
        if questId then
            return C_CampaignInfo.IsCampaignQuest(questId)
        else
            return false
        end
    end)
    :bindTo(StorylineState.isWarCampaign)

--endregion