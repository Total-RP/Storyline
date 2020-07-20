local Class = require "Libraries.Self"
local Reward = require "Model.Rewards.Reward"

---@class ExperienceReward: Reward
local ExperienceReward = Class("ExperienceReward", Reward)

function ExperienceReward:new(amountOfExperience)
    self.amountOfExperience = amountOfExperience
end

function ExperienceReward:GetIcon()
    return [[Interface\ICONS\xp_icon]]
end

function ExperienceReward:GetText()
    return self.amountOfExperience
end

return ExperienceReward