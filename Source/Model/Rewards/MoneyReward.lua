local Class = require "Libraries.Self"
local Reward = require "Model.Rewards.Reward"

---@class MoneyReward: Reward
local MoneyReward = Class("MoneyReward", Reward)

local MONEY_ICONS = {
    COPPER = [[Interface\ICONS\inv_misc_coin_05]],
    SILVER = [[Interface\ICONS\inv_misc_coin_03]],
    GOLD   = [[Interface\ICONS\inv_misc_coin_01]]
}

function MoneyReward:new(amountOfMoney)
    self.amountOfMoney = amountOfMoney
end

function MoneyReward:GetIcon()
    if self.amountOfMoney > 10000 then
        return MONEY_ICONS.GOLD
    elseif self.amountOfMoney > 100 then
        return MONEY_ICONS.SILVER
    else
        return MONEY_ICONS.COPPER
    end
    return
end

function MoneyReward:GetText()
    local gold = floor(self.amountOfMoney / (COPPER_PER_SILVER * SILVER_PER_GOLD));
    local silver = floor((self.amountOfMoney - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
    local copper = mod(self.amountOfMoney, COPPER_PER_SILVER);
    return ("%sg %ss %sc"):format(gold, silver, copper)
end

return MoneyReward