local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Actor = require "Actors.Actor"
local U = require "Utils.Utils"
local Rx = require "Libraries.Ellyb.Src.Libraries.RxLua.rx"
local WoWScheduler = require "Libraries.Ellyb.Src.Internals.Rx.WoWScheduler"

---@class TargetActor: Actor
local TargetActor = Class("TargetActor", Actor)

---@param state Storyline_State
function TargetActor:initialize(state)
	Actor.initialize(self, "Target")
	self.isModelDisplayedOnLeft = false

	state.targetUnit
	:map(U.NilTo("none"))
	:bindTo(self.rx.SetUnit)

	Rx.Observable:
end

return TargetActor