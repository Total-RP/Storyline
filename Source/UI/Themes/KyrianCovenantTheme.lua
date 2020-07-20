local Class = require "Libraries.Self"
local Theme = require "UI.Themes.Theme"

---@class KyrianCovenantTheme: Theme
local KyrianCovenantTheme = Class("KyrianCovenantTheme", Theme)

local backgroundTextureKitRegions = {
    ["backgroundTile"] = "UI-Frame-%s-BackgroundTile",
};

---@param mainView MainView
function KyrianCovenantTheme:ApplyOn(mainView)

    -- BorderFrame anchors
    mainView.borderFrame:ClearAllPoints()
    mainView.borderFrame:SetPoint("TOPLEFT", -6, 6)
    mainView.borderFrame:SetPoint("BOTTOMRIGHT", 6, -6)

    -- CloseButton anchor
    mainView.closeButton.button:ClearAllPoints()
    mainView.closeButton.button:SetPoint("TOPRIGHT", 3, 2)

    -- Resize button
    mainView.resizeButton.button:ClearAllPoints()
    mainView.resizeButton.button:SetPoint("BOTTOMRIGHT", 3, -2)

    -- Use NineSliceUtil to apply border textures
    NineSliceUtil.ApplyUniqueCornersLayout(mainView.borderFrame, "Kyrian")

    -- Apply tiled background texture
    SetupTextureKitOnRegions("Kyrian", mainView.backgroundView.frame, backgroundTextureKitRegions, TextureKitConstants.SetVisibility, TextureKitConstants.UseAtlasSize);
end

return KyrianCovenantTheme