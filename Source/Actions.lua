local Class = require "Libraries.Self"
local Rx = require "Libraries.RxLua"

---@class Storyline_Actions
local Actions = Class("Action")

function Actions:new()
    self.WINDOW_RESIZING = Rx.Subject.create()
    self.WINDOW_CLOSE = Rx.Subject.create()
    self.WINDOW_OPEN = Rx.Subject.create()
    self.CLOSE_BUTTON_CLICKED = Rx.Subject.create()
    self.GO_TO_NEXT_STEP = Rx.Subject.create()
    self.GO_TO_PREVIOUS_STEP = Rx.Subject.create()
    self.GO_TO_FIRST_STEP = Rx.Subject.create()
    self.GO_TO_LAST_STEP = Rx.Subject.create()
    self.NEXT_AUTO_ACTION = Rx.Subject.create()
end

return Actions