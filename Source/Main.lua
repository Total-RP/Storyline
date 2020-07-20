local Actions = require "Actions"
local State = require "State"
local MainView = require "UI.MainView"
local KyrianCovenantTheme = require "UI.Themes.KyrianCovenantTheme"
local GameEventsController = require "Controllers.GameEventsController"
local DialogController = require "Controllers.DialogController"
local ScalingDatabase = require "Model.ScalingDatabase"
local SavedVariablesStorage = require "Controllers.SavedVariablesStorage"
local Rx = require "Libraries.WoWRx"
local U = require "Utils"

local storage = SavedVariablesStorage("Storyline_Data")
local state = State()
local actions = Actions()

Rx.Event("ADDON_LOADED")
    :filter(U.Is("Storyline"))
    :subscribe(function()
    local mainView = MainView(state, actions, storage)
    local theme = KyrianCovenantTheme()
    theme:ApplyOn(mainView)

    local scalingDatabase = ScalingDatabase(state, storage)
    local questDialogController = GameEventsController(state, actions)
    local dialogController = DialogController(state, actions)

    actions.WINDOW_CLOSE()
end)


