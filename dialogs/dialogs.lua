----------------------------------------------------------------------------------
--  Storyline
--  Dialogs API
--	---------------------------------------------------------------------------
--	Copyright 2016 Renaud "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
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

---------------------------------------------
--- Dialog choices
---------------------------------------------

Storyline_API.dialogs = {};
local API = Storyline_API.dialogs;

local BUCKET_TYPE = {
	COMPLETED_QUEST   = 1,
	AVAILABLE_QUEST   = 2,
	GOSSIP            = 3,
	UNCOMPLETED_QUEST = 4
}
API.BUCKET_TYPE = BUCKET_TYPE;

local EVENT_TYPES = {
	GOSSIP_SHOW = "GOSSIP_SHOW",
	QUEST_GREETING = "QUEST_GREETING"
}
API.EVENT_TYPES = EVENT_TYPES;

local GetNumGossipOptions,GetGossipOptions, GetNumGossipAvailableQuests, GetGossipAvailableQuests, GetNumGossipActiveQuests, GetGossipActiveQuests, GetAvailableQuestInfo, GetAvailableTitle, GetNumAvailableQuests, GetActiveTitle, GetNumActiveQuests = GetNumGossipOptions, GetGossipOptions, GetNumGossipAvailableQuests, GetGossipAvailableQuests, GetNumGossipActiveQuests, GetGossipActiveQuests, GetAvailableQuestInfo, GetAvailableTitle, GetNumAvailableQuests, GetActiveTitle, GetNumActiveQuests;
local pairs, assert = pairs, assert;

local NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS = 2;
local function getGossipChoices()
	local numberOfGossipOptionsAvailable = GetNumGossipOptions();

	local gossipChoices = {};
	local gossipOptions = { GetGossipOptions() };

	for i = 1, numberOfGossipOptionsAvailable do
		local j = i * NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS;
		gossipChoices[i] = {
			title      = gossipOptions[j - (NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS - 1)],
			gossipType = gossipOptions[j - (NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS - 2)]
		};
	end

	return gossipChoices;
end

local NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS = 8;
local function getGossipAvailableQuestsChoices()
	local numberOfAvailableQuests = GetNumGossipAvailableQuests();

	local availableQuestsChoices = {};
	local availableQuests = { GetGossipAvailableQuests() };

	for i = 1, numberOfAvailableQuests do
		local j = i * NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS;
		availableQuestsChoices[i] = {
			title        = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 1)],
			lvl          = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 2)],
			isTrivial    = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 3)],
			frequency    = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 4)],
			isRepeatable = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 5)],
			isLegendary  = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 6)],
			isIgnored    = availableQuests[j - (NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS - 7)]
		};
	end
	return availableQuestsChoices;
end

local NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS = 7;
local function getGossipActiveQuestsChoices()
	local numberOfActiveQuests = GetNumGossipActiveQuests();

	-- We will have two buckets: one for the completed quests and one for the non completed ones
	local activeCompletedQuestsChoices = {};
	local activeUncompletedQuestsChoices = {};

	local activeQuests = { GetGossipActiveQuests() };

	for i = 1, numberOfActiveQuests do
		local j = i * NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS;
		local questData = {
			title        = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 1)],
			lvl          = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 2)],
			isTrivial    = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 3)],
			isCompleted  = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 4)],
			isLegendary  = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 5)],
			isIgnored    = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 6)]
		};
		-- Place the choice in the appropriate bucket
		if  questData.isCompleted then
			activeCompletedQuestsChoices[i] = questData;
		else
			activeUncompletedQuestsChoices[i] = questData;
		end
	end

	return activeCompletedQuestsChoices, activeUncompletedQuestsChoices;
end

local function getAvailableQuestsChoices()
	local numberOfAvailableQuests = GetNumAvailableQuests();

	local availableQuestsChoices = {};

	for i = 1, numberOfAvailableQuests do
		local title = GetAvailableTitle(i);
		local isTrivial, frequency, isRepeatable, isLegendary, isIgnored = GetAvailableQuestInfo(i);
		availableQuestsChoices[i] = {
			title        = title,
			isTrivial    = isTrivial,
			frequency    = frequency,
			isRepeatable = isRepeatable,
			isLegendary  = isLegendary,
			isIgnored    = isIgnored
		};
	end
	return availableQuestsChoices;
end

local function getActiveQuestsChoices()

	local numberOfActiveQuests = GetNumActiveQuests();

	-- We will have two buckets: one for the completed quests and one for the non completed ones
	local activeCompletedQuestsChoices = {};
	local activeUncompletedQuestsChoices = {};

	for i = 1, numberOfActiveQuests do
		local title, isComplete = GetActiveTitle(i);
		local isTrivial, frequency, isRepeatable, isLegendary = GetAvailableQuestInfo(i);
		local questData = {
			title        = title,
			isTrivial    = isTrivial,
			isCompleted  = isComplete,
			isRepeatable = isRepeatable,
			isIgnored    = isLegendary
		};
		-- Place the choice in the appropriate bucket
		if  questData.isCompleted then
			activeCompletedQuestsChoices[i] = questData;
		else
			activeUncompletedQuestsChoices[i] = questData;
		end
	end

	return activeCompletedQuestsChoices, activeUncompletedQuestsChoices;
end

function API.getChoices(eventType)
	local choices = {};

	if eventType == EVENT_TYPES.GOSSIP_SHOW then
		choices[BUCKET_TYPE.COMPLETED_QUEST], choices[BUCKET_TYPE.UNCOMPLETED_QUEST] = getGossipActiveQuestsChoices();
		choices[BUCKET_TYPE.AVAILABLE_QUEST] = getGossipAvailableQuestsChoices();
		choices[BUCKET_TYPE.GOSSIP] = getGossipChoices()
	elseif eventType == EVENT_TYPES.QUEST_GREETING then
		choices[BUCKET_TYPE.COMPLETED_QUEST], choices[BUCKET_TYPE.UNCOMPLETED_QUEST] = getActiveQuestsChoices();
		choices[BUCKET_TYPE.AVAILABLE_QUEST] = getAvailableQuestsChoices();
	end

	return choices;
end

--- Returns the first dialog choice for the given event type
-- @param eventType The name of the event to use to retrieve data (GOSSIP_SHOW, QUEST_GREETING)
--
function API.getFirstChoice(eventType)
	local firstChoice, bucketType, index;
	local dialogChoices = API.getChoices(eventType);
	for _, choicesBag in pairs(dialogChoices) do
		bucketType = _;
		for _, choice in pairs(choicesBag) do
			index = _;
			firstChoice = choice;
			break
		end
		if firstChoice then break end
	end
	return firstChoice, bucketType, index;
end

local DIALOG_CHOICES_SELECTORS = {
	[API.EVENT_TYPES.GOSSIP_SHOW] = {
		[API.BUCKET_TYPE.AVAILABLE_QUEST]   = SelectGossipAvailableQuest,
		[API.BUCKET_TYPE.COMPLETED_QUEST]   = SelectGossipActiveQuest,
		[API.BUCKET_TYPE.UNCOMPLETED_QUEST] = SelectGossipActiveQuest,
		[API.BUCKET_TYPE.GOSSIP]            = SelectGossipOption,
	},
	[API.EVENT_TYPES.QUEST_GREETING] = {
		[API.BUCKET_TYPE.AVAILABLE_QUEST]   = SelectAvailableQuest,
		[API.BUCKET_TYPE.COMPLETED_QUEST]   = SelectActiveQuest,
		[API.BUCKET_TYPE.UNCOMPLETED_QUEST] = SelectActiveQuest
	}
}

function API.getDialogChoiceSelectorForEventType(eventType, bucketType)
	assert(DIALOG_CHOICES_SELECTORS[eventType], ("No dialog choice selector for event type %s!"):format(eventType));
	assert(DIALOG_CHOICES_SELECTORS[eventType][bucketType], ("No dialog choice selector for bucket type %s in event type %s!"):format(bucketType, eventType));
	return DIALOG_CHOICES_SELECTORS[eventType][bucketType];
end