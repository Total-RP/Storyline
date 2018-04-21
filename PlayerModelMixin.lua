local Ellyb = Ellyb(...);

local After = C_Timer.After;
local pop = table.remove;
local ANIMATIONS = Storyline_API.ANIMATIONS;

---@class Storyline_PlayerModelMixin : CinematicModel
Storyline_PlayerModelMixin = {};

function Storyline_PlayerModelMixin:OnLoad()
	self.isModelLoaded = false;

	-- Default idle animation is standing
	self.idleAnimationID = ANIMATIONS.STANDING;

	-- Create a callback-able function of the OnAnimFinished method bound to self, so we can call it manually
	self.bindedOnAnimFinished = Ellyb.Functions.bind(self.OnAnimFinished, self);
end

function Storyline_PlayerModelMixin:OnModelLoaded()
	self.isModelLoaded = true;

	-- Save the displayed model ID as we will use it later
	self.displayedModel = self:GetModelFileID();

	-- Call the ModelLoaded method to execute a custom callback
	self:ModelLoaded();
end

--- This function is called when the model is loaded. Override to use custom callback
--- TODO We probably can remove this once we have the new scaling system
--[[ Override ]] function Storyline_PlayerModelMixin:ModelLoaded()
end

--- Set a custom idle animation to return to when all animations are finished.
--- The model will be checked to see if it supports the animation.
---@param animationID number @ A valid animation ID
function Storyline_PlayerModelMixin:SetCustomIdleAnimationID(animationID)
	if self:HasAnimation(animationID) then
		self.idleAnimationID = animationID;
	end
end

function Storyline_PlayerModelMixin:ResetIdleAnimationID()
	self.idleAnimationID = ANIMATIONS.STANDING;
end

function Storyline_PlayerModelMixin:ResetModel()
	-- Reset the displayed model ID
	self.displayedModel = nil;
	-- Model is no longer loaded
	self.isModelLoaded = false;
end

function Storyline_PlayerModelMixin:SetModelUnit(unit, animateIntoPosition)
	self:ResetModel();
	self:SetUnit(unit, animateIntoPosition);
end

--- Check the model for a speaking (".", "?" or "!") animation and returns a valid animation that the model can play
--- Non speaking animation will be ignored.
---@param animationID number @ An speaking animation ID to check and replace for one that the model can actually play
function Storyline_PlayerModelMixin:GetValidSpeakingAnimation(animationID)
	-- If the animation is a question and the model don't support it, fallback to exclamation
	if animationID == ANIMATIONS.QUESTION and not self:HasAnimation(animationID) then
		animationID = ANIMATIONS.EXCLAMATION;
	end
	-- If the animation is an exclamation and the model don't support it, fallback to a normal sentence
	if animationID == ANIMATIONS.EXCLAMATION and not self:HasAnimation(animationID) then
		animationID = ANIMATIONS.TALK;
	end
	return animationID
end

--- Play a single animation on the model
---@param animationID number @ A valid animation ID
function Storyline_PlayerModelMixin:PlayAnimation(animationID)
	assert(animationID ~= nil, "Storyline_PlayerModelMixin:PlayAnimation(animationID) cannot play an empty animation. Use Storyline_PlayerModelMixin:PlayIdleAnimation() instead.");

	self:PlayAnimSequence({ animationID });
end

--- Play the idle animation (default is standing)
function Storyline_PlayerModelMixin:PlayIdleAnimation()
	self:SetAnimation(self.idleAnimationID);
end

--- Play a sequence of animation IDs
---@param sequence number[] @ A table of animation IDs
function Storyline_PlayerModelMixin:PlayAnimSequence(sequence)
	assert(#sequence > 0, "Storyline_PlayerModelMixin:PlayAnimSequence(sequence) cannot play an empty animation sequence. Use Storyline_PlayerModelMixin:PlayIdleAnimation() instead.");

	-- Save the sequence table
	self.sequence = sequence;
	-- isPlayingIntersticeAnimation is true so next animation is one of the sequence
	self.isPlayingIntersticeAnimation = true;
	-- We are now playing an animation sequence
	self.isPlayingAnimationSequence = true;
	-- Play the next available animation
	self:PlayNextAnimation();
end

--- Play the next animation available in the current sequence
function Storyline_PlayerModelMixin:PlayNextAnimation()
	-- If we were not playing an interstice animation before, we insert one
	if not self.isPlayingIntersticeAnimation then
		-- We are now playing an interstice animation
		self.isPlayingIntersticeAnimation = true;
		-- The interstice animation play the idle animation for half a second
		-- so the animations don't look all chained together
		self:PlayIdleAnimation();
		-- After half a second, manually fire OnAnimFinished
		-- TODO fix risk of racing issue here if the idle animation doesn't exist and OnAnimFinished is executed right away
		After(0.5, self.bindedOnAnimFinished);

	else
		-- We are no longer playing an interstice animation
		self.isPlayingIntersticeAnimation = false;

		-- Pop the next animation from the sequence table
		local nextAnimation = pop(self.sequence, 1);
		-- Get a valid speaking animation (non speaking animation are ignored)
		nextAnimation = self:GetValidSpeakingAnimation(nextAnimation);

		self:SetAnimation(nextAnimation);
	end
end

function Storyline_PlayerModelMixin:OnAnimFinished()
	-- Do not do anything if we are not currently playing a animation sequence
	if not self.isPlayingAnimationSequence then
		return
	end

	-- If we still have animation available in the sequence, play the next animation
	if #self.sequence > 0 then
		self:PlayNextAnimation();
	else
		-- If the sequence is empty, set isPlayingAnimationSequence to false and play idle animation
		self.isPlayingAnimationSequence = false;
		self:PlayIdleAnimation();
	end
end

--- TODO This will go once we have the superior scaling model, no need for string
function Storyline_PlayerModelMixin:GetModelFileIDAsString()
	return self.displayedModel and tostring(self.displayedModel);
end