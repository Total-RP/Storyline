local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local U = require "Utils"
local FrameLevels = require "UI.FrameLevels"
local BackgroundView = require "UI.BackgroundView"
local CloseButton = require "UI.CloseButton"
local ResizeButton = require "UI.ResizeButton"
local DialogView = require "UI.DialogView"

---@class MainView
local MainView = Class("MainView")

---@param state Storyline_State
---@param actions Storyline_Actions
function MainView:new(state, actions)
    self:SetupMainFrame()
    self:MakeFrameMovable()
    self:SetupBackground()
    self:SetupBorderFrame()
    self:SetupCloseButton(actions)
    self:SetupResizeButton(actions)
    self:SetupDialogView(state, actions)

    actions.WINDOW_OPEN:mapTo(self.frame):subscribe(self.frame.Show)
    actions.WINDOW_CLOSE:mapTo(self.frame):subscribe(self.frame.Hide)
end

function MainView:SetupMainFrame()
    self.frame = U.CreateFrame()
    self.frame:SetParent(UIParent)
    self.frame:SetPoint("CENTER")
    self.frame:SetSize(700, 450)
    self.frame:SetMinResize(500, 350)
    self.frame:SetFrameStrata("HIGH")
end

function MainView:MakeFrameMovable()
    self.frame:RegisterForDrag("LeftButton")
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)
    self.frame:SetClampedToScreen(true)

    Rx.Script(self.frame, "OnDragStart"):subscribe(self.frame.StartMoving)
    Rx.Script(self.frame, "OnDragStop"):subscribe(self.frame.StopMovingOrSizing)
    Rx.Script(self.frame, "OnDragStop"):subscribe(ValidateFramePosition)
end

function MainView:SetupBackground()
    self.backgroundView = BackgroundView()
    self.backgroundView.frame:SetParent(self.frame)
    self.backgroundView.frame:SetAllPoints(self.frame)
    self.backgroundView.frame:SetFrameLevel(FrameLevels.BACKGROUND)
end

function MainView:SetupBorderFrame()
    self.borderFrame = U.CreateFrame()
    self.borderFrame:SetParent(self.frame)
    self.borderFrame:SetAllPoints(self.frame)
    self.borderFrame:SetFrameLevel(FrameLevels.BORDERS)
end

function MainView:SetupCloseButton(actions)
    self.closeButton = CloseButton(actions)
    self.closeButton.button:SetParent(self.frame)
    self.closeButton.button:SetFrameLevel(FrameLevels.WINDOW_CHROME)
    self.closeButton.button:SetPoint("TOPRIGHT")
end

function MainView:SetupResizeButton(actions)
    self.resizeButton = ResizeButton(self.frame, actions)
    self.resizeButton.button:SetParent(self.frame)
    self.resizeButton.button:SetFrameLevel(FrameLevels.WINDOW_CHROME)
    self.resizeButton.button:SetPoint("BOTTOMRIGHT")
end

---@param state Storyline_State
function MainView:SetupDialogView(state, actions)
    self.dialogView = DialogView(state, actions)
    self.dialogView.container:SetParent(self.frame)
    self.dialogView.container:SetFrameLevel(FrameLevels.DIALOG)
    self.dialogView.container:SetPoint("LEFT", self.frame, "LEFT", 25, 0)
    self.dialogView.container:SetPoint("RIGHT", self.frame, "RIGHT", -25, 0)
    self.dialogView.container:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 25)
end

return MainView