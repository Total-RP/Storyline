local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local U = require "Utils"
local SimpleDialogOption = require "Model.DialogOptions.SimpleDialogOption"
local AvailableQuestOption = require "Model.DialogOptions.AvailableQuestOption"

---@class GossipShow: Event
local GossipShow = Class("GossipShow", Event)

function GossipShow:new(state, actions)
    Event.new(self, "GOSSIP_SHOW", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function GossipShow:Observe(event, state, actions)
    event:mapTo("npc"):map(UnitName):bindTo(state.unitName)
    event:map(C_GossipInfo.GetText):map(U.Split):bindTo(state.dialogTexts)
    event:mapTo(true):bindTo(state.unitIsNPC)

    event:map(function()
        if C_GossipInfo.GetNumAvailableQuests() > 0 then
            local firstAvailableQuest = C_GossipInfo.GetAvailableQuests()[1]
            return AvailableQuestOption.createFromQuestInfo(firstAvailableQuest, U.CallWith(C_GossipInfo.SelectAvailableQuest, 1))
        end
        if C_GossipInfo.GetNumOptions() > 0 then
            local firstGossip = C_GossipInfo.GetOptions()[1]
            return SimpleDialogOption(firstGossip.name, firstGossip.type .. "GossipIcon", U.CallWith(C_GossipInfo.SelectOption, 1))
        end
        return SimpleDialogOption(CLOSE, "GossipGossipIcon", C_GossipInfo.CloseGossip)
    end)
    :bindTo(state.nextAction)

    event:bindTo(actions.GO_TO_FIRST_STEP)
    event
            :filter(U.IsNil) -- The event will have a texture kit ID for special frames, we don't want to handle those
            :map(self.ShouldSkipGossip):filter(U.Not(U.IsTrue)) -- Do not show frame when skipping gossip dialogs, so it doesn't blink
            :bindTo(actions.WINDOW_OPEN)
end

function GossipShow:ShouldSkipGossip()
    -- Borrowed from GossipFrame_HandleShow in GossipFrame.lua
    return ( (C_GossipInfo.GetNumAvailableQuests() == 0) and (C_GossipInfo.GetNumActiveQuests()  == 0) and (C_GossipInfo.GetNumOptions() == 1) and not C_GossipInfo.ForceGossip() )
end

-- TODO Options
function C_GossipInfo.ForceGossip()
    return true
end

return GossipShow