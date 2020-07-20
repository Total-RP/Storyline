local Class = require "Libraries.Self"
local Theme = require "UI.Themes.Theme"

---@class ElvUIesqueTheme: Theme
local ElvUIesqueTheme = Class("ElvUIesqueTheme", Theme)

function ElvUIesqueTheme:new()
end

---@param mainView MainView
function ElvUIesqueTheme:ApplyOn(mainView)
    mainView.backgroundView.frame.backgroundTile:SetColorTexture(0.1, 0.1, 0.1)
end

return ElvUIesqueTheme