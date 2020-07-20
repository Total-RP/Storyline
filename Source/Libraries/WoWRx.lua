local Rx = require "Libraries.RxLua"

---@param object ScriptObject
---@param scriptName string
---@return Observable
function Rx.Script(object, scriptName)
    local subject = Rx.Subject.create()
    object:HookScript(scriptName, function(...)
        subject:onNext(...)
    end)
    return subject
end

---@type Frame
local eventFrame = CreateFrame("FRAME")
local eventsSubjects = {}
eventFrame:SetScript("OnEvent", function(_, event, ...)
    local eventSubject = eventsSubjects[event]
    if eventSubject then
        eventSubject:onNext(...)
    end
end)

---@param eventName string
---@return Observable
function Rx.Event(eventName)
    if not eventsSubjects[eventName] then
        eventsSubjects[eventName] = Rx.Subject.create()
        if not eventFrame:IsEventRegistered(eventName) then
            eventFrame:RegisterEvent(eventName)
        end
    end
    Rx.Observable.create()
    return eventsSubjects[eventName]
end

---@param button Button
---@param mouseButton string
---@return Observable
function Rx.Click(button, mouseButton)
    mouseButton = mouseButton or "LeftButton"
    return Rx.Script(button, "OnClick"):filter(function(_, buttonClicked)
        return buttonClicked == mouseButton
    end)
end

function Rx.RightClick(button)
    return Rx.Click(button, "RightButton")
end

---@param frame Frame
function Rx.Visibility(frame)
    local subject = Rx.Subject.create()

    subject:subscribe(function(shouldFrameBeVisible)
        if shouldFrameBeVisible then
            frame:Show()
        else
            frame:Hide()
        end
    end)

    return subject
end

function Rx.OnUpdateDebounce(threshold)
    local lastTime = 0
    return function()
        if GetTime() - lastTime >= threshold then
            lastTime = GetTime()
            return true
        else
            return false
        end
    end
end

local timers = {}
eventFrame:SetScript("OnUpdate", function()
    for timer, info in pairs(timers) do
        if GetTime() - info.lastTime >= info.timer then
            timer()
            info.lastTime = GetTime()
        end
    end
end)

function Rx.Timer(timer)
    local subject = Rx.Subject.create()

    timers[subject] = { timer = timer, lastTime = 0}

    -- Make sure to clean timers table when subscriptions ends
    subject:subscribe(nil, nil, function()
        timers[subject] = nil
    end)

    return subject
end

---@param observable Observable
function Rx.Subject:bind(observable)
    return observable:subscribe(
            function(...)
                self:onNext(...)
            end,
            function(...)
                self:onError(...)
            end,
            function()
                self:onCompleted()
            end
    )
end

return Rx