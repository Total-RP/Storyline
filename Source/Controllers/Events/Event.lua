local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"

---@class Event
local Event = Class("Event")

---@param event string
---@param state Storyline_State
---@param actions Storyline_Actions
function Event:new(event, state, actions)
    self:Observe(Rx.Event(event), state, actions)
end

function Event:Observe(event, state, actions)
    return error("Override this method.")
end

return Event