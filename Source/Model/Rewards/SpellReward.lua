local Class = require "Libraries.Self"
local Reward = require "Model.Rewards.Reward"

---@class SpellReward : Reward
local SpellReward = Class("SpellReward", Reward)

function SpellReward:new(name, id, texture, isTradeSkillSpell, isSpellLearned, shouldHideSpellLearned, isBoostSpell, garrisonFollowerId, genericUnlock)
    self.name = name
    self.id = id
    self.texture = texture
    self.isTradeSkillSpell = isTradeSkillSpell
    self.isSpellLearned = isSpellLearned
    self.shouldHideSpellLearned = shouldHideSpellLearned
    self.isBoostSpell = isBoostSpell
    self.garrisonFollowerId = garrisonFollowerId
    self.genericUnlock = genericUnlock
end

function SpellReward:GetText()
    return self.name
end

function SpellReward:GetIcon()
    return self.texture
end

return SpellReward