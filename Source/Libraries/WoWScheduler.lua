local Rx = require "Libraries.WoWRx"

--- @class WoWScheduler
--- @description A scheduler that uses luvit's timer library to schedule events on an event loop.
local WoWScheduler = {}
WoWScheduler.__index = WoWScheduler
WoWScheduler.__tostring = WoWScheduler

--- Creates a new WoWScheduler.
--- @return WoWScheduler
function WoWScheduler.create()
    return setmetatable({}, WoWScheduler)
end

--- Schedules an action to run at a future point in time.
--- @param action fun():void The action to run.
--- @arg delay number The delay, in milliseconds.
--- @return Subscription
function WoWScheduler:schedule(action, delay)
    local timer
    timer = C_Timer.NewTicker(delay, function()
        timer:Cancel()
        action()
    end)
    return Rx.Subscription.create(function()
        timer:Cancel()
    end)
end

return WoWScheduler