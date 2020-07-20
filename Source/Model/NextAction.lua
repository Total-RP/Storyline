local Class = require "Libraries.Self"

---@class NextAction
local NextAction = Class("NextAction")

---@param name string
---@param execute fun():void
function NextAction:new(name, execute)
    self.execute = execute
    self.name = name
end

function NextAction:GetName()
    return self.name
end

function NextAction:Execute()
    self.execute()
end

return NextAction