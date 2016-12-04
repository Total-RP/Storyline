----------------------------------------------------------------------------------
-- Storyline
-- Rewards buttons API
--
-- This API will provide everything necessary to create and display rewards button.
--
-- ---------------------------------------------------------------------------
-- Copyright 2016 Renaud "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
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

local assert, tinsert, pairs = assert, tinsert, pairs;
local CreateFrame = CreateFrame;
local debug = Storyline_API.debug;
local tsize = Storyline_API.lib.tsize;

Storyline_API.rewards.buttons = {};
local API = Storyline_API.rewards.buttons;
local Rewards = Storyline_API.rewards;

local function decorateItemButton(button, index, type, texture, name, numItems, isUsable)
	numItems = numItems or 0;
	button.index = index;
	button.type = type;
	button.Icon:SetTexture(texture);
	button.Name:SetText(name or RETRIEVING_DATA);
	button.Count:SetText(numItems > 1 and numItems or "");
	if not isUsable then
		button.Icon:SetVertexColor(1, 0, 0);
	end
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetQuestItem(self.type, self.index);
		GameTooltip_ShowCompareItem(GameTooltip);
	end);
	button:SetScript("OnClick", function(self)
		local itemLink = GetQuestItemLink(self.type, self.index);
		if not HandleModifiedItemClick(itemLink) and self.type == "choice" then
			GetQuestReward(self.index);
			autoEquip(itemLink);
			autoEquipAllReward();
		end
	end);
end

local function decorateCurrencyButton(button, index, type, texture, name, numItems)
	numItems = numItems or 0;
	button.index = index;
	button.type = type;
	button.Icon:SetTexture(texture);
	button.Name:SetText(name);
	button.Count:SetText(numItems > 1 and numItems or "");
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetQuestCurrency(self.type, self.index);
	end);
	button:SetScript("OnClick", nil);
end

local function decorateStandardButton(button, texture, name, tt, ttsub, isNotUsable)
	button.Icon:SetTexture(texture);
	button.Name:SetText(name);
	button.Count:SetText("");
	if isNotUsable then
		button.Icon:SetVertexColor(1, 0, 0);
	end
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:AddLine("|cffffffff" .. tt);
		if ttsub then
			GameTooltip:AddLine("|cffffffff" .. ttsub);
		end
		GameTooltip:Show();
	end);
	button:SetScript("OnClick", nil);
end

local function decorateSkillPointButton(button, texture, name, skillPoints)
	button.Name:SetFormattedText(BONUS_SKILLPOINTS, name);
	button.tooltip = format(BONUS_SKILLPOINTS_TOOLTIP, skillPoints, name);
	button.Icon:SetTexture(texture);
	button.Name:SetText(name);
	button.ValueText:SetText(skillPoints);
	-- Hacks to get this to display a little more nicely
	button.Name:SetPoint("LEFT", button.NameFrame, 20, 0);
	button.Name:SetWidth(81);
end

local function decorateSpellButton(button, texture, name, rewardSpellIndex)
	button.Icon:SetTexture(texture);
	button.Name:SetText(name);
	button.rewardSpellIndex = rewardSpellIndex;
end

local function decorateFollowerButton(button, garrFollowerID)
	local followerInfo = C_Garrison.GetFollowerInfo(garrFollowerID);
	button.Name:SetText(followerInfo.name);
	button.Class:SetAtlas(followerInfo.classAtlas);
	button.PortraitFrame:SetupPortrait(followerInfo);
	button.ID = garrFollowerID;

	button:SetScript("OnLeave", function(self)
		GarrisonFollowerTooltip:Hide();
	end)
end

local function decorateRewardButton(button, rewardType, reward)
	if rewardType == Rewards.REWARD_TYPES.XP or rewardType == Rewards.REWARD_TYPES.MONNEY then
		decorateStandardButton(button, reward.icon, reward.text, reward.tooltipTitle, reward.tooltipSub);
	elseif rewardType == Rewards.REWARD_TYPES.CURRENCY then
		decorateCurrencyButton(button, reward.index, "reward", reward.icon, reward.text, reward.count);
	elseif rewardType == Rewards.REWARD_TYPES.SPELL then
		decorateSpellButton(button, reward.icon, reward.text, reward.rewardSpellIndex);
	elseif rewardType == Rewards.REWARD_TYPES.ITEMS then
		decorateItemButton(button, reward.index, reward.rewardType, reward.icon, reward.text, reward.count, reward.isUsable);
	elseif rewardType == Rewards.REWARD_TYPES.FOLLOWER then
		decorateFollowerButton(button, reward.garrFollowerID);
	elseif rewardType == Rewards.REWARD_TYPES.SKILL_POINTS then
		decorateSkillPointButton(button, reward.icon, reward.text, reward.skillPoints);
	end
end

local gridHeight, gridCount;
local previousElementOnTheLeft;
local BUTTON_MARGIN_TOP = 5;
local BUTTON_MARGIN_LEFT = 10;
local GRID_ITEM_ANCHOR_POINT = "TOPLEFT";
local NEW_LINE_ANCHOR_POINT = "BOTTOMLEFT";
local NEXT_TO_PREVIOUS_BUTTON_ANCHOR_POINT = "TOPRIGHT";

local function placeOnGrid(button, initialPlacement)
	-- We will use the previous grid element on the left as an anchor or the frame given if there is no element yet
	previousElementOnTheLeft = previousElementOnTheLeft or initialPlacement;

	-- If we have an even number of elements inside the grid or the previous element is large or the current element is large
	-- we need to create a new line
	if gridCount % 2 == 0 or previousElementOnTheLeft.isLargeButton or button.isLargeButton then
		button:SetPoint(GRID_ITEM_ANCHOR_POINT, previousElementOnTheLeft, NEW_LINE_ANCHOR_POINT, 0, -1 * BUTTON_MARGIN_TOP);
		gridHeight = gridHeight + button:GetHeight() + BUTTON_MARGIN_TOP;
		previousElementOnTheLeft = button;

	else
		-- otherwise the button goes on the right of the previous button
		button:SetPoint(GRID_ITEM_ANCHOR_POINT, previousElementOnTheLeft, NEXT_TO_PREVIOUS_BUTTON_ANCHOR_POINT, BUTTON_MARGIN_LEFT, 0);
	end

	gridCount = gridCount + 1;
end

local function resetGrid()
	previousElementOnTheLeft = nil;
	gridHeight = 0;
	gridCount = 0;
end

local REWARDS_BUTTON_FRAME_NAME = "Storyline_RewardButton";
local REWARD_BUTTON_FRAME_TEMPLATES = {
	DEFAULT = "LargeItemButtonTemplate",
	[Rewards.REWARD_TYPES.SPELL] = "QuestSpellTemplate, QuestInfoRewardSpellCodeTemplate",
	[Rewards.REWARD_TYPES.SKILL_POINTS] = "Storyline_SkillPointsRewardTemplate",
	[Rewards.REWARD_TYPES.FOLLOWER] = "Storyline_GarrisonFollowerRewardTemplate",
}
-- List of large button types, so we know to only place one of them per line instead of two (titles, followers)
local LARGE_BUTTONS = {
	[Rewards.REWARD_TYPES.SPELL] = true, -- Spell buttons have decorations that adds width to the frame, we can't have 2 on the same line
	--[Rewards.REWARD_TYPES.FOLLOWER] = true, -- Follower buttons are really different and need an entire line
}
local itemButtons = {};
local function getRewardButton(parentFrame, rewardType)
	local button;

	if not itemButtons[rewardType] then
		itemButtons[rewardType] = {};
	end

	for _, existingButton in pairs(itemButtons[rewardType]) do
		if existingButton.isAvailable then
			existingButton.isAvailable = false;
			button = existingButton;
			break;
		end
	end
	if not button then
		-- Create a new button using the appropriate template
		button = CreateFrame("Button", REWARDS_BUTTON_FRAME_NAME .. #itemButtons, nil, REWARD_BUTTON_FRAME_TEMPLATES[rewardType] or REWARD_BUTTON_FRAME_TEMPLATES.DEFAULT);
		-- Save inside the button structure if it is a large button type
		button.isLargeButton = LARGE_BUTTONS[rewardType] == true;
		-- TODO Improve this. Maybe have our own virtual frame that already have this script
		button:SetScript("OnLeave", function(self)
			GameTooltip:Hide();
		end);
		tinsert(itemButtons[rewardType], button);
	end
	button:SetParent(parentFrame);
	-- TODO Do not show the button immediately for animations ? Remplace IsShown() up there by .available
	button:Show();
	return button;
end

function API.getPreviousElementOnTheLeft()
	return previousElementOnTheLeft;
end

local REWARDS_HEADER_TEMPLATE = "Storyline_RewardsHeader";
local REWARDS_HEADER_NAME = "Storyline_RewardsHeader";
local REWARDS_HEADER_MARGIN = 5;

-- TODO Add more bucket types (followers, spell learned or targeted)
local REWARDS_HEADER_TEXT = {
	[Rewards.BUCKET_TYPES.RECEIVED] = REWARD_ITEMS_ONLY,
	[Rewards.BUCKET_TYPES.CHOICE] = REWARD_CHOICES,
	[Rewards.BUCKET_TYPES.AURA] = REWARD_AURA,
	[Rewards.BUCKET_TYPES.FOLLOWER] = REWARD_FOLLOWER,
};

local rewardsHeadersBag = {};
local function getRewardsHeader(parent, previousText)
	local header;

	if not rewardsHeadersBag[parent] then
		rewardsHeadersBag[parent] = {}
	end

	-- First we try to fish for an existing header that is available
	for _, existingHeader in pairs(rewardsHeadersBag[parent]) do
		if existingHeader.isAvailable then
			existingHeader.isAvailable = false;
			header = existingHeader;
			break;
		end
	end

	-- If we couldn't find an existing header available, we create a new one
	if not header then
		-- Create a new frame using our frame template
		header = parent:CreateFontString(REWARDS_HEADER_NAME .. #rewardsHeadersBag[parent], nil, REWARDS_HEADER_TEMPLATE);

		-- Insert this new button inside our buttons bag
		tinsert(rewardsHeadersBag[parent], header);
	end

	-- Anchor the header either on the previous grid button on the left if there's one, or on the previous text
	-- given to the function (objective text, rewards title, etc.)
	header:SetPoint("TOPLEFT", API.getPreviousElementOnTheLeft() or previousText, "BOTTOMLEFT", 0, -1 * REWARDS_HEADER_MARGIN);

	return header;
end

function API.displayRewardsOnGrid(rewardBucketType, rewardsBucket, parent, previousText, bindClickingOnChoosingReward)
	assert(REWARDS_HEADER_TEXT[rewardBucketType], ("No header text defined for reward bucket type %s!"):format(rewardBucketType or "NO_BUCKET_TYPE"));

	-- Get a header and use the apprioriate text for this reward bucket type (rewards, choices, spells, etc.)
	local header = getRewardsHeader(parent, previousText);
	header:SetText(REWARDS_HEADER_TEXT[rewardBucketType]);
	header:Show();

	local previousAnchor = header;
	resetGrid();
	for rewardType, rewards in pairs(rewardsBucket) do
		for _, reward in pairs(rewards) do
			local button = getRewardButton(parent, rewardType);
			placeOnGrid(button, previousAnchor);
			decorateRewardButton(button, rewardType, reward);

			-- If the reward is a choice and we were ask to bind the clicking event to choosing the reward
			-- we set it's OnClick script
			if rewardBucketType == Storyline_API.rewards.BUCKET_TYPES.CHOICE and bindClickingOnChoosingReward then
				-- TODO Set click script to choose reward
			end
			previousAnchor = button;
		end
	end

	return gridHeight + header:GetHeight() + REWARDS_HEADER_MARGIN;
end

function API.hideAllButtons()

	resetGrid();

	for _, headersBag in pairs(rewardsHeadersBag) do
		for _, existingHeader in pairs(headersBag) do
			existingHeader:Hide();
			existingHeader:ClearAllPoints();
			existingHeader.isAvailable = true;
		end
	end

	for _, buttonBag in pairs(itemButtons) do
		for _, button in pairs(buttonBag) do
			button:Hide();
			button.isAvailable = true;
			button:ClearAllPoints();
			if button.Icon then
				button.Icon:SetVertexColor(1, 1, 1);
			end
		end
	end
end