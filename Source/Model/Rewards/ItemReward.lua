local Class = require "Libraries.Self"
local Reward = require "Model.Rewards.Reward"

---@class ItemReward: Reward
local ItemReward = Class("ItemReward", Reward)

function ItemReward:new(name, texture, amount, quality, isUsable)
    self.name = name
    self.texture = texture
    self.amount = amount
    self.quality = quality
    self.isUsable = isUsable
end

function ItemReward:GetIcon()
    return self.texture
end

function ItemReward:GetText()
    local text = ""
    if self.amount > 0 then
        text = self.amount .. " "
    end
    local r, g, b = GetItemQualityColor(self.quality);
    text = text .. self.name
    local color = CreateColor(r, g, b)
    text = color:WrapTextInColorCode(text)
    return text
end

return ItemReward