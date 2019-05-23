----------------------------------------------------------------------------------
--  Storyline
--  Rewards API
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
--- Rewards getters
---------------------------------------------

local tinsert, pairs = tinsert, pairs;

Storyline_API.rewards = {};
local API = Storyline_API.rewards;

local OBJECTIVES_GETTERS;

local REWARDS_DEFAULT_ICON = [[Interface\ICONS\trade_archaeology_chestoftinyglassanimals]];

local BUCKET_TYPES = {
	RECEIVED = 1,
	CHOICE = 2,
	AURA = 3,
	FOLLOWER = 4,
	OBJECTIVES = 9,
};
API.BUCKET_TYPES = BUCKET_TYPES;

local BUCKET_TYPES_ORDER = {};
for key, value in pairs(BUCKET_TYPES) do
	BUCKET_TYPES_ORDER[value] = key;
end

local REWARD_TYPES = {
	XP = 1,
	MONNEY = 2,
	ITEMS = 6,
	SPELL = 7
}
API.REWARD_TYPES = REWARD_TYPES;

local REWARD_TYPES_ORDER = {};
for key, value in pairs(REWARD_TYPES) do
	REWARD_TYPES_ORDER[value] = key;
end

local MONEY_ICONS = {
	COPPER = "Interface\\ICONS\\inv_misc_coin_05",
	SILVER = "Interface\\ICONS\\inv_misc_coin_03",
	GOLD   = "Interface\\ICONS\\inv_misc_coin_01"
}

local REWARD_GETTERS = {
	[BUCKET_TYPES.RECEIVED] = {
		[REWARD_TYPES.XP] = function()
			local rewards = {};
			local xp = GetRewardXP();
			if xp > 0 then
				tinsert(rewards, {
					text         = BreakUpLargeNumbers(xp) .. " " .. XP,
					icon         = 134939,
					tooltipTitle = ERR_QUEST_REWARD_EXP_I:format(xp)
				});
			end
			return rewards;
		end,
		[REWARD_TYPES.MONNEY] = function()
			local rewards = {};
			local money = GetRewardMoney();
			if money > 0 then
				local icon;
				if money < COPPER_PER_SILVER then
					icon = MONEY_ICONS.COPPER;
				elseif money < COPPER_PER_GOLD then
					icon = MONEY_ICONS.SILVER;
				else
					icon = MONEY_ICONS.GOLD;
				end
				local moneyString = GetCoinTextureString(money);
				tinsert(rewards, {
					text = moneyString,
					icon = icon,
					tooltipTitle = ERR_QUEST_REWARD_MONEY_S:format(moneyString),
				});
			end
			return rewards;
		end,
		[REWARD_TYPES.ITEMS] = function()
			local rewards = {};
			for i = 1, GetNumQuestRewards() do
				local name, texture, count, quality, isUsable = GetQuestItemInfo("reward", i);
				tinsert(rewards, {
					text       = name,
					icon       = texture,
					count      = count,
					index      = i,
					type       = "item",
					quality    = quality,
					rewardType = "reward",
					isUsable   = isUsable,
				});
			end
			-- Since some quests have "choices" with only one choice, we will consider this only choice as not being a choice...
			if GetNumQuestChoices() == 1 then
				local name, texture, count, quality, isUsable = GetQuestItemInfo("choice", 1);
				tinsert(rewards, {
					text       = name,
					icon       = texture,
					count      = count,
					index      = 1,
					quality    = quality,
					rewardType = "choice",
					isUsable   = isUsable,
				});
			end
			return rewards;
		end
	},
	[BUCKET_TYPES.CHOICE] = {
		[REWARD_TYPES.ITEMS] = function()
			local choices = {};
			local numberOfItemChoices = GetNumQuestChoices();
			-- If there is only one choice, we already dealt with it in the getItemsReward() function
			if numberOfItemChoices == 1 then return choices end
			for i = 1, numberOfItemChoices do
				local name, texture, numItems, quality, isUsable = GetQuestItemInfo("choice", i);
				tinsert(choices, {
					text       = name,
					icon       = texture,
					count      = numItems,
					quality    = quality,
					index      = i,
					rewardType = "choice",
					isUsable   = isUsable,
				});
			end
			return choices;
		end
	},
	[BUCKET_TYPES.AURA] = {
		[REWARD_TYPES.SPELL] = function()
			local auraRewards = {};
			local numberOfSpellRewards = GetNumRewardSpells();

			for rewardSpellIndex = 1, numberOfSpellRewards do
				local texture, name, isTradeskillSpell, isSpellLearned, hideSpellLearnText, isBoostSpell, garrFollowerID, genericUnlock, spellID = GetRewardSpell(rewardSpellIndex);
				local knownSpell = IsSpellKnownOrOverridesKnown(spellID);

				tinsert(auraRewards, {
					text   			 = name,
					icon   			 = texture,
					spellID			 = spellID,
					rewardSpellIndex = rewardSpellIndex
				});
			end

			return auraRewards;
		end,
	}
}

function API.getRewardsForBucketTypeAndRewardType(bucketType, rewardType)
	assert(REWARD_GETTERS[bucketType] or OBJECTIVES_GETTERS[rewardType], ("No reward getter for bucket type %s."):format(bucketType or "NO BUCKET TYPE"));
	assert(REWARD_GETTERS[bucketType] and REWARD_GETTERS[bucketType][rewardType] or OBJECTIVES_GETTERS[rewardType], ("No reward getter for reward type %s in bucket type %s."):format(rewardType or "NO REWARD TYPE", bucketType));
	return REWARD_GETTERS[bucketType] and REWARD_GETTERS[bucketType][rewardType] and  REWARD_GETTERS[bucketType][rewardType]() or OBJECTIVES_GETTERS[rewardType]();
end

function API.getRewards()
	local rewardsBucket = {}
	local bestIcon = REWARDS_DEFAULT_ICON;
	local totalNumberOfRewards = 0;

	for bucketType, _ in pairs(BUCKET_TYPES_ORDER) do
		-- Create a new reward bucket for this bucket type
		rewardsBucket[bucketType] = {};
		for rewardType, _ in pairs(REWARD_TYPES_ORDER) do
			-- If we have reward getters for this bucket type and this reward type we use it to retreive the rewards
			if REWARD_GETTERS[bucketType] and REWARD_GETTERS[bucketType][rewardType] then
				local rewards = REWARD_GETTERS[bucketType][rewardType]();
				-- Only use the rewards table if it contains something
				if #rewards > 0 then
					for _, reward in pairs(rewards) do
						bestIcon = reward.icon or bestIcon;
						totalNumberOfRewards = totalNumberOfRewards + 1;
					end
					rewardsBucket[bucketType][rewardType] = rewards;
				end
			end
		end
	end

	return rewardsBucket, bestIcon, totalNumberOfRewards;
end

OBJECTIVES_GETTERS = {
	[REWARD_TYPES.MONNEY] = function()
		local money = {};
		local moneyObjective = GetQuestMoneyToGet();
		if moneyObjective > 0 then
			local icon;
			if moneyObjective < COPPER_PER_SILVER then
				icon = MONEY_ICONS.COPPER;
			elseif moneyObjective < COPPER_PER_GOLD then
				icon = MONEY_ICONS.SILVER;
			else
				icon = MONEY_ICONS.GOLD;
			end
			local moneyString = GetCoinTextureString(moneyObjective);
			tinsert(money, {
				text = moneyString,
				icon = icon,
				tooltipTitle = REQUIRED_MONEY .. " " ..moneyString,
				isNotUsable = moneyObjective > GetMoney();
			});
		end
		return money;
	end,
	[REWARD_TYPES.ITEMS] = function()
		local itemObjectives = {};
		for i = 1, GetNumQuestItems() do
			local name, texture, numItems, quality, isUsable = GetQuestItemInfo("required", i);
			tinsert(itemObjectives, {
				text = name,
				icon = texture,
				count = numItems,
				index = i,
				type = "item",
				rewardType = "required",
				isUsable = isUsable,
			});
		end
		return itemObjectives;
	end
}

local OBJECTIVES_DEFAULT_ICON = [[Interface\ICONS\trade_archaeology_chestoftinyglassanimals]];

function API.getObjectiveItems()
	local objectivesBag = {}
	local bestIcon = OBJECTIVES_DEFAULT_ICON;

	for objectiveType, getter in pairs(OBJECTIVES_GETTERS) do
		local objectives = getter();
		if #objectives > 0 then
			for _, objective in pairs(objectives) do
				bestIcon = objective.icon or bestIcon;
			end
			objectivesBag[objectiveType] = objectives;
		end
	end

	return objectivesBag, bestIcon;
end