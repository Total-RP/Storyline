local Actor = require "Actors.Actor"
local GameEvents = require "GameEvents"
local U = require "Utils.Utils"

local playerActor = Actor("Player")

playerActor.isModelDisplayedOnLeft = true

GameEvents.UNIT_MODEL_CHANGED
		  :filter(U.Is("player"))
		  :mapTo("player")
		  :bindTo(playerActor.rx.SetUnit)


return playerActor