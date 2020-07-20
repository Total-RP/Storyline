local Rx = require "Libraries.RxLua"

---@class GameEvents
local GameEvents = {
    GOSSIP_SHOW = Rx.Subject.create(),
    GOSSIP_CLOSED = Rx.Subject.create(),
    QUEST_GREETING = Rx.Subject.create(),
    QUEST_DETAIL = Rx.Subject.create(),
    QUEST_PROGRESS = Rx.Subject.create(),
    QUEST_COMPLETE = Rx.Subject.create(),
    QUEST_FINISHED = Rx.Subject.create(),
    QUEST_ITEM_UPDATE = Rx.Subject.create(),

}

---@type Frame
local eventFrame = CreateFrame("FRAME")

for eventName in pairs(GameEvents) do
    eventFrame:RegisterEvent(eventName)
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
    local eventSubject = GameEvents[event]
    if eventSubject then
        eventSubject:onNext(...)
    end
end)

return GameEvents