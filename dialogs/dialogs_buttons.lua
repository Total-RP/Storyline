----------------------------------------------------------------------------------
-- Storyline
-- Dialogs buttons API
--
-- This API will provide everything necessary to create and use dialogs button.
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

-- Librairies and local imports
local animationLib = LibStub:GetLibrary("TRP-Dialog-Animation-DB");
local tinsert, pairs, assert = tinsert, pairs, assert;
local CreateFrame = CreateFrame;
local after = C_Timer.After;
local LE_QUEST_FREQUENCY_DAILY, LE_QUEST_FREQUENCY_WEEKLY = LE_QUEST_FREQUENCY_DAILY, LE_QUEST_FREQUENCY_WEEKLY;

--- Insert values of table 2 inside table 1
-- @param tableInWhichValuesWillBeInserted
-- @param tableContainingValuesToInsert
--
local function merge(tableInWhichValuesWillBeInserted, tableContainingValuesToInsert)
	for key, value in pairs(tableContainingValuesToInsert)do
		tableInWhichValuesWillBeInserted[key] = value;
	end
end

-- Setting up our global API
Storyline_API.dialogs.buttons = {};
local API = Storyline_API.dialogs.buttons;
local Dialogs = Storyline_API.dialogs;

-- This table will contain the buttons we have already created
local buttonsBag = {};

local DIALOG_CHOICE_BUTTON_MARGIN = 5;
local DIALOG_CHOICE_BUTTON_PADDING = 25;

local BUTTON_TEMPLATE = "Storyline_DialogChoiceButton";

function API.getMargin()
	return DIALOG_CHOICE_BUTTON_MARGIN;
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- BUTTONS DECORATORS
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local GOSSIP_ICONS_TEXTURE_PATH = [[Interface\GossipFrame\%sGossipIcon]];

local function getIconTextureForGossipType(gossipType)
	return GOSSIP_ICONS_TEXTURE_PATH:format(gossipType);
end

local AVAILABLE_QUEST_ICONS_TEXTURE_PATHS = {
	DEFAULT   = [[Interface\GossipFrame\AvailableQuestIcon]],
	LEGENDARY = [[Interface\GossipFrame\AvailableLegendaryQuestIcon]],
	DAILY     = [[Interface\GossipFrame\DailyQuestIcon]]
}

local function getIconTextureForAvailableQuestType(frequency, isRepeatable, isLegendary)
	local questIcon = AVAILABLE_QUEST_ICONS_TEXTURE_PATHS.DEFAULT;
	if isLegendary then
		questIcon = AVAILABLE_QUEST_ICONS_TEXTURE_PATHS.LEGENDARY;
	elseif frequency == LE_QUEST_FREQUENCY_DAILY or frequency == LE_QUEST_FREQUENCY_WEEKLY or isRepeatable then
		questIcon = AVAILABLE_QUEST_ICONS_TEXTURE_PATHS.DAILY;
	end
	return questIcon;
end

local ACTIVE_QUEST_ICONS_TEXTURE_PATHS = {
	DEFAULT   = [[Interface\GossipFrame\ActiveQuestIcon]],
	LEGENDARY = [[Interface\GossipFrame\ActiveLegendaryQuestIcon]],
	DAILY     = [[Interface\GossipFrame\DailyActiveQuestIcon]]
}

local function getIconTextureForActiveQuestType(frequency, isRepeatable, isLegendary)
	local questIcon = ACTIVE_QUEST_ICONS_TEXTURE_PATHS.DEFAULT;
	if isLegendary then
		questIcon = ACTIVE_QUEST_ICONS_TEXTURE_PATHS.LEGENDARY;
	elseif frequency == LE_QUEST_FREQUENCY_DAILY or frequency == LE_QUEST_FREQUENCY_WEEKLY or isRepeatable then
		questIcon = ACTIVE_QUEST_ICONS_TEXTURE_PATHS.DAILY;
	end
	return questIcon;
end

local BUTTON_DECORATORS = {
	[Dialogs.BUCKET_TYPE.COMPLETED_QUEST] = function(button, data)
		button:SetText(data.title);
		button:SetIcon(getIconTextureForActiveQuestType(data.frequency, data.isRepeatable, data.isLegendary));
	end,
	[Dialogs.BUCKET_TYPE.AVAILABLE_QUEST] = function(button, data)
		button:SetText(data.title);
		button:SetIcon(getIconTextureForAvailableQuestType(data.frequency, data.isRepeatable, data.isLegendary));
		if data.isTrivial then
			button:GreyOutIcon();
		end
	end,
	[Dialogs.BUCKET_TYPE.GOSSIP] = function(button, data)
		button:SetText(data.title);
		button:SetIcon(getIconTextureForGossipType(data.gossipType));
	end,
	[Dialogs.BUCKET_TYPE.UNCOMPLETED_QUEST] = function(button, data)
		button:SetText(data.title);
		button:SetIcon("Interface\\GossipFrame\\IncompleteQuestIcon");
	end
}

-- Set of custom functions that will be given to our buttons
local BUTTON_API = {
	-- Refresh the height of the button by using the text height and adding padding
	-- We use this to make sure the height of the button adapts to multiline text
	RefreshHeight = function(button)
		button:SetHeight(button.text:GetHeight() + DIALOG_CHOICE_BUTTON_PADDING);
	end,
	-- Set the main text of the button
	SetText = function(button, text)
		button.text:SetText(text);
		-- We refresh the height of the button after change the text inside it to make sure
		-- the text does not overflow
		button:RefreshHeight();
	end,
	-- Play the fade in animation of the button
	FadeIn = function(button)
		button:Show();
		button.fadeIn:Play();
	end,
	-- Set the icon of the button
	SetIcon = function(button, texture)
		button.icon:SetTexture(texture);
	end,
	-- Grey out the icon of the button
	GreyOutIcon = function(button)
		button.icon:SetVertexColor(0.5, 0.5, 0.5);
	end,
	-- Set the biding text, on the left of the button
	SetBindingText = function(button, bindingText)
		button.binding:SetText(bindingText);
		button.binding:Show();
	end,
	-- Hide the binding text
	HideBidingText = function(button)
		button.binding:SetText("");
		button.binding:Hide();
	end,
	-- When the cursor is over a dialog choice we will play this dialog animation
	PlayPlayerModelAnimation = function(button)
		local animation;
		local playerModel = Storyline_NPCFrameModelsMe.model;
		-- Try to fetch the animation corresponding to the punctuation marks in the button's text
		button.text:GetText():gsub("[%.%?%!]+", function(finder)
			animation = animationLib:GetDialogAnimation(playerModel, finder:sub(1, 1));
		end);
		-- If we couldn't find any animation or punctuation marks we will use the normal talk animation instead.
		if not animation then
			animation = animationLib:GetDialogAnimation(playerModel, ".");
		end
		Storyline_API.playSelfAnim(animation);
	end,
	Decorate = function(self, buttonIndex, choiceIndex, data, bucketType, eventType)

		assert(BUTTON_DECORATORS[bucketType], ("No button decorator available for bucket type %s!"):format(bucketType or "NO_BUCKET_TYPE"));

		-- If the button index is withing the keyboard shortcuts limit and keyboard shortcuts are enabled
		-- we display the shortcut on the binding text.
		if buttonIndex < 10 and Storyline_Data.config.useKeyboard then
			self:SetBindingText(buttonIndex);
		else
			self:HideBidingText();
		end

		-- Use the appropriate decorator for the bucket type to display the data on the button
		BUTTON_DECORATORS[bucketType](self, data);
		-- Refresh the button height (for multiline text and padding)
		self:RefreshHeight();


		self:SetScript("OnClick", function()
			Dialogs.getDialogChoiceSelectorForEventType(eventType, bucketType)(choiceIndex);
		end)

		-- Buttons appear quickly one after the other in a fade-in animation
		after(0.05 * buttonIndex, function()
			self:FadeIn();
		end);
	end

}

local DEFAULT_ANCHOR_POINT = "BOTTOM";
local FIRST_OPTION_ANCHOR_POINT = "TOP";

function API.getButton(parent, anchor)

	local button;
	-- The anchor point of the button depends on whether  it is the first option or not
	local anchorPoint = anchor and DEFAULT_ANCHOR_POINT or FIRST_OPTION_ANCHOR_POINT;
	-- If there is no anchor (first option), the anchor is the parent
	if not anchor then
		anchor = parent;
	end

	-- First we try to fish for an existing button that is available
	for _, existingButton in pairs(buttonsBag) do
		if existingButton.isAvailable then
			-- We will use this button, it is no longer available
			existingButton.isAvailable = false;
			button = existingButton;
			break;
		end
	end

	-- If we couldn't find an existing button available, we create a new one
	if not button then
		-- Create a new frame using our frame template
		button = CreateFrame("Button", nil, parent, BUTTON_TEMPLATE);

		-- We insert our custom API inside the button
		merge(button, BUTTON_API);

		-- Insert this new button inside our buttons bag
		tinsert(buttonsBag, button);
	end

	-- Anchor the button to the given anchor
	button:SetPoint("TOP", anchor, anchorPoint, 0, -1 * DIALOG_CHOICE_BUTTON_MARGIN);

	return button;
end

-- Hide all buttons inside our buttons bag and make them available
function API.hideAllButtons()
	for _, existingButton in pairs(buttonsBag) do
		existingButton.isAvailable = true;
		existingButton:Hide();
	end
end