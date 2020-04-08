local Button = require "Libraries.Ellyb.Src.UI.Widgets.Button"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"


---@class CloseButton: Ellyb_Button
local CloseButton = Class("CloseButton", Button)

function CloseButton:initialize(closableFrame)
    self.super.initialize(self)

    self:SetNormalTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
    self:SetPushedTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
    self:SetDisabledTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Disabled]])
    self:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]], "ADD")

    self:RegisterForDrag("LeftButton");

    resizeableFrame:SetResizable(true)
    resizeableFrame:SetClampedToScreen(true)

   self.rx.OnClick:subscribe(function()
       closableFrame:Hide()
   end)
end


return CloseButton