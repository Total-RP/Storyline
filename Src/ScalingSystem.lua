local ScalingSystem = {}
local DEFAULT_PROPERTIES = {
	height = 1.45,
	feetPositions = 0.4,
	offset = 0.215,
	facing = 0.75
};

local heights = {}
local facings = {}
local offsets = {}
local feetPositions = {}

function ScalingSystem.getModelFacing(modelId)
	return facings[modelId] or DEFAULT_PROPERTIES.facing
end

function ScalingSystem.getModelHeight(modelId)
	return heights[modelId] or DEFAULT_PROPERTIES.height
end

function ScalingSystem.getModelOffset(modelId)
	return offsets[modelId] or DEFAULT_PROPERTIES.offset
end

function ScalingSystem.getModelFeetPosition(modelId)
	return feetPositions[modelId] or DEFAULT_PROPERTIES.feetPosition
end

return ScalingSystem