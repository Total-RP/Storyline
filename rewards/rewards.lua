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
local GetQuestItemInfo, GetNumQuestChoices = GetQuestItemInfo, GetNumQuestChoices;
local IsFollowerCollected, IsCharacterNewlyBoosted, IsSpellKnownOrOverridesKnown, GetRewardSpell, GetNumRewardSpells = C_Garrison.IsFollowerCollected, IsCharacterNewlyBoosted, IsSpellKnownOrOverridesKnown, GetRewardSpell, GetNumRewardSpells;
local GetCoinTextureString, GetQuestMoneyToGet, GetNumQuestItems, GetQuestCurrencyInfo, GetNumQuestCurrencies, GetMoney = GetCoinTextureString, GetQuestMoneyToGet, GetNumQuestItems, GetQuestCurrencyInfo, GetNumQuestCurrencies, GetMoney;
local BreakUpLargeNumbers, GetRewardXP, GetNumRewardCurrencies, GetRewardTitle, GetRewardMoney, GetNumQuestRewards, GetRewardSkillPoints = BreakUpLargeNumbers, GetRewardXP, GetNumRewardCurrencies, GetRewardTitle, GetRewardMoney, GetNumQuestRewards, GetRewardSkillPoints;

Storyline_API.rewards = {};
local API = Storyline_API.rewards;

local OBJECTIVES_GETTERS;

local REWARDS_DEFAULT_ICON = [[Interface\ICONS\trade_archaeology_chestoftinyglassanimals]];

local BUCKET_TYPES = {
	RECEIVED = 1,
	CHOICE = 2,
	AURA = 3,
	FOLLOWER = 4,
	UNLOCK = 5,
	LEARN = 6,
	BONUS = 7,
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
	PLAYER_TITLE = 3,
	CURRENCY = 4,
	SKILL_POINTS = 5,
	ITEMS = 6,
	SPELL = 7,
	FOLLOWER = 8,
	BONUS = 9,
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

local QUEST_SESSION_BONUS_REWARD_ITEM_ID = 171305
local item = Item:CreateFromItemID(QUEST_SESSION_BONUS_REWARD_ITEM_ID)
local SALVAGED_CACHE_OF_GOODS = {}
if item then
	item:ContinueOnItemLoad(function()
		SALVAGED_CACHE_OF_GOODS = {
			text       = item:GetItemName(),
			icon       = item:GetItemIcon(),
			count      = 1,
			index      = 1,
			quality    = item:GetItemQuality(),
			rewardType = "reward",
			objectType = "questSessionBonusReward",
			isUsable   = true,
			itemId = QUEST_SESSION_BONUS_REWARD_ITEM_ID
		}
	end)
end

local REWARD_GETTERS = {
	[BUCKET_TYPES.RECEIVED] = {
		[REWARD_TYPES.XP] = function()
			local rewards = {};
			local xp = GetRewardXP();
			if xp > 0 then
				tinsert(rewards, {
					text         = BreakUpLargeNumbers(xp) .. " " .. XP,
					icon         = "Interface\\ICONS\\xp_icon",
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
		[REWARD_TYPES.PLAYER_TITLE] = function()
			local rewards = {};
			local playerTitle = GetRewardTitle();
			if playerTitle then
				tinsert(rewards, {
					text = playerTitle,
					icon = "Interface\\ICONS\\inv_scroll_11",
					tooltipTitle = playerTitle,
					tooltipSub = playerTitle
				});
			end
			return rewards;
		end,
		[REWARD_TYPES.CURRENCY] = function()
			local rewards = {};
			local currencyCount = GetNumRewardCurrencies();
			for i = 1, currencyCount, 1 do
				local name, texture, numItems, quality = GetQuestCurrencyInfo("reward", i);
				if name and texture and numItems then
					local currencyID = GetQuestCurrencyID("reward", i);
					name, texture, _, quality = CurrencyContainerUtil.GetCurrencyContainerInfo(currencyID, numItems, name, texture, quality);
					tinsert(rewards, {
						text  = name,
						icon  = texture,
						count = numItems,
						index = i,
						type  = "currency",
						quality = quality,
						currencyID = currencyID
					});
				end
			end
			return rewards;
		end,
		[REWARD_TYPES.SKILL_POINTS] = function()
			local rewards = {};
			local skillName, skillIcon, skillPoints = GetRewardSkillPoints();
			if skillPoints then
				skillName = skillName or "?";
				tinsert(rewards, {
					text         = BONUS_SKILLPOINTS:format(skillName),
					icon         = skillIcon,
					skillPoints  = skillPoints,
					type         = "skillpoint",
					tooltipTitle = format(BONUS_SKILLPOINTS_TOOLTIP, skillPoints, skillName),
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
		end,
		[REWARD_TYPES.BONUS] = function()
			local rewards = {}
			local questID = GetQuestID()
			if C_QuestLog.QuestHasWarModeBonus(questID) and C_PvP.IsWarModeDesired() then
				tinsert(rewards, {
					bonus = C_PvP.GetWarModeRewardBonus()
				})
			end
			return rewards
		end,
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

				-- Filter out already learned spell or garrison followers
				if texture and not knownSpell and (not isBoostSpell or IsCharacterNewlyBoosted()) and (not garrFollowerID or not IsFollowerCollected(garrFollowerID)) and not genericUnlock then
					-- Filter out tradeskill spells, boost spells, followers or spell learned, so we only have auras
					if not isTradeskillSpell and not isBoostSpell and not garrFollowerID and not isSpellLearned then
						tinsert(auraRewards, {
							text   			 = name,
							icon   			 = texture,
							spellID			 = spellID,
							rewardSpellIndex = rewardSpellIndex
						});
					end
				end
			end

			return auraRewards;
		end,
	},
	[BUCKET_TYPES.FOLLOWER] = {
		[REWARD_TYPES.FOLLOWER] = function()
			local followerRewards = {};
			local numberOfSpellRewards = GetNumRewardSpells();

			for rewardSpellIndex = 1, numberOfSpellRewards do
				local texture, name, _, _, _, isBoostSpell, garrFollowerID, _, spellID = GetRewardSpell(rewardSpellIndex);
				local knownSpell = IsSpellKnownOrOverridesKnown(spellID);

				-- Filter out already learned spell or garrison followers
				if texture and not knownSpell and (not isBoostSpell or IsCharacterNewlyBoosted()) and (not garrFollowerID or not IsFollowerCollected(garrFollowerID)) then
					-- If we have a follower ID then it is a follower
					if garrFollowerID then
						tinsert(followerRewards, {
							text   			 = name,
							icon   			 = texture,
							garrFollowerID   = garrFollowerID,
							rewardSpellIndex = rewardSpellIndex
						});
					end
				end
			end

			return followerRewards;
		end,
	},
	[BUCKET_TYPES.UNLOCK] = {
		[REWARD_TYPES.SPELL] = function()
			local auraRewards = {};
			local numberOfSpellRewards = GetNumRewardSpells();

			for rewardSpellIndex = 1, numberOfSpellRewards do
				local texture, name, isTradeskillSpell, isSpellLearned, hideSpellLearnText, isBoostSpell, garrFollowerID, genericUnlock, spellID = GetRewardSpell(rewardSpellIndex);
				local knownSpell = IsSpellKnownOrOverridesKnown(spellID);

				-- Filter out already learned spell or garrison followers
				if texture and genericUnlock then
					tinsert(auraRewards, {
						text   			 = name,
						icon   			 = texture,
						spellID			 = spellID,
						rewardSpellIndex = rewardSpellIndex
					});
				end
			end

			return auraRewards;
		end,
	},
	[BUCKET_TYPES.LEARN] = {
		[REWARD_TYPES.SPELL] = function()
			local auraRewards = {};
			local numberOfSpellRewards = GetNumRewardSpells();

			for rewardSpellIndex = 1, numberOfSpellRewards do
				local texture, name, isTradeskillSpell, isSpellLearned, hideSpellLearnText, isBoostSpell, garrFollowerID, genericUnlock, spellID = GetRewardSpell(rewardSpellIndex);
				local knownSpell = IsSpellKnownOrOverridesKnown(spellID);

				-- Filter out already learned spell or garrison followers
				if texture and isSpellLearned and not knownSpell then
					tinsert(auraRewards, {
						text   			 = name,
						icon   			 = texture,
						spellID			 = spellID,
						rewardSpellIndex = rewardSpellIndex
					});
				end
			end

			return auraRewards;
		end,
	},
	[BUCKET_TYPES.BONUS] = {
		[REWARD_TYPES.ITEMS] = function()
			local rewards = {}

			local questID = GetQuestID()
			local hasChanceForQuestSessionBonusReward = C_QuestLog.QuestHasQuestSessionBonus(questID)
			if hasChanceForQuestSessionBonusReward then
				tinsert(rewards, SALVAGED_CACHE_OF_GOODS)
			end

			return rewards
		end
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
	end,
	[REWARD_TYPES.CURRENCY] = function()
		local currencies = {};
		for i = 1, GetNumQuestCurrencies() do
			local name, texture, numItems = GetQuestCurrencyInfo("required", i);
			tinsert(currencies, {
				text = name,
				icon = texture,
				count = numItems,
				index = i,
				type = "currency",
				rewardType = "required",
			});
		end
		return currencies;
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