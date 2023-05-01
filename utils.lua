----------------------------------------------------------------------------------
--  Storyline
--	---------------------------------------------------------------------------
--	Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--	Copyright 2015 Morgane "Ellypse" Parize (ellypse@totalrp3.info)
--
--	Licensed under the Apache License, Version 2.0 (the "License");
--	you may not use this file except in compliance with the License.
--	You may obtain a copy of the License at
--
--		http://www.apache.org/licenses/LICENSE-2.0
--
--	Unless required by applicable law or agreed to in writing, software
--	distributed under the License is distributed on an "AS IS" BASIS,
--	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--	See the License for the specific language governing permissions and
--	limitations under the License.
----------------------------------------------------------------------------------

-- Storyline API
local getId = Storyline_API.lib.generateID;

-- WOW API
local tostring, print = tostring, print;

---
-- I am using this little local function because I always forget a print or two :P
-- Debug messages will only be printed if the debug option is true
-- So if I happen to forget one call to debug() someday, it will print nothing for normal users :P
--
-- @param message
--
local debug = function(message, ...)
	local DEFAULT_DEBUG_MESSAGE = "Debug function called, but message was empty ¯\\_(^_^)_/¯";
	local header = "|cffffa500[Storyline debug]|r: %s"

	if Storyline_Data.config.debug then
		print(header:format(message or DEFAULT_DEBUG_MESSAGE), ...);
	end
end
Storyline_API.debug = debug;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- UTILS
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function getQuestIcon(frequency, isRepeatable, isLegendary, isTrivial)
	local questIcon = "|T";
	if (isLegendary) then
		questIcon = questIcon .. "Interface\\GossipFrame\\AvailableLegendaryQuestIcon:20:20";
	elseif (frequency == LE_QUEST_FREQUENCY_DAILY or frequency == LE_QUEST_FREQUENCY_WEEKLY) then
		questIcon = questIcon .. "Interface\\GossipFrame\\DailyQuestIcon:20:20";
	elseif (isRepeatable) then
		questIcon = questIcon .. "Interface\\GossipFrame\\DailyActiveQuestIcon:20:20";
	elseif isTrivial then
		questIcon = questIcon .. "Interface\\MINIMAP\\ObjectIcons:17:20:2:0:256:256:132:159:97:126";
	else
		questIcon = questIcon .. "Interface\\GossipFrame\\AvailableQuestIcon:20:20";
	end
	return questIcon .. "|t";
end
Storyline_API.getQuestIcon = getQuestIcon;

local function getQuestActiveIcon(isComplete)
	local questIcon = "|T";
	if isComplete then
		questIcon = questIcon .. "Interface\\GossipFrame\\ActiveQuestIcon:20:20";
	else
		questIcon = questIcon .. "Interface\\GossipFrame\\IncompleteQuestIcon:20:20";
	end
	return questIcon .. "|t";
end
Storyline_API.getQuestActiveIcon = getQuestActiveIcon;

local function getBindingIcon(number)
	if not Storyline_Data.config.useKeyboard then
		return "";
	end

	local rowMapping = math.floor(number / 9);
	local iconSize = 32;
	local xStart = iconSize * (number - (8 * rowMapping) - 1);
	local xEnd = iconSize * (number - (8 * rowMapping));
	local yStart = 128 + iconSize * rowMapping;
	local yEnd = 162 + iconSize * rowMapping;

	return "|TInterface\\Worldmap\\UI-QuestPoi-NumberIcons:" .. iconSize .. ": " .. iconSize .. ":0:0:256:256:" .. xStart .. ":" .. xEnd .. ":" .. yStart .. ":" .. yEnd .. "|t";
end
Storyline_API.getBindingIcon = getBindingIcon;

local function getQuestTriviality(isTrivial)
	if isTrivial then
		return " (|TInterface\\MINIMAP\\ObjectIcons:18:9:0:0:256:256:137:151:97:126|t)";
	else
		return "";
	end
end
Storyline_API.getQuestTriviality = getQuestTriviality;

local function getQuestLevelColor()
	return 0.9, 0.6, 0;
end
Storyline_API.getQuestLevelColor = getQuestLevelColor;

local function adjustTextContrast(text)
	if not text then return end

	-- Lightening the blue text to be more visible
	text = text:gsub("|cFF0000FF", "|cFF8888FF");
	text = text:gsub("|cnPURE_BLUE_COLOR:", "|cFF8888FF");

	return text;
end
Storyline_API.adjustTextContrast = adjustTextContrast;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- SOME ANIMATION
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local animationLib = LibStub:GetLibrary("TRP-Dialog-Animation-DB");

local Storyline_NPCFrameModelsMe, Storyline_NPCFrameModelsYou = Storyline_NPCFrameModelsMe, Storyline_NPCFrameModelsYou;

function Storyline_API.playSelfAnim(sequence)
	if not Storyline_NPCFrameModelsMe:GetModelFileID() then return end
	animationLib:PlayAnimationAndStand(Storyline_NPCFrameModelsMe, sequence, animationLib:GetAnimationDuration(tostring(Storyline_NPCFrameModelsMe:GetModelFileID()), sequence), getId());
end

local function playTargetAnim(sequence)
	if not Storyline_NPCFrameModelsYou:GetModelFileID() then return end
	animationLib:PlayAnimationAndStand(Storyline_NPCFrameModelsYou, sequence, animationLib:GetAnimationDuration(tostring(Storyline_NPCFrameModelsYou:GetModelFileID()), sequence), getId());
end
Storyline_NPCFrameDebugSequenceYou.playTargetAnim = playTargetAnim;