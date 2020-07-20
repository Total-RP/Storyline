local Class = require "Libraries.Self"
local U = require "Utils"

---@class BackgroundView
local BackgroundView = Class("BackgroundView")

---@param actions Storyline_Actions
function BackgroundView:new(actions)
    self.frame = U.CreateFrame()
    self:CreateTilingTexture(actions)
end

function BackgroundView:CreateTilingTexture()
    self.frame.backgroundTile = self.frame:CreateTexture()
    self.frame.backgroundTile:SetDrawLayer("BACKGROUND", -1)
    self.frame.backgroundTile:SetAllPoints(self.frame)
    self.frame.backgroundTile:SetHorizTile(true)
    self.frame.backgroundTile:SetVertTile(true)
end

---@param actions Storyline_Actions
function BackgroundView:CreateFixedRatioTexture(actions)
    self.frame.fixedRatioBackground = self.frame:CreateTexture()
    self.frame.fixedRatioBackground:SetDrawLayer("BACKGROUND", 1)
    self.frame.fixedRatioBackground:SetAllPoints(self.frame)
    self.frame.fixedRatioBackground:SetPoint("TOP")
    self.frame.fixedRatioBackground:SetPoint("BOTTOM")
    self.frame.fixedRatioBackground = 16 / 9

    actions.WINDOW_RESIZING:subscribe(function()
        self.frame.fixedRatioBackground:SetWidth(self.frame.fixedRatioBackground:GetHeight() * self.frame.fixedRatioBackground)
    end)
end

return BackgroundView