local Actions = require "Actions"
local State = require "State"
local MainView = require "UI.MainView"
local KyrianCovenantTheme = require "UI.Themes.KyrianCovenantTheme"
local GameEventsController = require "Controllers.GameEventsController"
local DialogController = require "Controllers.DialogController"

local state = State()
local actions = Actions()
local mainView = MainView(state, actions)
local theme = KyrianCovenantTheme()
theme:ApplyOn(mainView)

local questDialogController = GameEventsController(state, actions)
local dialogController = DialogController(state, actions)

actions.WINDOW_CLOSE()