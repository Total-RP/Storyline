local ParchmentFrame = require "UI.ParchmentFrame"
local ResizeButton = require "UI.ResizeButton"
local GreyBackgroundFrame = require "Utils.DesignBackgroundHelper"
local Frames = require "Libraries.Ellyb.Src.UI.Frames"
local QuestTitle = require "UI.QuestTitle"
local CloseButton = require "Libraries.Ellyb.Src.UI.Buttons.CloseButton"
local SpeechBubble = require "UI.SpeechBubble"

local state = require "State"
--GreyBackgroundFrame:Show()

local StorylineMainFrame = ParchmentFrame("StorylineMainFrame")
StorylineMainFrame:SetParent(UIParent)
StorylineMainFrame:SetPoint("CENTER")
StorylineMainFrame:SetSize(700, 450)
StorylineMainFrame:SetMinResize(500, 350)
StorylineMainFrame:SetFrameStrata("HIGH")
Frames.makeMovable(StorylineMainFrame)

local QuestTitleFrame = QuestTitle(state.quest)
QuestTitleFrame:SetParent(StorylineMainFrame)
QuestTitleFrame:SetPoint("TOP")

local StorylineMainFrameResizeButton = ResizeButton(StorylineMainFrame)
StorylineMainFrameResizeButton:SetSize(32, 32)
StorylineMainFrameResizeButton:SetParent(StorylineMainFrame)
StorylineMainFrameResizeButton:SetPoint("BOTTOMRIGHT", StorylineMainFrame, "BOTTOMRIGHT", -1, 6)

local closeButton = CloseButton()
closeButton:SetParent(StorylineMainFrame)
closeButton:SetPoint("TOPRIGHT", StorylineMainFrame, "TOPRIGHT", -8, -10)
closeButton.rx.OnClick:subscribe(function()
    StorylineMainFrame:Hide()
end)

local speechBubble = SpeechBubble(state.quest)
speechBubble:SetParent(StorylineMainFrame)
speechBubble:SetPoint("RIGHT", StorylineMainFrame, "RIGHT", -35, 0)
speechBubble:SetPoint("LEFT", StorylineMainFrame, "LEFT", 37, 0)
speechBubble:SetPoint("BOTTOM", StorylineMainFrame, "BOTTOM", 0, 33)

StorylineMainFrameResizeButton.rx.OnResize:subscribe(function()
    speechBubble:UpdateHeight()
end)

local GameEvents = require "Libraries.Ellyb.Src.Events.GameEvents"

GameEvents.registerCallback("QUEST_DETAIL", function()
    state.quest({
        npcName = UnitName("questnpc"),
        title = GetTitleText(),
        text = GetQuestText(),
    })
end)
GameEvents.registerCallback("GOSSIP_SHOW", function()
    state.quest({
        npcName = UnitName("target"),
        title = nil,
        text = GetGossipText(),
    })
end)

GameEvents.registerCallback("QUEST_FINISHED", function()
    state.quest(nil)
end)

GameEvents.registerCallback("GOSSIP_CLOSED", function()
    state.quest(nil)
end)

state.quest(nil)

state.quest:subscribe(function(state)
    if state then
        StorylineMainFrame:Show()
    else
        StorylineMainFrame:Hide()
    end
end)

--GreyBackgroundFrame:Show()
