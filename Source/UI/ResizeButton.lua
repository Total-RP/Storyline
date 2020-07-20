local Class = require "Self"
local U = require "Utils"
local Rx = require "Libraries.WoWRx"

local ResizeButton = Class("ResizeButton")

function ResizeButton:new(resizeableFrame, actions)
    self.isResizing = Rx.BehaviorSubject.create(false)
    self:SetupButton()
    self:MakeFrameResizeable(resizeableFrame)
    self:SetupScripts(resizeableFrame, actions)
end

function ResizeButton:SetupButton()
    self.button = U.CreateButton()
    self.button:SetSize(32, 32)
    self.button:SetNormalTexture([[Interface\Buttons\UI-Panel-SmallerButton-Up]])
    self.button:GetNormalTexture():SetTexCoord(1, 0, 0, 1)
    self.button:SetPushedTexture([[Interface\Buttons\UI-Panel-SmallerButton-Down]])
    self.button:GetPushedTexture():SetTexCoord(1, 0, 0, 1)
    self.button:SetDisabledTexture([[Interface\Buttons\UI-Panel-SmallerButton-Disabled]])
    self.button:GetDisabledTexture():SetTexCoord(1, 0, 0, 1)
    self.button:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]], "ADD")
    self.button:GetHighlightTexture():SetTexCoord(1, 0, 0, 1)
    self.button:RegisterForDrag("LeftButton")
end

function ResizeButton:SetupScripts(resizeableFrame, actions)

    -- Show tooltip when the cursor enters the button boundaries
    Rx.Script(self.button, "OnEnter")
      :mapTo(self)
      :subscribe(self.ShowTooltip)

    -- Hide tooltip when cursor leaves the button boundaries
    Rx.Script(self.button, "OnLeave")
      :mapTo(self)
      :subscribe(self.HideTooltip)

    -- Start resizing when drag starts
    Rx.Script(self.button, "OnDragStart")
      :mapTo(self, resizeableFrame)
      :subscribe(self.StartResizing)

    -- Stop resizing when drag stops
    Rx.Script(self.button, "OnDragStop")
      :mapTo(self, resizeableFrame)
      :subscribe(self.StopResizing)

    -- Send Events.WINDOW_RESIZING every 0.3 while resizing
    Rx.Timer(0.3)
        :combineLatest(self.isResizing)
        :map(U.TakeNth(2))
        :filter(U.IsTrue)
        :bindTo(actions.WINDOW_RESIZING)
end

function ResizeButton:MakeFrameResizeable(resizeableFrame)
    resizeableFrame:SetResizable(true)
    resizeableFrame:SetClampedToScreen(true)
end

function ResizeButton:StartResizing(resizeableFrame)
    resizeableFrame:StartSizing()
    self.isResizing(true)
end

function ResizeButton:StopResizing(resizeableFrame)
    resizeableFrame:StopMovingOrSizing()
    self.isResizing(false)
end

function ResizeButton:OnEnter()
    self:ShowTooltip()
end

function ResizeButton:ShowTooltip()
    GameTooltip:SetOwner(self.button, "ANCHOR_RIGHT", 5, 0)
    GameTooltip:SetText("Resize")
    GameTooltip:Show()
end

function ResizeButton:HideTooltip()
    GameTooltip:Hide()
end

return ResizeButton