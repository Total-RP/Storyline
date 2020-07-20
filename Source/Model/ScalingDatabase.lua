local Class = require "Libraries.Self"

---@class ScalingDatabase
local ScalingDatabase = Class("ScalingDatabase")

---@param state Storyline_State
---@param storage SavedVariablesStorage
function ScalingDatabase:new(state, storage)
    storage:PersistSubject(state.playerCamera, "PLAYER_CAMERA")
    storage:PersistSubject(state.playerFacing, "PLAYER_FACING")
    storage:PersistSubject(state.playerTargetDistance, "PLAYER_TARGET_DISTANCE")
    storage:PersistSubject(state.playerHeightFactor, "PLAYER_HEIGHT_FACTOR")
    storage:PersistSubject(state.targetCamera, "TARGET_CAMERA")
    storage:PersistSubject(state.targetFacing, "TARGET_FACING")
    storage:PersistSubject(state.targetTargetDistance, "TARGET_TARGET_DISTANCE")
    storage:PersistSubject(state.targetHeightFactor, "TARGET_HEIGHT_FACTOR")
end



return ScalingDatabase