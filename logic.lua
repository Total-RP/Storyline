----------------------------------------------------------------------------------
-- Storyline
-- ---------------------------------------------------------------------------
-- Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
-- Copyright 2015 Renaud "Ellypse" Parize (ellypse@totalrp3.info)
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
local Ellyb = Ellyb(...);

-- Storyline API
local wipe, tContains = wipe, tContains;
local UnitGUID = UnitGUID;
local setTooltipForSameFrame, setTooltipAll = Storyline_API.lib.setTooltipForSameFrame, Storyline_API.lib.setTooltipAll;
local loc, tsize = Storyline_API.locale.getText, Storyline_API.lib.tsize;
local playNext = Storyline_API.playNext;
local showStorylineFrame = Storyline_API.layout.showStorylineFrame;
local hideStorylineFrame = Storyline_API.layout.hideStorylineFrame;
local strtrim = strtrim;
local insert = table.insert;

-- WOW API
local strsplit, pairs, tostring = strsplit, pairs, tostring;
local UnitIsUnit, UnitExists, UnitName = UnitIsUnit, UnitExists, UnitName;
local IsAltKeyDown, IsShiftKeyDown, IsControlKeyDown = IsAltKeyDown, IsShiftKeyDown, IsControlKeyDown;
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory;

-- UI
local mainFrame = Storyline_NPCFrame;
---@type Storyline_PlayerModelMixin
local targetModel = mainFrame.models.you;
targetModel.isModelDisplayedOnLeft = false;
---@type Storyline_PlayerModelMixin
local playerModel = mainFrame.models.me;

local scalingLib = LibStub:GetLibrary("TRP-Dialog-Scaling-DB");
local scalingDB, customHeightDB, customPersonalDB;

-- Constants
local LINE_FEED_CODE = string.char(10);
local CARRIAGE_RETURN_CODE = string.char(13);
local WEIRD_LINE_BREAK = LINE_FEED_CODE .. CARRIAGE_RETURN_CODE .. LINE_FEED_CODE;
local CHAT_MARGIN = 70;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- DATA SAVING & RESTORING
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

---
-- Get the scaling structures (saved and defaults)
-- @param modelMeID
-- @param modelYouID
--
local function getScalingStuctures(modelMeID, modelYouID)
	local key, invertedKey = scalingLib:GetModelKeys(modelMeID, modelYouID);
	local dataMe, dataYou = scalingLib:GetModelCoupleProperties(modelMeID, modelYouID);

	-- Custom height
	if customHeightDB[key] then
		dataMe.scale = customHeightDB[key][1];
		dataYou.scale = customHeightDB[key][2];
	elseif customHeightDB[invertedKey] then
		dataMe.scale = customHeightDB[invertedKey][2];
		dataYou.scale = customHeightDB[invertedKey][1];
	end

	-- Custom attributes
	if customPersonalDB[modelMeID] then
		for field, value in pairs(customPersonalDB[modelMeID]) do
			dataMe[field] = value;
		end
	end
	if customPersonalDB[modelYouID] then
		for field, value in pairs(customPersonalDB[modelYouID]) do
			dataYou[field] = value;
		end
	end

	return dataMe, dataYou;
end

---
-- Reset a scaling field in the saved structures for a modelID tuple.
-- @param field typically "me" or "you"
--
local function resetStructure()
	local key, invertedKey = scalingLib:GetModelKeys(playerModel:GetModelFileIDAsString(), targetModel:GetModelFileIDAsString());

	-- Reset custom heights
	for _, value in pairs({key, invertedKey}) do
		if customHeightDB[value] then
			wipe(customHeightDB[value]);
			customHeightDB[value] = nil;
		end
	end

	-- Reset custom attributes
	if customPersonalDB[playerModel:GetModelFileIDAsString()] then
		wipe(customPersonalDB[playerModel:GetModelFileIDAsString()]);
		customPersonalDB[playerModel:GetModelFileIDAsString()] = nil;
	end
	if customPersonalDB[targetModel:GetModelFileIDAsString()] then
		wipe(customPersonalDB[targetModel:GetModelFileIDAsString()]);
		customPersonalDB[targetModel:GetModelFileIDAsString()] = nil;
	end
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- LOADING & START DIALOG
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
---
-- Called when the two models are loaded.
-- This method initializes all scaling parameters.
--
local function modelsLoaded()
	playerModel:ResetIdleAnimationID();
	targetModel:ResetIdleAnimationID();

	local dataMe, dataYou = getScalingStuctures(playerModel:GetModelFileIDAsString(), targetModel:GetModelFileIDAsString());

	-- Configuration for model Me.
	if playerModel.doNotAnimateScaling then
		playerModel:SetScalingValuesIn(dataMe.scale, dataMe.feet, dataMe.offset, dataMe.facing);
		playerModel.doNotAnimateScaling = false;
	else
		playerModel:AnimateScalingValuesIn(dataMe.scale, dataMe.feet, dataMe.offset, dataMe.facing);
	end

	-- Configuration for model You, if available.
	if targetModel:GetModelFileIDAsString() then
		if targetModel.doNotAnimateScaling then
			targetModel:SetScalingValuesIn(dataYou.scale, dataYou.feet, dataYou.offset, dataYou.facing);
			targetModel.doNotAnimateScaling = false;
		else
			targetModel:AnimateScalingValuesIn(dataYou.scale, dataYou.feet, dataYou.offset, dataYou.facing);
		end
		Storyline_NPCFrameChat.bubbleTail:Show();
	else
		-- If there is no You model, play the read animation for the Me model.
		playerModel:SetCustomIdleAnimationID(Storyline_API.ANIMATIONS.READING);
		playerModel:ApplySpellVisualKit(29521, false)
		Storyline_NPCFrameChat.bubbleTail:Hide();
		playerModel:PlayIdleAnimation();
	end

	-- Place the modelIDs in the debug frame
	if targetModel:GetModelFileIDAsString() then
		mainFrame.debug.you:SetText(targetModel:GetModelFileIDAsString());
	end
	if playerModel:GetModelFileIDAsString() then
		mainFrame.debug.me:SetText(playerModel:GetModelFileIDAsString());
	end

	mainFrame.debug.recorded:Hide();
	if scalingLib:IsRecorded(playerModel:GetModelFileIDAsString(), targetModel:GetModelFileIDAsString()) then
		mainFrame.debug.recorded:Show();
	end
end
Storyline_API.onModelsLoaded = modelsLoaded;
playerModel.ModelLoaded = modelsLoaded;
targetModel.ModelLoaded = modelsLoaded;

local SLIDE_IN = 0.2;
local function setModelsAlpha(value)
	local slideInValue = SLIDE_IN - (SLIDE_IN * value);
	targetModel:SetAlpha(value);
	playerModel:SetAlpha(value);
	playerModel:SetPosition(nil, slideInValue * -1)
	targetModel:SetPosition(nil, slideInValue);
end

local alphaTransitionator = Ellyb.Transitionator();
local function animateInModels()
	alphaTransitionator:RunValue(0, 1, 0.5, setModelsAlpha)
end

---@type StorylineBackgroundTexture
local background = mainFrame.Background
---
-- Start a dialog with unit ID targetType
-- @param targetType
-- @param fullText
-- @param event
-- @param eventInfo
--
function Storyline_API.startDialog(targetType, fullText, event, eventInfo)

	local questId = GetQuestID()
	background:RefreshBackground()

	mainFrame.debug.text:SetText(event);

	mainFrame.models.you.npc_id = Storyline_API.getNpcId();

	if Storyline_API.isASealedQuest(questId) then
		mainFrame.chat.name:Hide()
	else
		local targetName = UnitName(targetType) or ""
		if (not targetName or targetName:len() > 0 or targetName ~= UNKNOWN) and eventInfo.nameGetter and eventInfo.nameGetter() then
			targetName = eventInfo.nameGetter()
		end
		mainFrame.chat.name:SetText(targetName)
		mainFrame.chat.name:Show()
	end


	if eventInfo.titleGetter and eventInfo.titleGetter() and eventInfo.titleGetter():len() > 0 then
		mainFrame.Banner:Show();

		if C_CampaignInfo.IsCampaignQuest(questId) then
			local faction = UnitFactionGroup("player");
			if faction == "Horde" then
				mainFrame.Banner.FactionIcon:SetAtlas("bfa-landingbutton-horde-up")
			else
				mainFrame.Banner.FactionIcon:SetAtlas("bfa-landingbutton-alliance-up")
			end
			mainFrame.Banner.FactionIcon:Show()
		else
			mainFrame.Banner.FactionIcon:Hide()
		end

		mainFrame.Banner.Title:SetText(eventInfo.titleGetter());
		if eventInfo.getTitleColor and eventInfo.getTitleColor() then
			mainFrame.Banner.Title:SetTextColor(eventInfo.getTitleColor());
		else
			mainFrame.Banner.Title:SetTextColor(0.95, 0.95, 0.95);
		end
	else
		mainFrame.Banner.FactionIcon:Hide()
		mainFrame.Banner:Hide();
	end

	-- Load player in the left model
	local playerModelLoading = playerModel:SetModelUnit("player", false);

	-- Load unit in the right model
	local targetModelLoading;
	if UnitExists(targetType) and not UnitIsUnit("player", "npc") then
		targetModelLoading = targetModel:SetModelUnit(targetType, false);
	else
		targetModelLoading = targetModel:SetModelUnit("none", false);
	end

	local modelsLoading = Ellyb.Promises.all({ playerModelLoading, targetModelLoading }):Always(modelsLoaded);

	fullText = fullText:gsub(LINE_FEED_CODE .. "+", "\n");
	fullText = fullText:gsub(WEIRD_LINE_BREAK, "\n");

	local texts = {};
	-- Don't use lines that just contains spaces (because of Blizzard's interns)
	for _, text in pairs({ strsplit("\n", fullText) }) do
		if strtrim(text) ~= "" then
			insert(texts, text);
		end
	end

	if texts[#texts] and texts[#texts]:len() == 0 then
		texts[#texts] = nil;
	end

	-- Support for multi-paragraph emotes
	local stillEmote = { false };
	for index, text in pairs(texts) do
		if index < #texts then
			local prevEmote = stillEmote[index];
			local currentEmote = prevEmote;

			local _, openEmoteCount = text:gsub("<", "<");
			local _, closeEmoteCount = text:gsub(">", ">");

			if prevEmote and openEmoteCount < closeEmoteCount then
				currentEmote = false;
			elseif not prevEmote and openEmoteCount > closeEmoteCount then
				currentEmote = true;
			end

			stillEmote[index + 1] = currentEmote;
		end
	end

	mainFrame.chat.texts = texts;
	mainFrame.chat.currentIndex = 0;
	mainFrame.chat.eventInfo = eventInfo;
	mainFrame.chat.event = event;
	mainFrame.chat.stillEmote = stillEmote;
	Storyline_NPCFrameObjectivesContent:Hide();
	mainFrame.chat.previous:Hide();

	if not mainFrame:IsVisible() then
		playerModel.doNotAnimateScaling = true;
		targetModel.doNotAnimateScaling = true;
		showStorylineFrame();
		modelsLoading:Always(animateInModels);
	end

	playNext(mainFrame.models.you);
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- TEXT ANIMATION
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local ANIMATION_TEXT_SPEED = 80;

local function onUpdateChatText(self, elapsed)
	if self.start and mainFrame.chat.text:GetText() and mainFrame.chat.text:GetText():len() > 0 then
		self.start = self.start + (elapsed * (ANIMATION_TEXT_SPEED * Storyline_Data.config.textSpeedFactor or 0.5));
		if Storyline_Data.config.textSpeedFactor == 0 or self.start >= mainFrame.chat.text:GetText():len() then
			self.start = nil;
			mainFrame.chat.text:SetAlphaGradient(mainFrame.chat.text:GetText():len(), 1);
		else
			mainFrame.chat.text:SetAlphaGradient(self.start, 30);
		end
	end
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- DEBUG
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function saveCustomHeight(me, scale)
	-- Getting custom structure or creating it
	local key, invertedKey = scalingLib:GetModelKeys(playerModel:GetModelFileIDAsString(), targetModel:GetModelFileIDAsString());

	if not customHeightDB[key] and customHeightDB[invertedKey] then
		-- We swap me/you as it is inverted
		customHeightDB[invertedKey][me and 2 or 1] = scale;
	else
		if not customHeightDB[key] then
			customHeightDB[key] = {};
		end
		customHeightDB[key][me and 1 or 2] = scale;
	end

end

local function saveCustomIndependantScaling(meYou, field, value)
	local model = meYou == "me" and playerModel:GetModelFileIDAsString() or targetModel:GetModelFileIDAsString();

	if not customPersonalDB[model] then
		customPersonalDB[model] = {};
	end
	customPersonalDB[model][field] = value;
end

---@param self Storyline_PlayerModelMixin
local function onFrameScrolled(self, delta)
	if IsAltKeyDown() then
		local scale = self.scale - (IsShiftKeyDown() and 0.1 or 0.01) * delta;
		self:SetModelHeight(scale);
		saveCustomHeight(self.isModelDisplayedOnLeft, scale);
	elseif IsControlKeyDown() then
		local facing = self.facing - (IsShiftKeyDown() and 0.2 or 0.02) * delta;
		self:SetModelFacing(facing)
		saveCustomIndependantScaling(self.isModelDisplayedOnLeft, "facing", facing);
	end
end

local function debugInit()
	if not Storyline_Data.config.debug then
		mainFrame.debug:Hide();
	end
	Storyline_NPCFrameDebugMeResetButton:SetScript("OnClick", function(self)
		resetStructure();
		modelsLoaded();
	end);

	-- Scrolling on the 3D model frame to adjust the size of the models
	for _, meYou in pairs({"me", "you"}) do
		mainFrame.models[meYou].scroll:EnableMouseWheel(true);
		mainFrame.models[meYou].scroll:SetScript("OnMouseWheel", function(self, delta)
			onFrameScrolled(mainFrame.models[meYou], delta);
		end);
		mainFrame.models[meYou].scroll:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		mainFrame.models[meYou].scroll:SetScript("OnClick", function(self, button)
			if IsAltKeyDown() then
				local offset = mainFrame.models[meYou].offset - (button == "LeftButton" and 1 or -1) * (IsShiftKeyDown() and 0.1 or 0.01);
				scalingLib:SetModelOffset(offset, mainFrame.models[meYou], meYou == "me");
				saveCustomIndependantScaling(meYou, "offset", offset);
			elseif IsControlKeyDown() then
				local feet = mainFrame.models[meYou].feet - (button == "LeftButton" and 1 or -1) * (IsShiftKeyDown() and 0.1 or 0.01);
				scalingLib:SetModelFeet(feet, mainFrame.models[meYou]);
				saveCustomIndependantScaling(meYou, "feet", feet);
			end
		end);
	end

	mainFrame.debug.dump.dump:SetScript("OnClick", function()
		local info =
[[["%s~%s"] = {
  ["me"] = {
    ["scale"] = %s,
    ["feet"] = %s,
    ["offset"] = %s,
    ["facing"] = %s,
  },
  ["you"] = {
    ["scale"] = %s,
    ["feet"] = %s,
    ["offset"] = %s,
    ["facing"] = %s,
	}
},]]
		local formatted = info:format(
			playerModel:GetModelFileIDAsString(),
			targetModel:GetModelFileIDAsString(),
			mainFrame.models.me.scale, mainFrame.models.me.feet, mainFrame.models.me.offset, mainFrame.models.me.facing,
			mainFrame.models.you.scale, mainFrame.models.you.feet, mainFrame.models.you.offset, mainFrame.models.you.facing
		);
		mainFrame.debug.dump.scroll.text:SetText(formatted);
	end);

	-- Debug for scaling
	Storyline_API.addon:RegisterChatCommand("storydebug", function()
		Storyline_API.startDialog("target", "Pouic", "SCALING_DEBUG", Storyline_API.EVENT_INFO.SCALING_DEBUG);
	end);

	setTooltipAll(Storyline_NPCFrameDebugMeResetButton, "TOP", 0, 0, "Reset values for these models"); -- Debug, not localized
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- INIT
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function closeDialog()
	if mainFrame.chat.eventInfo and mainFrame.chat.eventInfo.cancelMethod then
		mainFrame.chat.eventInfo.cancelMethod();
	end
	hideStorylineFrame();
end

local function resetDialog()
	Storyline_NPCFrameObjectivesContent:Hide();
	mainFrame.chat.currentIndex = 0;
	playNext(Storyline_NPCFrameModelsYou);
end

function Storyline_API.goBackToPreviousStep()
	Storyline_NPCFrameObjectivesContent:Hide();
	mainFrame.chat.currentIndex = mainFrame.chat.currentIndex - 2;
	playNext(Storyline_NPCFrameModelsYou);
end

Storyline_API.addon = LibStub("AceAddon-3.0"):NewAddon("Storyline", "AceConsole-3.0");

---@return string Returns the NPC ID of the current "npc" unit
function Storyline_API.getNpcId()
	local npcId = select(6, strsplit("-", UnitGUID("npc") or ""));
	return npcId;
end

---@return boolean Returns true if the current dialog NPC has been blacklisted
function Storyline_API.isCurrentNPCBlacklisted()
	return Storyline_Data.npc_blacklist[Storyline_API.getNpcId()] ~= nil
end

function Storyline_API.addon:OnEnable()

	if not Storyline_Data then
		Storyline_Data = {};
	end

	if not Storyline_Data.customscale then
		Storyline_Data.customscale = {};
	end
	if not Storyline_Data.customscale.relative then
		Storyline_Data.customscale.relative = {};
	end
	if not Storyline_Data.customscale.personal then
		Storyline_Data.customscale.personal = {};
	end
	scalingDB = Storyline_Data.customscale;
	customHeightDB = Storyline_Data.customscale.relative;
	customPersonalDB = Storyline_Data.customscale.personal;

	if not Storyline_Data.config then
		Storyline_Data.config = {};
	end
	if not Storyline_Data.npc_blacklist then
		Storyline_Data.npc_blacklist = {};
	end

	-- List of IDs for NPCs that are buggy when ForceGossip returns true
	local NPC_IDS_WITH_BROKEN_DIALOGS = {
		-- WoD
		["94399"]  = true, -- Garrison mission table

		-- Legion
		["110725"] = true, -- Archon Torias (Priests order hall)
		["108018"] = true, -- Archivist Melinda (Warlocks order hall)
		["108050"] = true, -- Survivalist Bahn (Hunters order hall)
		["110599"] = true, -- Loramus Thalipedes (Demon hunters order hall)
		["108527"] = true, -- Loramus Thalipedes (Demon hunters order hall) again
		["107994"] = true, -- Einar the Runecaster (Warriors order hall)
		["108331"] = true, -- Chronicler Elrianne (Mages order hall)
		["109901"] = true, -- Sir Alamande Graythorn (Paladins order hall)
		["112199"] = true, -- Journeyman Goldmine (Shamans order hall)
		["97485"]  = true, -- Archivist Zubashi (Death knights order hall)
		["98939"]  = true, -- Number Nine Jia (Monks order hall)
		["105998"] = true, -- Winstone Wolfe (Rogues order hall)
		["97989"]  = true, -- Leafbeard the Storied (Druids order hall)
		["105998"] = true, -- Winstone Wolfe (Rogues order hall)
		["97389"]  = true, -- Eye of Odyn

		-- BfA
		["139522"]  = true, -- Scouting map Alliance
		["143968"]  = true, -- Island expeditions map Alliance
		["143967"]  = true, -- Island expeditions map Port of Zandalar, Zuldazar
	}

	ForceGossip = function()
		-- return if the option is enabled and check if the NPC's dialog is not buggy
		local npcId = Storyline_API.getNpcId();
		return Storyline_Data.config.forceGossip and not NPC_IDS_WITH_BROKEN_DIALOGS[npcId] and not Storyline_API.isCurrentNPCBlacklisted();
	end

	Storyline_API.locale.init();

	mainFrame.chat.next:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp");
	mainFrame.chat.next:SetScript("OnClick", function(self, button)
		if button == "RightButton" then
			-- If we are not already on the last text, jump to it
			if mainFrame.chat.currentIndex < #mainFrame.chat.texts then
				mainFrame.chat.currentIndex = #mainFrame.chat.texts - 1; -- Set current text index to the one before the last one
				playNext(mainFrame.models.you); -- Play the next text (the last one)
			else
				-- If we were on the last text, use playNext to trigger the finish method (best available action)
				playNext(mainFrame.models.you);
			end
		elseif button == "MiddleButton" then
			closeDialog();
		else
			if mainFrame.chat.start and mainFrame.chat.start < mainFrame.chat.text:GetText():len() then
				mainFrame.chat.start = mainFrame.chat.text:GetText():len();
			else
				playNext(mainFrame.models.you);
			end
		end
	end);
	mainFrame.chat.previous:SetScript("OnClick", resetDialog);
	mainFrame.chat:SetScript("OnUpdate", onUpdateChatText);
	Storyline_NPCFrameClose:SetScript("OnClick", closeDialog);
	Storyline_NPCFrameRewardsItem:SetScale(1.5);

	Storyline_NPCFrameBlacklistButton:SetScript("OnClick", function()
		Storyline_Data.npc_blacklist[Storyline_API.getNpcId()] = true;
		SelectGossipOption(1);
	end)
	Ellyb.Tooltips.getTooltip(Storyline_NPCFrameBlacklistButton)
		:SetTitle(loc("SL_BYPASS_NPC"))
		:AddLine(loc("SL_BYPASS_NPC_TT"))
		:SetAnchor(Ellyb.Tooltips.ANCHORS.BOTTOMLEFT)
		:SetOffset(10, 10)

	mainFrame:SetScript("OnKeyDown", function(self, key)
		if not Storyline_Data.config.useKeyboard then
			self:SetPropagateKeyboardInput(true);
			return;
		end

		if key == "SPACE" then
			self:SetPropagateKeyboardInput(false);
			mainFrame.chat.next:Click(IsShiftKeyDown() and "RightButton" or "LeftButton");
		elseif key == "BACKSPACE" then
			self:SetPropagateKeyboardInput(false);
			mainFrame.chat.previous:Click();
		elseif key == "ESCAPE" then
			closeDialog();
		else
			local keyNumber = tonumber(key);
			if not keyNumber or not Storyline_API.dialogs.buttons.selectOptionAtIndex(keyNumber) then
				self:SetPropagateKeyboardInput(true);
			end
		end
	end);

	Storyline_NPCFrameGossipChoices:SetScript("OnKeyDown", function(self, key)
		if not Storyline_Data.config.useKeyboard then
			self:SetPropagateKeyboardInput(true);
			return;
		end

		if key == "ESCAPE" then
			Storyline_NPCFrameGossipChoices:Hide();
			self:SetPropagateKeyboardInput(false);
			return;
		end

		local keyNumber = tonumber(key);
		if not keyNumber then
			self:SetPropagateKeyboardInput(true);
			return;
		end

		if keyNumber == 0 then
			keyNumber = 10;
		end

		local foundFrames = 0;
		for i = 0, 9 do
			if _G["Storyline_ChoiceString" .. i] and _G["Storyline_ChoiceString" .. i].IsVisible and _G["Storyline_ChoiceString" .. i]:IsVisible() then
				foundFrames = foundFrames + 1;
				if foundFrames == keyNumber then
					_G["Storyline_ChoiceString" .. i]:Click();
					self:SetPropagateKeyboardInput(false);
					return;
				end
			end
		end

		self:SetPropagateKeyboardInput(true);
		return;

	end);

	mainFrame.models.you.animTab = {};
	mainFrame.models.me.animTab = {};

	mainFrame.models.you:SetScript("OnUpdate", function(self, elapsed)
		if self.spin then
			self.spinAngle = self.spinAngle - (elapsed / 2);
			self:SetFacing(self.spinAngle);
		end
	end);

	-- Register events
	Storyline_API.initEventsStructure();

	-- Closing
	Ellyb.GameEvents.registerCallback("GOSSIP_CLOSED", function()
		hideStorylineFrame();
	end);
	Ellyb.GameEvents.registerCallback("QUEST_FINISHED", function()
		hideStorylineFrame();
	end);

	-- Resizing
	local resizeChat = function()
		mainFrame.chat.text:SetWidth(mainFrame:GetWidth() - 150);
		mainFrame.chat:SetHeight(mainFrame.chat.text:GetHeight() + CHAT_MARGIN + 5);
		Storyline_NPCFrameGossipChoices:SetWidth(mainFrame:GetWidth() - 400);
	end
	mainFrame.chat.text:SetWidth(550);
	Storyline_NPCFrameResizeButton.onResizeStop = function(width, height)
		resizeChat();
		Storyline_Data.config.width = width;
		Storyline_Data.config.height = height;
		Storyline_API.dialogs.scrollFrame.refreshMargins(width, height);
	end;
	mainFrame:SetSize(Storyline_Data.config.width or 700, Storyline_Data.config.height or 450);
	Storyline_NPCFrameResizeButton.onResizeStop(Storyline_Data.config.width or 700, Storyline_Data.config.height or 450);
	resizeChat();

	-- Debug
	debugInit();

	-- Slash command to show settings frames
	Storyline_API.addon:RegisterChatCommand("storyline", function()
		InterfaceOptionsFrame_OpenToCategory(StorylineOptionsPanel);
		if not Storyline_NPCFrameConfigButton.shown then -- Dirty fix for the Interface frame shitting itself the first time
			Storyline_NPCFrameConfigButton.shown = true;
			InterfaceOptionsFrame_OpenToCategory(StorylineOptionsPanel);
		end;
	end);

	setTooltipAll(Storyline_NPCFrameConfigButton, "TOP", 0, 0, loc("SL_CONFIG"));


	mainFrame:RegisterForDrag("LeftButton");

	mainFrame:SetScript("OnDragStart", function(self)
		if not Storyline_API.layout.isFrameLocked() then
			self:StartMoving();
		end
	end);

	mainFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
	end);

	Storyline_API.options.init();

	Storyline_NPCFrame.Background.SealTexture:ClearAllPoints()
	Storyline_NPCFrame.Background.SealTexture:SetPoint("BOTTOMRIGHT", Storyline_NPCFrameChatName, "TOPRIGHT", 0, 20)
	Storyline_NPCFrame.Background.SealText:ClearAllPoints()
	Storyline_NPCFrame.Background.SealText:SetPoint("BOTTOMRIGHT", Storyline_NPCFrame.Background.SealTexture, "BOTTOMLEFT", -10, 0)
end