local ParchmentFrame = require "UI.ParchmentFrame"
local ResizeButton = require "UI.ResizeButton"
local GreyBackgroundFrame = require "Utils.DesignBackgroundHelper"
local Frames = require "Libraries.Ellyb.Src.UI.Frames"
local QuestTitle = require "UI.QuestTitle"
local CloseButton = require "Libraries.Ellyb.Src.UI.Buttons.CloseButton"
local SpeechBubble = require "UI.SpeechBubble"
local GossipController = require "GossipController"
local State = require "State"
local UILayers = require "UILayers"

local storylineState = State()

--GreyBackgroundFrame:Show()

local gossipController = GossipController(storylineState)

local StorylineMainFrame = ParchmentFrame("StorylineMainFrame")
StorylineMainFrame:SetParent(UIParent)
StorylineMainFrame:SetPoint("CENTER")
StorylineMainFrame:SetSize(700, 450)
StorylineMainFrame:SetMinResize(500, 350)
StorylineMainFrame:SetFrameStrata("HIGH")
Frames.makeMovable(StorylineMainFrame)

local playerActor = require "Actors.PlayerActor"
playerActor:SetParent(StorylineMainFrame)
playerActor:SetFrameLevel(UILayers.MODELS)
playerActor:SetPoint("TOP", 0, -20)
playerActor:SetPoint("LEFT", 20, 0)
playerActor:SetPoint("RIGHT", -20, 0)
playerActor:SetPoint("BOTTOM", 0, 20)

local TargetActor = require "Actors.TargetActor"
local targetActor = TargetActor(storylineState)
targetActor:SetParent(StorylineMainFrame)
targetActor:SetFrameLevel(UILayers.MODELS)
targetActor:SetPoint("TOP", 0, -20)
targetActor:SetPoint("LEFT", 20, 0)
targetActor:SetPoint("RIGHT", -20, 0)
targetActor:SetPoint("BOTTOM", 0, 20)

--local QuestTitleFrame = QuestTitle(state)
--QuestTitleFrame:SetParent(StorylineMainFrame)
--QuestTitleFrame:SetPoint("TOP")

local StorylineMainFrameResizeButton = ResizeButton(StorylineMainFrame)
StorylineMainFrameResizeButton:SetParent(StorylineMainFrame)
StorylineMainFrameResizeButton:SetFrameLevel(UILayers.WINDOW_CHROME)
StorylineMainFrameResizeButton:SetSize(32, 32)
StorylineMainFrameResizeButton:SetPoint("BOTTOMRIGHT", StorylineMainFrame, "BOTTOMRIGHT", -1, 6)

local closeButton = CloseButton()
closeButton:SetParent(StorylineMainFrame)
closeButton:SetFrameLevel(UILayers.WINDOW_CHROME)
closeButton:SetPoint("TOPRIGHT", StorylineMainFrame, "TOPRIGHT", -8, -10)
closeButton.rx.OnClick:subscribe(function()
    StorylineMainFrame:Hide()
end)

local speechBubble = SpeechBubble(storylineState)
speechBubble:SetParent(StorylineMainFrame)
speechBubble:SetFrameLevel(UILayers.DISCUSSION_TEXT)
speechBubble:SetPoint("RIGHT", StorylineMainFrame, "RIGHT", -35, 0)
speechBubble:SetPoint("LEFT", StorylineMainFrame, "LEFT", 37, 0)
speechBubble:SetPoint("BOTTOM", StorylineMainFrame, "BOTTOM", 0, 33)
speechBubble:SetHeight(50)

StorylineMainFrameResizeButton.rx.OnResize:subscribe(function()
    speechBubble:SetHeight(speechBubble:GetDesiredHeight())
end)



storylineState.dialogText
  :map(function(dialogText) return dialogText ~= nil end)
    :startWith(false)
    :subscribe(function(showFrame)
    if showFrame then
        StorylineMainFrame:Show()
    else
        StorylineMainFrame:Hide()
    end
end)

--GreyBackgroundFrame:Show()
