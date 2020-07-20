local Class = require "Libraries.Self"

---@class Portrait
local Portrait = Class("Portrait")

function Portrait:new(name, text, portraitDisplayID, mountPortraitDisplayID)
    self.name = name
    self.text = text
    self.portraitDisplayID = portraitDisplayID
    self.mountPortraitDisplayID = mountPortraitDisplayID
end

return Portrait