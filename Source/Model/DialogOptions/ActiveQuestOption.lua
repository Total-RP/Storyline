local Class = require "Libraries.Self"
local DialogOption = require "Model.DialogOptions.DialogOption"

---@class ActiveQuestOption: DialogOption
local ActiveQuestOption = Class("ActiveQuestOption", DialogOption)

---@param name string
---@param id number
---@param level number
---@param isComplete boolean
---@param isIgnored boolean
---@param isLegendary boolean
---@param isTrivial boolean
---@param isCampaign boolean
---@param isCovenantCalling boolean
function ActiveQuestOption:new(name, id, level, isComplete, isIgnored, isLegendary, isTrivial, isCampaign, isCovenantCalling, choose)
    DialogOption.new(self)
    self.name = name
    self.id = id
    self.level = level
    self.isComplete = isComplete
    self.isIgnored = isIgnored
    self.isLegendary = isLegendary
    self.isTrivial = isTrivial
    self.isCampaign = isCampaign
    self.isCovenantCalling = isCovenantCalling
    self.choose = choose
end

function ActiveQuestOption:GetText()
    return self.name
end

function ActiveQuestOption:GetIcon()
    return QuestUtil.GetQuestIconActive(
            self.isComplete,
            self.isLegendary,
            0,
            false,
            self.isCampaign,
            self.isCovenantCalling
    )
end

function ActiveQuestOption:Choose()
    self.choose()
end

return ActiveQuestOption