local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"

---@class ItemTextClosed: Event
local ItemTextClosed = Class("ItemTextClosed", Event)


---@param state Storyline_State
---@param actions Storyline_Actions
function ItemTextClosed:new(state, actions)
    Event.new(self, "ITEM_TEXT_CLOSED", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function ItemTextClosed:Observe(event, state, actions)
    event:mapTo(nil):bindTo(state.unitName)
    event:mapTo(nil):bindTo(state.dialogTexts)
    event:mapTo(nil):bindTo(state.nextAction)
    event:bindTo(actions.WINDOW_CLOSE)
    actions.CLOSE_BUTTON_CLICKED:subscribe(CloseItemText)
end


return ItemTextClosed