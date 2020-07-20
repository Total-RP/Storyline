local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"

---@class GossipClosed: Event
local GossipClosed = Class("GossipClosed", Event)

function GossipClosed:new(state, actions)
    Event.new(self, "GOSSIP_CLOSED", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function GossipClosed:Observe(event, state, actions)
    event:mapTo(nil):bindTo(state.unitName)
    event:mapTo(nil):bindTo(state.dialogTexts)
    event:mapTo(nil):bindTo(state.nextAction)
    event:bindTo(actions.WINDOW_CLOSE)
    actions.CLOSE_BUTTON_CLICKED:subscribe(C_GossipInfo.CloseGossip)
end

return GossipClosed