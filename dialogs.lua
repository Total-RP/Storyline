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

local BUCKET_TYPE = {
	COMPLETED_QUEST   = 1,
	AVAILABLE_QUEST   = 2,
	GOSSIP            = 3,
	UNCOMPLETED_QUEST = 4
}
Storyline_API.dialogs.BUCKET_TYPE = BUCKET_TYPE;

local GetNumGossipOptions,GetGossipOptions, GetNumGossipAvailableQuests, GetGossipAvailableQuests, GetNumGossipActiveQuests, GetGossipActiveQuests = GetNumGossipOptions, GetGossipOptions, GetNumGossipAvailableQuests, GetGossipAvailableQuests, GetNumGossipActiveQuests, GetGossipActiveQuests;

local NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS = 2;
local function getGossipChoices()
	local numberOfGossipOptionsAvailable = GetNumGossipOptions();

	local gossipChoices = {};
	local gossipOptions = { GetGossipOptions() };

	for i = 1, numberOfGossipOptionsAvailable do
		local j = i * NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS;
		gossipChoices[i] = {
			text       = gossipOptions[j - (NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS - 1)],
			gossipType = gossipOptions[j - (NUMBER_OF_PARAMETERS_FOR_GOSSIP_OPTIONS - 2)]
		};
	end

	return gossipChoices;
end

local NUMBER_OF_PARAMETERS_FOR_AVAILABLE_QUESTS = 7;
local function getAvailableQuestsChoices()
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

local NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS = 6;
local function getActiveQuestsChoices()
	local numberOfActiveQuests = GetNumGossipActiveQuests();

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
			isRepeatable = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 5)],
			isIgnored    = activeQuests[j - (NUMBER_OF_PARAMETERS_FOR_ACTIVE_QUESTS - 6)]
		};
		if  questData.isCompleted then
			activeCompletedQuestsChoices[i] = questData;
		else
			activeUncompletedQuestsChoices[i] = questData;
		end
	end

	return activeCompletedQuestsChoices, activeUncompletedQuestsChoices;
end

function Storyline_API.dialogs.getChoices()
	local choices = {};

	choices[BUCKET_TYPE.COMPLETED_QUEST], choices[BUCKET_TYPE.UNCOMPLETED_QUEST] = getActiveQuestsChoices();
	choices[BUCKET_TYPE.AVAILABLE_QUEST] = getAvailableQuestsChoices();
	choices[BUCKET_TYPE.GOSSIP] = getGossipChoices();

	return choices;
end