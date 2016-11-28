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

Storyline_API.rewards = {};

local BUCKET_TYPES = {
	RECEIVED = 1,
	CHOICE = 2
};
Storyline_API.rewards.BUCKET_TYPES = BUCKET_TYPES;

local REWARD_TYPES = {
	XP = 1,
	MONNEY = 2,
	PLAYER_TITLE = 3,
	CURRENCY = 4,
	SKILL_POINTS = 5,
	ITEMS = 6,
}
Storyline_API.rewards.REWARD_TYPES = REWARD_TYPES;

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
				local name, texture, numItems = GetQuestCurrencyInfo("reward", i);
				if name and texture and numItems then
					tinsert(rewards, {
						text  = name,
						icon  = texture,
						count = numItems,
						index = i,
						type  = "currency"
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
					count        = skillPoints,
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
			-- If there is only one choice, we already dealt with it in the getItemsReward() function
			if GetNumQuestChoices() == 1 then return end
			for i = 1, GetNumQuestChoices() do
				local name, texture, numItems, quality, isUsable = GetQuestItemInfo("choice", i);
				tinsert(choices, {
					text = name,
					icon = texture,
					count = numItems,
					index = i,
					rewardType = "choice",
					isUsable = isUsable,
				});
			end
			return choices;
		end
	}
}

function Storyline_API.rewards.getRewards()
	local rewardsBucket = {}

	for _, bucketType in pairs(BUCKET_TYPES) do
		rewardsBucket[bucketType] = {};
		for _, rewardType in pairs(REWARD_TYPES) do
			if REWARD_GETTERS[bucketType] and REWARD_GETTERS[bucketType][rewardType] then
				rewardsBucket[bucketType][rewardType] = REWARD_GETTERS[bucketType][rewardType]();
			end
		end
	end

	return rewardsBucket;
end

