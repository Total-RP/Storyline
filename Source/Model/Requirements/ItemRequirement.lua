local Class = require "Libraries.Self"
local Requirement = require "Model.Requirements.Requirement"

---@class ItemRequirement: Requirement
local ItemRequirement = Class("ItemRequirement", Requirement)

function ItemRequirement:new(name, texture, amount)
    self.name = name
    self.texture = texture
    self.amount = amount
end

function ItemRequirement:GetText()
    return self.name
end

function ItemRequirement:GetIcon()
    return self.texture
end

function ItemRequirement:GetAmount()
    return self.amount
end

return ItemRequirement