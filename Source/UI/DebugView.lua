local Class = require "Libraries.Self"
local LabeledInputBox = require "UI.LabeledInputBox"
local LabeledSlider = require "UI.Controls.LabeledSlider"

---@class DebugView
local DebugView = Class("DebugView")

---@param state Storyline_State
function DebugView:new(state)
    ---@type Frame
    self.container = CreateFrame("FRAME")
    self.container:SetSize(230, 600)

    Mixin(self.container, BackdropTemplateMixin)
    self.container.backdropInfo = BACKDROP_DIALOG_32_32
    self.container.insert = 32
    self.container:OnBackdropLoaded()

    local title = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOP", self.container, "TOP", 0, -25)
    title:SetPoint("RIGHT", self.container, "RIGHT", -25, 0)
    title:SetPoint("LEFT", self.container, "LEFT", 25, 0)
    title:SetText("Debug View")

    local playerCamera = LabeledSlider("Player camera", state.playerCamera, 1, 5, 0.05)
    playerCamera.container:SetParent(self.container)
    playerCamera.container:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)

    local playerFacing = LabeledSlider("Player facing", state.playerFacing, -3, 3, 0.1)
    playerFacing.container:SetParent(self.container)
    playerFacing.container:SetPoint("TOPLEFT", playerCamera.slider, "BOTTOMLEFT", 0, -10)

    local playerTargetDistance = LabeledSlider("Player target distance", state.playerTargetDistance, -1, 1, 0.01)
    playerTargetDistance.container:SetParent(self.container)
    playerTargetDistance.container:SetPoint("TOPLEFT", playerFacing.slider, "BOTTOMLEFT", 0, -10)

    local playerHeightFactor = LabeledSlider("Player height factor", state.playerHeightFactor, -1, 1, 0.05)
    playerHeightFactor.container:SetParent(self.container)
    playerHeightFactor.container:SetPoint("TOPLEFT", playerTargetDistance.slider, "BOTTOMLEFT", 0, -10)

    local playerAnimation = LabeledSlider("Player animation", state.playerAnimation, 0, 300, 1)
    playerAnimation.container:SetParent(self.container)
    playerAnimation.container:SetPoint("TOPLEFT", playerHeightFactor.slider, "BOTTOMLEFT", 0, -10)

    local targetCamera = LabeledSlider("Target camera", state.targetCamera, 1, 5, 0.05)
    targetCamera.container:SetParent(self.container)
    targetCamera.container:SetPoint("TOPLEFT", playerAnimation.slider, "BOTTOMLEFT", 0, -20)

    local targetFacing = LabeledSlider("Target facing", state.targetFacing, -3, 3, 0.1)
    targetFacing.container:SetParent(self.container)
    targetFacing.container:SetPoint("TOPLEFT", targetCamera.slider, "BOTTOMLEFT", 0, -10)

    local targetTargetDistance = LabeledSlider("Target target distance", state.targetTargetDistance, -1, 1, 0.01)
    targetTargetDistance.container:SetParent(self.container)
    targetTargetDistance.container:SetPoint("TOPLEFT", targetFacing.slider, "BOTTOMLEFT", 0, -10)

    local targetHeightFactor = LabeledSlider("Target height factor", state.targetHeightFactor, -1, 1, 0.05)
    targetHeightFactor.container:SetParent(self.container)
    targetHeightFactor.container:SetPoint("TOPLEFT", targetTargetDistance.slider, "BOTTOMLEFT", 0, -10)

    local targetAnimation = LabeledSlider("Target animation", state.targetAnimation, 0, 300, 1)
    targetAnimation.container:SetParent(self.container)
    targetAnimation.container:SetPoint("TOPLEFT", targetHeightFactor.slider, "BOTTOMLEFT", 0, -10)
end

return DebugView