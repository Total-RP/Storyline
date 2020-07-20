local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local U = require "Utils"
local FrameLevels = require "UI.FrameLevels"
local BackgroundView = require "UI.BackgroundView"
local CloseButton = require "UI.CloseButton"
local ResizeButton = require "UI.ResizeButton"
local DialogView = require "UI.DialogView"
local Model = require "UI.Model"
local DebugView = require "UI.DebugView"

local lwin = _G.LibStub("LibWindow-1.1")

---@class MainView
local MainView = Class("MainView")

---@param state Storyline_State
---@param actions Storyline_Actions
---@param storage SavedVariablesStorage
function MainView:new(state, actions, storage)
    self:SetupMainFrame(state)
    self:MakeFrameMovable()
    self:SetupBackground()
    self:SetupBorderFrame()
    self:SetupCloseButton(actions)
    self:SetupResizeButton(actions)
    self:SetupDialogView(state, actions)
    self:SetupModels(state)
    self:SetupDebugView(state)

    actions.WINDOW_OPEN:mapTo(self.frame):subscribe(self.frame.Show)
    actions.WINDOW_CLOSE:mapTo(self.frame):subscribe(self.frame.Hide)
    actions.WINDOW_RESIZING
        :map(function(width, height)
            return { width = width, height = height }
        end)
        :bindTo(state.windowSize)

    storage:PersistSubject(state.windowSize, "WINDOW_SIZE")
end

---@param state Storyline_State
function MainView:SetupMainFrame(state)
    self.frame = CreateFrame("FRAME", Storyline_MainFrame)
    self.frame:SetParent(UIParent)
    self.frame:SetPoint("CENTER")
    self.frame:SetResizable(true)
    self.frame:SetClampedToScreen(true)
    self.frame:SetUserPlaced(true)

    self.frame:SetMinResize(500, 350)
    self.frame:SetFrameStrata("HIGH")

    state.windowSize
         :filter(U.Not(U.IsNil))
         :subscribe(function(windowSize)
            self.frame:SetSize(windowSize.width, windowSize.height)
        end)

    lwin.RegisterConfig(self.frame, _G.Storyline_Data)
    lwin.RestorePosition(self.frame)
    lwin.MakeDraggable(self.frame)
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

---@param state Storyline_State
function MainView:SetupModels(state)
    self.playerModel = Model(state.playerCamera, state.playerFacing, state.playerTargetDistance, state.playerHeightFactor, state.playerAnimation)
    self.playerModel.model:SetParent(self.frame)
    self.playerModel.model:SetFrameLevel(FrameLevels.MODELS)
    self.playerModel.model:SetAllPoints(self.frame)
    self.playerModel:SetUnit("Player")

    self.targetModel = Model(state.targetCamera, state.targetFacing, state.targetTargetDistance, state.targetHeightFactor, state.targetAnimation)
    self.targetModel.model:SetParent(self.frame)
    self.targetModel.model:SetFrameLevel(FrameLevels.MODELS)
    self.targetModel.model:SetAllPoints(self.frame)
    state.targetUnit:map(U.First(self.targetModel)):subscribe(self.targetModel.SetUnit)
end

function MainView:SetupDebugView(state)
    self.debugView = DebugView(state)
    self.debugView.container:SetParent(self.frame)
    self.debugView.container:SetPoint("LEFT", self.frame, "RIGHT",  10, 0)
end

return MainView