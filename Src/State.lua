local Rx = require "Libraries.Ellyb.Src.Libraries.RxLua.rx"

---@class StorylineState
local State = {}

State.quest = Rx.Subject.create()

return State