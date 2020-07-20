local Class = require "Libraries.Self"

---@class Theme
local Theme = Class("Theme")

function Theme:new()
end

---@param mainView MainView
function Theme:ApplyOn(mainView)
    error("Override this method.")
end

return Theme