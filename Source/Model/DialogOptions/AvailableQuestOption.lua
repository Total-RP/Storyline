local Class = require "Libraries.Self"
local DialogOption = require "Model.DialogOptions.DialogOption"

---@class AvailableQuestOption: DialogOption
local AvailableQuestOption = Class("QuestDialogOption", DialogOption)

---@param name string
---@param id number
---@param level number
---@param isComplete boolean
---@param frequency number
---@param isRepeatable boolean
---@param isIgnored boolean
---@param isLegendary boolean
---@param isTrivial boolean
---@param isCampaign boolean
---@param isCovenantCalling boolean
---@param choose fun():void
function AvailableQuestOption:new(name, id, level, isComplete, isIgnored, frequency, isRepeatable, isLegendary, isTrivial, isCampaign, isCovenantCalling, choose)
    DialogOption.new(self)
    self.name = name
    self.id = id
    self.level = level
    self.isComplete = isComplete
    self.frequency = frequency
    self.isRepeatable = isRepeatable
    self.isIgnored = isIgnored
    self.isLegendary = isLegendary
    self.isTrivial = isTrivial
    self.isCampaign = isCampaign
    self.isCovenantCalling = isCovenantCalling
    self.choose = choose
end

function AvailableQuestOption.createFromQuestInfo(questInfo, choose)
    return AvailableQuestOption(
            questInfo.title,
            questInfo.questID,
            questInfo.questLevel,
            false,
            questInfo.isIgnored,
            questInfo.frequency,
            questInfo.repeatable,
            questInfo.isLegendary,
            questInfo.isTrivial,
            C_CampaignInfo.IsCampaignQuest(questInfo.questID),
            C_QuestLog.IsQuestCalling(questInfo.questID),
            choose
    )
end

function AvailableQuestOption:GetIcon()
    return QuestUtil.GetQuestIconOffer(self.isLegendary, self.frequency, self.isRepeatable, self.isCampaign, self.isCovenantCalling)
end

function AvailableQuestOption:GetText()
    return self.name
end

function AvailableQuestOption:Choose()
    self.choose()
end

return AvailableQuestOption