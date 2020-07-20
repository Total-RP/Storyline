local Class = require "Libraries.Self"
local U = require "Utils"

---@class Storyline_Model
local Model = Class("Model")

---@param state Storyline_State
function Model:new(camera, facing, distance, height, animation)
    ---@type CinematicModel
    self.model = CreateFrame("CinematicModel")

    camera
        :map(U.First(self.model))
        :subscribe(self.model.InitializeCamera)

    facing
        :map(U.First(self.model))
        :subscribe(self.model.SetFacing)

    distance
        :map(U.First(self.model))
        :subscribe(self.model.SetTargetDistance)

    height
        :map(U.First(self.model))
        :subscribe(self.model.SetHeightFactor)

    animation
        :map(U.First(self.model))
        :subscribe(self.model.SetAnimation)
end

function Model:SetUnit(unitId)
    self.model:SetUnit(unitId)
end

return Model