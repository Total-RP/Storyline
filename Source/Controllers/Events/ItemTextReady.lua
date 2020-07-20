local Class = require "Libraries.Self"
local Event = require "Controllers.Events.Event"
local SimpleDialogOption = require "Model.DialogOptions.SimpleDialogOption"

---@class ItemTextReady: Event
local ItemTextReady = Class("ItemTextReady", Event)

---@param state Storyline_State
---@param actions Storyline_Actions
function ItemTextReady:new(state, actions)
    Event.new(self, "ITEM_TEXT_BEGIN", state, actions)
end

---@param event Observable
---@param state Storyline_State
---@param actions Storyline_Actions
function ItemTextReady:Observe(event, state, actions)
    event:map(ItemTextGetItem):bindTo(state.unitName)
    event:map(self.GetAllContent):bindTo(state.dialogTexts)
    event:mapTo(false):bindTo(state.unitIsNPC)

    event:mapTo(SimpleDialogOption(CLOSE, "TrainerGossipIcon", CloseItemText)):bindTo(state.nextAction)

    event:bindTo(actions.WINDOW_OPEN)
    event:bindTo(actions.GO_TO_FIRST_STEP)
end

function ItemTextReady:GetAllContent()
    local content = {}
    table.insert(content, ItemTextGetText())
    while ItemTextHasNextPage() do
        ItemTextNextPage()
        table.insert(content, ItemTextGetText())
    end
    return content
end

return ItemTextReady