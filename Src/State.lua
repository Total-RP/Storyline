local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Rx = require "Libraries.Ellyb.Src.Libraries.RxLua.rx"

---@class Storyline_State
local State = Class("State")

function State:initialize()
	self.targetUnit = Rx.Subject.create()
	self.dialogTitle = Rx.Subject.create()
	self.dialogText = Rx.Subject.create()

	self.targetUnit(nil)
	self.dialogTitle(nil)
	self.dialogText(nil)
end

return State