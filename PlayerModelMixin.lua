local Ellyb = Ellyb(...);

local Promise = Ellyb.Promise;
local After = C_Timer.After;
local pop = table.remove;
local GetTime = GetTime;
local ANIMATIONS = Storyline_API.ANIMATIONS;

local TRPDialogAnimationDB = LibStub:GetLibrary("TRP-Dialog-Animation-DB");

local DEFAULT_PROPERTIES = {
	scale = 1.45,
	feet = 0.4,
	offset = 0.215,
	facing = 0.75
};

-- These models have incorrect animation timings and doesn't render correctly with this system
local MODELS_WITH_BROKEN_ANIMATIONS = {
	2173915, -- Male Kul'tirans
	1721003, -- Male Kul'tirans
}

local MANUALLY_ANIMATED_MODELS = {
	120791, -- Classic night elf male
	120590, -- Classic night elf female
}

---@class Storyline_PlayerModelMixin : CinematicModel
Storyline_PlayerModelMixin = {};

function Storyline_PlayerModelMixin:OnLoad()
	-- Default idle animation is standing
	self.idleAnimationID = ANIMATIONS.STANDING;

	-- Create a callback-able function of the OnAnimFinished method bound to self, so we can call it manually
	self.bindedOnAnimFinished = Ellyb.Functions.bind(self.OnAnimFinished, self);
	self.boundSetModelHeight = Ellyb.Functions.bind(self.SetModelHeight, self);
	self.boundSetModelOffset = Ellyb.Functions.bind(self.SetModelOffset, self);
	self.boundSetModelFeet = Ellyb.Functions.bind(self.SetModelFeet, self);

	self.modelHeightTransitionator = Ellyb.Transitionator();
	self.modelFeetTransitionator = Ellyb.Transitionator();
	self.modelOffsetTransitionator = Ellyb.Transitionator();
	self.isModelDisplayedOnLeft = true;
end

function Storyline_PlayerModelMixin:OnModelLoaded()
	-- Save the displayed model ID as we will use it later
	self.displayedModel = self:GetModelFileID();

	self.modelLoadedPromise:Resolve(self.displayedModel);
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

---@return Promise modelLoadingPromise
function Storyline_PlayerModelMixin:SetModelUnit(unit, animateIntoPosition)
	self:ResetModel();
	self.modelLoadedPromise = Promise();
	self:SetUnit(unit, animateIntoPosition);

	if unit == "none" then
		self.modelLoadedPromise:Resolve();
	end

	return self.modelLoadedPromise;
end

function Storyline_PlayerModelMixin:RequiresManualAnimationTiming()
	return tContains(MANUALLY_ANIMATED_MODELS, self:GetModelFileID())
end

function Storyline_PlayerModelMixin:DisplayDead()
	-- Pick a dead animation. Some NPC only has stand and dead, so dead is actually the ID 1, because Blizzard.
	local deadAnimation = self:HasAnimation(ANIMATIONS.DEAD) or 1;
	-- Freeze the dead animation on the last frame
	self:FreezeAnimation(deadAnimation, nil, -1)
end

--- Check the model for a speaking (".", "?" or "!") animation and returns a valid animation that the model can play
--- Non speaking animation will be ignored.
---@param animationID number @ An speaking animation ID to check and replace for one that the model can actually play
function Storyline_PlayerModelMixin:GetValidSpeakingAnimation(animationID)

	if tContains(MODELS_WITH_BROKEN_ANIMATIONS, self:GetModelFileID()) then
		return ANIMATIONS.STANDING
	end

	-- If the animation is a question and the model don't support it, fallback to exclamation
	if animationID == ANIMATIONS.QUESTION and not self:HasAnimation(animationID) then
		animationID = ANIMATIONS.EXCLAMATION;
	end
	-- If the animation is an exclamation and the model don't support it, fallback to a normal sentence
	if animationID == ANIMATIONS.EXCLAMATION and not self:HasAnimation(animationID) then
		animationID = ANIMATIONS.TALK;
	end

	-- If the animation is an exclamation and the model don't support it, fallback to a normal sentence
	if animationID == ANIMATIONS.TALK and not self:HasAnimation(animationID) then
		animationID = ANIMATIONS.STANDING;
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
	self.currentAnimation = self.idleAnimationID;
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

	-- This field will be use to monitor the tries when setting animations that fail on the first times
	self.animationTries = 0;

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
		After(1, self.bindedOnAnimFinished);

	else
		-- We are no longer playing an interstice animation
		self.isPlayingIntersticeAnimation = true;

		-- Pop the next animation from the sequence table
		local nextAnimation = pop(self.sequence, 1);
		-- Get a valid speaking animation (non speaking animation are ignored)
		nextAnimation = self:GetValidSpeakingAnimation(nextAnimation);

		self:SetAnimationWithFailSafe(nextAnimation);
	end
end

--- Tries to set an animation with fail safe mechanisms in place to retry setting the animation a couple of times
--- if it fails the first times.
--- This is not as pretty as I wish it would be, but simply waiting for the model to be loaded or some other event doesn't work,
--- whereas this technique works every time.
---@param animationID number
function Storyline_PlayerModelMixin:SetAnimationWithFailSafe(animationID)
	self.currentAnimation = animationID;
	if animationID == self.idleAnimationID then
		self.animationStartedTime = 0;
		self:OnAnimFinished();
	else
		self.animationStartedTime = GetTime();
		self:SetAnimation(animationID);
		if self:RequiresManualAnimationTiming() then
			C_Timer.After(TRPDialogAnimationDB:GetAnimationDuration(self:GetModelFileIDAsString(), animationID), function()
				self:OnAnimFinished(true)
			end)
		end
	end
end

function Storyline_PlayerModelMixin:ReplayAnimation()
	self:SetAnimationWithFailSafe(self.currentAnimation);
end

function Storyline_PlayerModelMixin:OnAnimFinished(manually)

	if self:RequiresManualAnimationTiming() and not manually then
		-- In case of manual animations, if we did not came here manually it means the game sent the invalid OnAnimFinished script (as sadly expected)
		-- We ignore it, this function will be called again manually after the timing is over
		return
	end

	-- Do not do anything if we are not currently playing a animation sequence
	if not self.isPlayingAnimationSequence then
		return
	end

	-- Check if the animation actually failed to be played (it took less than a second) and retry to play the animation
	-- We only try that 50 times before bailing, to make sure we don't get into an infinite loop.
	if self.animationTries < 50 and GetTime() - self.animationStartedTime < 1 then
		self.animationTries = self.animationTries + 1;
		return self:ReplayAnimation();
	else
		-- If the animation played correctly, make sure to reset the tries counter
		self.animationTries = 0;
	end

	-- If we still have animation available in the sequence, play the next animation
	if #self.sequence > 0 then
		self:PlayNextAnimation();
	else
		-- If the sequence is empty, set isPlayingAnimationSequence to false and play idle animation
		self.isPlayingAnimationSequence = false;
		if self.currentAnimation ~= self.idleAnimationID then
			self:PlayIdleAnimation();
		end
	end
end

function Storyline_PlayerModelMixin:SetModelHeight(newHeight)
	newHeight = newHeight or DEFAULT_PROPERTIES.scale;
	self.scale = newHeight;
	self:InitializeCamera(newHeight);
end

function Storyline_PlayerModelMixin:SetModelFacing(facing)
	facing = facing or DEFAULT_PROPERTIES.facing;
	self.facing = facing;
	self:SetFacing(facing * (self.isModelDisplayedOnLeft and 1 or -1));
end

function Storyline_PlayerModelMixin:SetModelFeet(feet)
	feet = feet or DEFAULT_PROPERTIES.feet;
	self.feet = feet;
	self:SetHeightFactor(feet);
end

function Storyline_PlayerModelMixin:SetModelOffset(offset)
	offset = offset or DEFAULT_PROPERTIES.offset;
	self.offset = offset;
	self:SetTargetDistance(offset * (self.isModelDisplayedOnLeft and 1 or -1));
end

function Storyline_PlayerModelMixin:AnimateScalingValuesIn(height, feet, offset, facing)
	self.modelHeightTransitionator:RunValue(self.scale or DEFAULT_PROPERTIES.scale, height, 0.8, self.boundSetModelHeight)
	self.modelFeetTransitionator:RunValue(self.feet or DEFAULT_PROPERTIES.feet, feet, 0.2, self.boundSetModelFeet);
	self:SetModelOffset(offset);
	self:SetModelFacing(facing);
end

function Storyline_PlayerModelMixin:SetScalingValuesIn(height, feet, offset, facing)
	self:SetModelHeight(height);
	self:SetModelFeet(feet);
	self:SetModelOffset(offset);
	self:SetModelFacing(facing);
end

--- TODO This will go once we have the superior scaling model, no need for string
function Storyline_PlayerModelMixin:GetModelFileIDAsString()
	return self.displayedModel and tostring(self.displayedModel);
end
