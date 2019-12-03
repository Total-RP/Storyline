local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Frame = require "Libraries.Ellyb.Src.UI.Widgets.Frame"

---@class ParchmentFrame: Ellyb_Frame
local ParchmentFrame = Class("self", Frame)

function ParchmentFrame:initialize()
    self.super.initialize(self)

    --region Corners

    local TopLeftCorner = self:CreateTexture()
    TopLeftCorner:SetSize(209, 158)
    TopLeftCorner:SetTexture([[Interface\QuestionFrame\Question-Main]])
    TopLeftCorner:SetTexCoord(0.00195313, 0.41015625, 0.61718750, 0.92578125)
    TopLeftCorner:SetPoint("TOPLEFT", self, "TOPLEFT")
    TopLeftCorner:SetDrawLayer("BORDER")

    local TopRightCorner = self:CreateTexture()
    TopRightCorner:SetSize(209, 158)
    TopRightCorner:SetTexture([[Interface\QuestionFrame\Question-Main]])
    TopRightCorner:SetTexCoord(0.41406250, 0.82031250, 0.61718750, 0.92578125)
    TopRightCorner:SetPoint("TOPRIGHT", self, "TOPRIGHT")
    TopRightCorner:SetDrawLayer("BORDER")

    local BottomRightCorner = self:CreateTexture()
    BottomRightCorner:SetSize(209, 158)
    BottomRightCorner:SetTexture([[Interface\QuestionFrame\Question-Main]])
    BottomRightCorner:SetTexCoord(0.41406250, 0.82226563, 0.30468750, 0.61328125)
    BottomRightCorner:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 1, 0)
    BottomRightCorner:SetDrawLayer("BORDER")

    local BottomLeftCorner = self:CreateTexture()
    BottomLeftCorner:SetSize(209, 158)
    BottomLeftCorner:SetTexture([[Interface\QuestionFrame\Question-Main]])
    BottomLeftCorner:SetTexCoord(0.00195313, 0.41015625, 0.30468750, 0.61328125)
    BottomLeftCorner:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
    BottomLeftCorner:SetDrawLayer("BORDER")

    --endregion

    --region Borders

    local TopBorder = self:CreateTexture()
    TopBorder:SetHeight(91)
    TopBorder:SetTexture([[Interface\QuestionFrame\Question-HTile]], true, false)
    TopBorder:SetHorizTile(true)
    TopBorder:SetTexCoord(0, 1, 0.34375000, 0.52148438)
    TopBorder:SetPoint("TOPLEFT", TopLeftCorner, "TOPRIGHT", 0, -2)
    TopBorder:SetPoint("TOPRIGHT", TopRightCorner, "TOPLEFT", 0, -2)
    TopBorder:SetDrawLayer("BORDER", -1)

    local BottomBorder = self:CreateTexture()
    BottomBorder:SetHeight(86)
    BottomBorder:SetTexture([[Interface\QuestionFrame\Question-HTile]], true, false)
    BottomBorder:SetHorizTile(true)
    BottomBorder:SetTexCoord(0, 1, 0.17187500, 0.33984375)
    BottomBorder:SetPoint("BOTTOMRIGHT", BottomRightCorner, "BOTTOMLEFT", 0, 2)
    BottomBorder:SetPoint("BOTTOMLEFT", BottomLeftCorner, "BOTTOMRIGHT", 0, 2)
    BottomBorder:SetDrawLayer("BORDER", -1)

    local LeftBorder = self:CreateTexture()
    LeftBorder:SetWidth(93)
    LeftBorder:SetTexture([[Interface\QuestionFrame\Question-Vtile]], false, true)
    LeftBorder:SetVertTile(true)
    LeftBorder:SetTexCoord(0.00390625, 0.36718750, 0, 1)
    LeftBorder:SetPoint("TOPLEFT", TopLeftCorner, "BOTTOMLEFT", 2, 0)
    LeftBorder:SetPoint("BOTTOMLEFT", BottomLeftCorner, "TOPLEFT", 2, 0)
    LeftBorder:SetDrawLayer("BORDER", -1)

    local RightBorder = self:CreateTexture()
    RightBorder:SetWidth(94)
    RightBorder:SetTexture([[Interface\QuestionFrame\Question-Vtile]], false, true)
    RightBorder:SetVertTile(true)
    RightBorder:SetTexCoord(0.37500000, 0.74218750, 0, 1)
    RightBorder:SetPoint("TOPRIGHT", TopRightCorner, "BOTTOMRIGHT")
    RightBorder:SetPoint("BOTTOMRIGHT", BottomRightCorner, "TOPRIGHT")
    RightBorder:SetDrawLayer("BORDER", -1)

    --endregion

    --region Seems hiders

    local LeftTopHide = self:CreateTexture()
    LeftTopHide:SetDrawLayer("BORDER", 2)
    LeftTopHide:SetSize(86, 39)
    LeftTopHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    LeftTopHide:SetTexCoord(0.59765625, 0.76562500, 0.00195313, 0.07812500)
    LeftTopHide:SetPoint("TOPLEFT", TopLeftCorner, "BOTTOMLEFT", 10, 10)

    local LeftBottomHide = self:CreateTexture()
    LeftBottomHide:SetDrawLayer("BORDER", 2)
    LeftBottomHide:SetSize(86, 39)
    LeftBottomHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    LeftBottomHide:SetTexCoord(0.59765625, 0.76562500, 0.00195313, 0.07812500)
    LeftBottomHide:SetPoint("BOTTOMLEFT", BottomLeftCorner, "TOPLEFT", 10, -10)

    local RightTopHide = self:CreateTexture()
    RightTopHide:SetDrawLayer("BORDER", 2)
    RightTopHide:SetSize(61, 32)
    RightTopHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    RightTopHide:SetTexCoord(0.76953125, 0.88867188, 0.00195313, 0.06445313)
    RightTopHide:SetPoint("TOPRIGHT", TopRightCorner, "BOTTOMRIGHT", -9, 8)

    local RightBottomHide = self:CreateTexture()
    RightBottomHide:SetDrawLayer("BORDER", 2)
    RightBottomHide:SetSize(61, 32)
    RightBottomHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    RightBottomHide:SetTexCoord(0.76953125, 0.88867188, 0.00195313, 0.06445313)
    RightBottomHide:SetPoint("BOTTOMRIGHT", BottomRightCorner, "TOPRIGHT", -10, -10)

    local BottomRightHide = self:CreateTexture()
    BottomRightHide:SetDrawLayer("BORDER", 2)
    BottomRightHide:SetSize(33, 90)
    BottomRightHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    BottomRightHide:SetTexCoord(0.82617188, 0.89062500, 0.30468750, 0.48046875)
    BottomRightHide:SetPoint("BOTTOMLEFT", BottomLeftCorner, "BOTTOMRIGHT", -10, 11)

    local BottomLeftHide = self:CreateTexture()
    BottomLeftHide:SetDrawLayer("BORDER", 2)
    BottomLeftHide:SetSize(33, 90)
    BottomLeftHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    BottomLeftHide:SetTexCoord(0.82617188, 0.89062500, 0.30468750, 0.48046875)
    BottomLeftHide:SetPoint("BOTTOMRIGHT", BottomRightCorner, "BOTTOMLEFT", 15, 11)

    local TopRightHide = self:CreateTexture()
    TopRightHide:SetDrawLayer("BORDER", 2)
    TopRightHide:SetSize(33, 66)
    TopRightHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    TopRightHide:SetTexCoord(0.89257813, 0.95703125, 0.00195313, 0.13085938)
    TopRightHide:SetPoint("TOPLEFT", TopLeftCorner, "TOPRIGHT", -10, -10)

    local TopLeftHide = self:CreateTexture()
    TopLeftHide:SetDrawLayer("BORDER", 2)
    TopLeftHide:SetSize(33, 66)
    TopLeftHide:SetTexture([[Interface\QuestionFrame\Question-Main]])
    TopLeftHide:SetTexCoord(0.89257813, 0.95703125, 0.00195313, 0.13085938)
    TopLeftHide:SetPoint("TOPRIGHT", TopRightCorner, "TOPLEFT", 15, -10)

    --endregion

    --region Background

    local Background = self:CreateTexture()
    Background:SetDrawLayer("BACKGROUND")
    Background:SetTexture([[Interface\QuestionFrame\question-background]], true, true)
    Background:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -20)
    Background:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -20, 20)
    Background:SetHorizTile(true)
    Background:SetVertTile(true)
    Background:SetVertexColor(0.7, 0.7, 0.7, 1)

    --endregion

end

return ParchmentFrame