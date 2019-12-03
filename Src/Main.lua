local ParchmentFrame = require "UI.ParchmentFrame"
local ResizeButton = require "UI.ResizeButton"
local GreyBackgroundFrame = require "Utils.DesignBackgroundHelper"
local Frames = require "Libraries.Ellyb.Src.UI.Frames"
local QuestTitle = require "UI.QuestTitle"

local state = require "State"
--GreyBackgroundFrame:Show()

local StorylineMainFrame = ParchmentFrame("StorylineMainFrame")
StorylineMainFrame:SetParent(UIParent)
StorylineMainFrame:SetPoint("CENTER")
StorylineMainFrame:SetSize(700, 450)
StorylineMainFrame:SetFrameStrata("HIGH")
Frames.makeMovable(StorylineMainFrame)

local QuestTitleFrame = QuestTitle(state.quest)
QuestTitleFrame:SetParent(StorylineMainFrame)
QuestTitleFrame:SetPoint("TOP")

local StorylineMainFrameResizeButton = ResizeButton(StorylineMainFrame)
StorylineMainFrameResizeButton:SetSize(32, 32)
StorylineMainFrameResizeButton:SetParent(StorylineMainFrame)
StorylineMainFrameResizeButton:SetPoint("BOTTOMRIGHT", StorylineMainFrame, "BOTTOMRIGHT", -1, 6)

local GameEvents = require "Libraries.Ellyb.Src.Events.GameEvents"

GameEvents.registerCallback("QUEST_DETAIL", function()
    state.quest({
        npcName = UnitName("questnpc"),
        title = GetTitleText()
    })
end)
