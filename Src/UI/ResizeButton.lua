local Button = require "Libraries.Ellyb.Src.UI.Widgets.Button"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Rx = require "Libraries.Ellyb.Src.Libraries.RxLua.rx"

---@class ResizeButton: Ellyb_Button
local ResizeButton = Class("ResizeButton", Button)

function ResizeButton:initialize(resizeableFrame)
    self.super.initialize(self)

    self:SetNormalTexture([[Interface\Buttons\UI-Panel-SmallerButton-Up]])
    self:GetNormalTexture():SetTexCoord(1, 0, 0, 1)
    self:SetPushedTexture([[Interface\Buttons\UI-Panel-SmallerButton-Down]])
    self:GetPushedTexture():SetTexCoord(1, 0, 0, 1)
    self:SetDisabledTexture([[Interface\Buttons\UI-Panel-SmallerButton-Disabled]])
    self:GetDisabledTexture():SetTexCoord(1, 0, 0, 1)
    self:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]], "ADD")
    self:GetHighlightTexture():SetTexCoord(1, 0, 0, 1)

    self:RegisterForDrag("LeftButton");

    resizeableFrame:SetResizable(true)
    resizeableFrame:SetClampedToScreen(true)

    self.rx.OnResize = Rx.Subject.create()

    self.rx.OnEnter
        :map(function() return "UI_MOVE_CURSOR" end)
        :subscribe(SetCursor)

    self.rx.OnLeave:subscribe(ResetCursor)

    local isResizing = false
    self.rx.OnDragStart:subscribe(function()
        resizeableFrame:StartSizing()
        isResizing = true
    end)

    self.rx.OnUpdate:subscribe(function()
        if isResizing then
            self.rx.OnResize()
        end
    end)

    self.rx.OnDragStop:subscribe(function()
        resizeableFrame:StopMovingOrSizing()
        isResizing = false
    end)

    self.rx.OnEnter:subscribe(function()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 5, 0)
        GameTooltip:SetText("Resize")
        GameTooltip:Show()
    end)

    self.rx.OnLeave:subscribe(function()
        GameTooltip:Hide()
    end)
end

return ResizeButton