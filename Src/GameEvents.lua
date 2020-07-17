local RxUtils = require "Libraries.Ellyb.Src.Internals.Rx.RxUtils"

--- Easy to use game events exposed as Observables.
return {
	UNIT_MODEL_CHANGED = RxUtils.createSubjectFromGameEvent("UNIT_MODEL_CHANGED"),
	PLAYER_ENTERING_WORLD = RxUtils.createSubjectFromGameEvent("PLAYER_ENTERING_WORLD"),
	PLAYER_TARGET_CHANGED = RxUtils.createSubjectFromGameEvent("PLAYER_TARGET_CHANGED"),
	GOSSIP_SHOW = RxUtils.createSubjectFromGameEvent("GOSSIP_SHOW"),
	GOSSIP_CLOSED = RxUtils.createSubjectFromGameEvent("GOSSIP_CLOSED"),
}