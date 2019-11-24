local _, Storyline = ...

-- This does effectively nothing, except help my IDE provides code completion
---@class Storyline
---@field Rx Rx
Storyline = Storyline

local Ellyb = Ellyb(...)

Ellyb:SetDebugMode(false)

-- TODO MOVE ME

Storyline.Enum = {}

---@alias VISIBILITY "HIDDEN"|"VISIBLE"
Storyline.Enum.VISIBILITY = {
    HIDDEN = "HIDDEN",
    VISIBLE = "VISIBLE"
}

---@type Rx
local Rx = Storyline.Rx

Rx.Bindings.visibility = function(widget)
    local subject = Rx.Subject.create()
    subject:subscribe(function(visibility)
        if visibility == Storyline.Enum.VISIBILITY.VISIBLE then
            widget:Show()
        else
            widget:Hide()
        end
    end)
    return subject
end

Rx.util.toVisibility = function(booleanValue)
    return booleanValue and Storyline.Enum.VISIBILITY.VISIBLE or Storyline.Enum.VISIBILITY.HIDDEN
end