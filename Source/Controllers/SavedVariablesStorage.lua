local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local U = require "Utils"

---@class SavedVariablesStorage
local SavedVariablesStorage = Class("SavedVariablesStorage")

local addonLoaded = Rx.Event("ADDON_LOADED"):filter(U.Is("Storyline"))

---@param savedVariableName string
function SavedVariablesStorage:new(savedVariableName)
    self.savedVariableName = savedVariableName
    if not _G[savedVariableName] then
        _G[savedVariableName] = {}
    end
end

---@param subject Subject
---@param key string
function SavedVariablesStorage:PersistSubject(subject, key)
    if _G[self.savedVariableName][key] ~= nil then
        subject(_G[self.savedVariableName][key])
    end

    subject:subscribe(function(value)
        _G[self.savedVariableName][key] = value
    end)

    addonLoaded:map(function() return _G[self.savedVariableName][key] end)
      :filter(U.Not(U.IsNil))
      :bindTo(subject)
end

return SavedVariablesStorage