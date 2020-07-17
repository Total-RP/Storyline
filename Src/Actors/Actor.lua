local Model = require "Libraries.Ellyb.Src.UI.Widgets.CinematicModel"
local Class = require "Libraries.Ellyb.Src.Libraries.middleclass"
local Functions = require "Libraries.Ellyb.Src.Tools.Functions"
local ScalingSystem = require "ScalingSystem"

---@class Actor: Ellyb_CinematicModel
local Actor = Class("Actor", Model)

function Actor:initialize(name)
    Model.initialize(self)
    self.isModelDisplayedOnLeft = false

    local onModelIdChanged = self.rx.OnModelLoaded:map(Functions.bind(self.GetModelFileID, self))

    -- Update model height
    onModelIdChanged
        :map(ScalingSystem.getModelHeight)
        :bindTo(self.rx.InitializeCamera)

    -- Update model facing
    onModelIdChanged
        :map(ScalingSystem.getModelFacing)
        :map(function(facing)
            -- Swap facing from right to left depending on the model position
            return facing * (self.isModelDisplayedOnLeft and 1 or -1)
        end)
        :bindTo(self.rx.SetFacing)

    -- Update model feet position
    onModelIdChanged
        :map(ScalingSystem.getModelFeetPosition)
        :bindTo(self.rx.SetHeightFactor)

    -- Update model offset
    onModelIdChanged
        :map(ScalingSystem.getModelOffset)
        :map(function(offset)
            -- Swap offset from right to left depending on the model position
            return offset * (self.isModelDisplayedOnLeft and 1 or -1)
        end)
        :bindTo(self.rx.SetTargetDistance)
end

return Actor