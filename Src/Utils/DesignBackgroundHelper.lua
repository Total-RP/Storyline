local Frame = require "Libraries.Ellyb.Src.UI.Widgets.Frame"

local DesignBackgroundHelper = Frame()
DesignBackgroundHelper:SetParent(UIParent)
DesignBackgroundHelper:SetAllPoints(UIParent)


local Background = DesignBackgroundHelper:CreateTexture()
Background:SetColorTexture(0.5, 0.5, 0.5, 1)
Background:SetAllPoints(DesignBackgroundHelper)

DesignBackgroundHelper:Hide()

return DesignBackgroundHelper