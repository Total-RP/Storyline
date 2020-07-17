local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local GameEvents = require "GameEvents"


local GossipController = Class("GossipController")

---@param state Storyline_State
function GossipController:initialize(state)
	GameEvents.GOSSIP_SHOW
		:mapTo("target")
		:bindTo(state.targetUnit)

	GameEvents.GOSSIP_CLOSED
			  :mapTo(nil)
			  :bindTo(state.targetUnit)

	GameEvents.GOSSIP_SHOW
			  :map(GetGossipText)
			  :bindTo(state.dialogText)

	GameEvents.GOSSIP_CLOSED
			  :mapTo(nil)
			  :bindTo(state.dialogText)
end

return GossipController
