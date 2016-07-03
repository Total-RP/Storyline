----------------------------------------------------------------------------------
-- Total RP 3: Animations DB
-- ---------------------------------------------------------------------------
-- Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----------------------------------------------------------------------------------

local MAJOR, MINOR = "TRP-Dialog-Animation-DB", 1

local Lib = LibStub:NewLibrary(MAJOR, MINOR)

if not Lib then return end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Animations durations
-- This section contains a DB of animations duration for all playable races/sex and some NPC.
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

-- 193 : levitate
-- 195 : /train
-- 225 : /fear
-- 520 : read
-- 66 : /bow
-- 67 : /hi
-- 113 : /salute
-- 209 : /point
-- 61 : /eat
-- 63 : /use
-- 68 : /acclame

local EXCLAME_ID = "64";
local QUESTION_ID = "65";
local TALK_ID = "60";
local YES_ID = "185";
local NOPE_ID = "186";
local ACLAIM_ID = "68";

local ANIMATION_SEQUENCE_DURATION = {
	[EXCLAME_ID] = 3.000,
	[QUESTION_ID] = 3.000,
	[TALK_ID] = 4.000,
	[YES_ID] = 3.000,
	[NOPE_ID] = 3.000,
	[ACLAIM_ID] = 2.400,
	["0"] = 1.500,
}

local ANIMATION_SEQUENCE_DURATION_BY_MODEL = {

	-- NIGHT ELVES
	["921844"] = {
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.600,
		[TALK_ID] = 2.1,
		[YES_ID] = 1.9,
		[NOPE_ID] = 1.5,
		[ACLAIM_ID] = 2.4,
	},
	["974343"] = {
		[TALK_ID] = 1.900,
		[EXCLAME_ID] = 1.9,
		[QUESTION_ID] = 1.900,
		[YES_ID] = 1.1,
		[NOPE_ID] = 1.3,
		[ACLAIM_ID] = 2,
	},
	-- DWARF
	["878772"] = {
		[EXCLAME_ID] = 1.800,
		[QUESTION_ID] = 1.800,
		[TALK_ID] = 2.000,
		[YES_ID] = 1.9,
		[NOPE_ID] = 1.9,
		[ACLAIM_ID] = 3,
	},
	["950080"] = {
		[TALK_ID] = 1.900,
		[EXCLAME_ID] = 2.00,
		[QUESTION_ID] = 1.800,
		[YES_ID] = 2.0,
		[NOPE_ID] = 1.9,
		[ACLAIM_ID] = 2,
	},
	-- GNOMES
	["900914"] = {
		[EXCLAME_ID] = 1.800,
		[QUESTION_ID] = 2.250,
		[TALK_ID] = 3.900,
		[YES_ID] = 0.9,
		[NOPE_ID] = 1.0,
		[ACLAIM_ID] = 2.0,
	},
	["940356"] = {
		[EXCLAME_ID] = 1.850,
		[QUESTION_ID] = 2.250,
		[TALK_ID] = 3.900,
		[YES_ID] = 0.9,
		[NOPE_ID] = 1.7, -- Multi anim ...
		[ACLAIM_ID] = 2.0,
	},
	-- HUMAN
	["1011653"] = {
		[EXCLAME_ID] = 1.800,
		[QUESTION_ID] = 1.800,
		[TALK_ID] = 2.000,
		[YES_ID] = 2.6,
		[NOPE_ID] = 3.2,
		[ACLAIM_ID] = 2.400,
	},
	["1000764"] = {
		[EXCLAME_ID] = 2.700,
		[QUESTION_ID] = 1.800,
		[TALK_ID] = 2.650,
		[YES_ID] = 1.900,
		[NOPE_ID] = 1.900,
		[ACLAIM_ID] = 2.300,
	},
	-- DRAENEI
	["1022598"] = { -- Female
		[TALK_ID] = 2.850,
		[QUESTION_ID] = 1.850,
		[EXCLAME_ID] = 2.000,
		[YES_ID] = 1.9,
		[NOPE_ID] = 2,
		[ACLAIM_ID] = 2,
	}, -- Male
	["1005887"] = {
		[TALK_ID] = 3.200,
		[QUESTION_ID] = 1.850,
		[EXCLAME_ID] = 3.000,
		[YES_ID] = 1.3,
		[NOPE_ID] = 1.2,
		[ACLAIM_ID] = 1.8,
	},
	-- WORGEN
	["307454"] = {
		[QUESTION_ID] = 3.7,
		[TALK_ID] = 4.000,
		[EXCLAME_ID] = 2.700,
		[YES_ID] = 1.7,
		[ACLAIM_ID] = 3.5,
		[NOPE_ID] = 1.8,
	},
	["307453"] = {
		[TALK_ID] = 4.000,
		[EXCLAME_ID] = 2.700,
		[QUESTION_ID] = 4.500,
		[YES_ID] = 2.55,
		[NOPE_ID] = 2.35,
		[ACLAIM_ID] = 2.4,
	},
	-- PANDAREN
	["589715"] = {
		[TALK_ID] = 3.000,
		[EXCLAME_ID] = 3,
		[QUESTION_ID] = 3.8,
		[ACLAIM_ID] = 3.200,
		[YES_ID] = 2.00,
		[NOPE_ID] = 3.50, -- Multi anim ...
	},
	["535052"] = {
		[EXCLAME_ID] = 3.400,
		[QUESTION_ID] = 4.0,
		[TALK_ID] = 4.000,
		[YES_ID] = 4,
		[NOPE_ID] = 3.2,
		[ACLAIM_ID] = 2.400,
	},
	-- ORCS
	["949470"] = {
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.600,
		[TALK_ID] = 2.1,
		[YES_ID] = 1.2,
		[NOPE_ID] = 1.3,
		[ACLAIM_ID] = 1.4,
	},
	["917116"] = {
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.600,
		[TALK_ID] = 1.900,
		[YES_ID] = 1.8,
		[NOPE_ID] = 1.8,
		[ACLAIM_ID] = 2.7,
	},
	-- GOBLIN
	["119376"] = {
		[TALK_ID] = 4.3,
		[QUESTION_ID] = 3.7,
		[EXCLAME_ID] = 2.600,
		[YES_ID] = 2.5,
		[NOPE_ID] = 2.8,
		[ACLAIM_ID] = 3.2,
	},
	["119369"] = {
		[TALK_ID] = 4.2,
		[QUESTION_ID] = 4.5,
		[EXCLAME_ID] = 3.5,
		[YES_ID] = 2.6,
		[NOPE_ID] = 2.5,
		[ACLAIM_ID] = 1.8,
	},
	-- Blood elves
	["1100087"] = {
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 2.00,
		[TALK_ID] = 2.000,
		["185"] = 1.3,
		["68"] = 2.1,
		["186"] = 1.3,
	},
	["110258"] = {
		["185"] = 1.4,
		["65"] = 1.4,
		["68"] = 1.5,
		["186"] = 2,
		["64"] = 2.8,
	},
	["123081"] = {
		[TALK_ID] = 2.000,
		[QUESTION_ID] = 2.00,
	},
	-- Taurene
	["986648"] = {
		["185"] = 1.5,
		["186"] = 1.8,
		["65"] = 1.7,
		["64"] = 1.9,
		["68"] = 1.8,
	},
	["968705"] = {
		[TALK_ID] = 2.90,
		[EXCLAME_ID] = 2.0,
		[QUESTION_ID] = 1.8,
		["185"] = 1.9,
		["68"] = 1.9,
		["186"] = 2,
	},
	-- Troll
	["1018060"] = {
		[TALK_ID] = 2.45,
		["185"] = 1.4,
		["186"] = 1.6,
		["65"] = 1.4,
		["64"] = 2,
		["68"] = 2.1,
	},
	["1022938"] = {
		[TALK_ID] = 2.400,
		[EXCLAME_ID] = 2.600,
		[QUESTION_ID] = 1.9,
		["185"] = 1.6,
		["68"] = 3,
		["186"] = 1.6,
	},
	-- Scourge
	["959310"] = { -- Male
		["185"] = 1.8,
		["186"] = 1.8,
		["65"] = 2,
		["64"] = 2.2,
		["68"] = 2.1,
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- NPC
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	["117412"] = {
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.7,
		[TALK_ID] = 3.000,
	},
	["125589"] = {
		[TALK_ID] = 2.000,
		[QUESTION_ID] = 1.600,
	},
	["1024776"] = {
		[TALK_ID] = 2.000,
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.7,
	},
	["234694"] = {
		[TALK_ID] = 2.000,
		[EXCLAME_ID] = 2.000,
		[QUESTION_ID] = 1.5,
	},
	-- ARRAKOA
	["1033563"] = {
		[TALK_ID] = 1.700,
	},
	["986699"] = {
		[TALK_ID] = 4.300,
	},
	["930099"] = {
		[TALK_ID] = 1.9,
	},
	["984967"] = {
		[TALK_ID] = 3.2,
	},
	["124118"] = {
		[TALK_ID] = 1.9,
	},
}

ANIMATION_SEQUENCE_DURATION_BY_MODEL["579571"] = ANIMATION_SEQUENCE_DURATION_BY_MODEL["974343"];

local DEFAULT_SEQUENCE_TIME = 4;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Animation mapping
-- As some NPC models does not have some basing dialog animation, the mapping can map back a missing animation to a existing one.
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local DEFAULT_ANIM_MAPPING = {
	["!"] = 64,
	["?"] = 65,
	["."] = 60,
}
local ALL_TO_TALK = {
	["!"] = 60,
	["?"] = 60,
}
local ALL_TO_NONE = {
	["!"] = 0,
	["?"] = 0,
	["."] = 0,
}
local ANIM_MAPPING = {};
ANIM_MAPPING["124456"] = ALL_TO_TALK;
ANIM_MAPPING["930099"] = ALL_TO_TALK;
ANIM_MAPPING["124495"] = ALL_TO_TALK;
ANIM_MAPPING["123455"] = ALL_TO_TALK;
ANIM_MAPPING["376247"] = ALL_TO_TALK;
ANIM_MAPPING["125603"] = ALL_TO_NONE;
ANIM_MAPPING["125512"] = ALL_TO_NONE;
ANIM_MAPPING["125059"] = ALL_TO_NONE;
ANIM_MAPPING["125576"] = ALL_TO_NONE;
ANIM_MAPPING["123071"] = ALL_TO_NONE;
ANIM_MAPPING["970457"] = ALL_TO_NONE;
ANIM_MAPPING["986699"] = ALL_TO_TALK;
ANIM_MAPPING["1033563"] = ALL_TO_TALK;
ANIM_MAPPING["1033002"] = ALL_TO_NONE;
ANIM_MAPPING["125796"] = ALL_TO_NONE;
ANIM_MAPPING["124118"] = ALL_TO_TALK;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Animations API
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local after, tostring = C_Timer.After, tostring;

function Lib:PlayAnim(model, sequence)
	model:SetAnimation(sequence);
	if model.debug then
		model.debug:SetText(sequence);
	end
end

function Lib:PlayAnimationDelay(model, sequence, duration, delay, token)
	if delay == 0 then
		self:PlayAnim(model, sequence)
	else
		model.token = token;
		after(delay, function()
			if model.token == token then
				self:PlayAnim(model, sequence);
			end
		end)
	end

	return delay + duration;
end

function Lib:PlayAnimationAndStand(model, sequence, duration, token)
	model.token = token;
	self:PlayAnim(model, sequence);
	after(duration, function()
		if model.token == token then
			self:PlayAnim(model, 0);
		end
	end);
end

function Lib:GetAnimationDuration(model, sequence)
	sequence = tostring(sequence);
	if ANIMATION_SEQUENCE_DURATION_BY_MODEL[model] and ANIMATION_SEQUENCE_DURATION_BY_MODEL[model][sequence] then
		return ANIMATION_SEQUENCE_DURATION_BY_MODEL[model][sequence];
	end
	return ANIMATION_SEQUENCE_DURATION[sequence] or DEFAULT_SEQUENCE_TIME;
end

function Lib:GetDialogAnimation(model, animationType)
	if model then
		if ANIM_MAPPING[model] and ANIM_MAPPING[model][animationType] then
			return ANIM_MAPPING[model][animationType];
		end
	end
	return DEFAULT_ANIM_MAPPING[animationType];
end