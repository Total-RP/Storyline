local Ellyb = Ellyb(...);

local After = C_Timer.After;
local animationLib = LibStub:GetLibrary("TRP-Dialog-Animation-DB");

---@class Storyline_PlayerModelMixin : CinematicModel
Storyline_PlayerModelMixin = {};

function Storyline_PlayerModelMixin:OnLoad()
	self.isModelLoaded = false;

	self.idleAnimationID = 0;
	self.bindedPlayNextAnimation = Ellyb.Functions.bind(self.PlayNextAnimation, self);
end

function Storyline_PlayerModelMixin:OnModelLoaded()
	self.isModelLoaded = true;
	self.displayedModel = self:GetModelFileID();
	self:ModelLoaded();
end

--[[ Override ]] function Storyline_PlayerModelMixin:ModelLoaded()
end

function Storyline_PlayerModelMixin:SetModelUnit(unit, animateIntoPosition)
	self.displayedModel = nil;
	if unit == "none" then
		return
	end
	self.isModelLoaded = false;
	self:SetUnit(unit, animateIntoPosition);
end

--- Play a single animation on the model
---@param animationID number @ A valid animation ID
function Storyline_PlayerModelMixin:PlayAnimation(animationID)
	self:PlayAnimSequence({ animationID });
end

function Storyline_PlayerModelMixin:PlayAnimSequence(sequence)
	self.sequence = sequence;
	self.sequenceIndex = 1;
	self.playingInterstice = true;
	self:PlayNextAnimation();
end

function Storyline_PlayerModelMixin:PlayNextAnimation()
	if not self.playingInterstice then
		self:SetAnimation(self.idleAnimationID);
		After(0.5, self.bindedPlayNextAnimation);
		self.playingInterstice = true;
	else
		self.playingInterstice = false;
		self:SetAnimation(animationLib:GetCorrectAnim(self, self.sequence[self.sequenceIndex]));
		self.sequenceIndex = self.sequenceIndex + 1;
	end
end

function Storyline_PlayerModelMixin:OnAnimFinished(...)
	if not self.sequence or not self.sequenceIndex then
		return
	end
	if self.sequenceIndex > #self.sequence then
		self:SetAnimation(self.idleAnimationID);
	else
		self:PlayNextAnimation();
	end
end

--- TODO This will go once we have the superior scaling model, no need for string
function Storyline_PlayerModelMixin:GetModelFileIDAsString()
	return self.displayedModel and tostring(self.displayedModel);
end