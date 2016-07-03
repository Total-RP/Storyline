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

-- Storyline API
local wipe, tContains = wipe, tContains;
local UnitGUID = UnitGUID;
local setTooltipForSameFrame, setTooltipAll = Storyline_API.lib.setTooltipForSameFrame, Storyline_API.lib.setTooltipAll;
local registerHandler = Storyline_API.lib.registerHandler;
local loc, tsize = Storyline_API.locale.getText, Storyline_API.lib.tsize;
local playNext = Storyline_API.playNext;
local showStorylineFame = Storyline_API.layout.showStorylineFame;
local hideStorylineFrame = Storyline_API.layout.hideStorylineFrame;

-- WOW API
local strsplit, pairs, tostring = strsplit, pairs, tostring;
local UnitIsUnit, UnitExists, UnitName = UnitIsUnit, UnitExists, UnitName;
local IsAltKeyDown, IsShiftKeyDown = IsAltKeyDown, IsShiftKeyDown;
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory;

-- UI
local mainFrame = Storyline_NPCFrame;

local scalingLib = LibStub:GetLibrary("TRP-Dialog-Scaling-DB");
local scalingDB;

-- Constants
local DEBUG = true;
local LINE_FEED_CODE = string.char(10);
local CARRIAGE_RETURN_CODE = string.char(13);
local WEIRD_LINE_BREAK = LINE_FEED_CODE .. CARRIAGE_RETURN_CODE .. LINE_FEED_CODE;
local CHAT_MARGIN = 70;
local DEFAULT_SCALE = scalingLib.DEFAULT_SCALE;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- NPC Blacklisting
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local Storyline_NPC_BLACKLIST = {"94399"} -- Garrison mission table

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- DATA SAVING & RESTORING
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

---
-- Get the best structure to use.
-- @param dataKey
-- @param firstPriority
-- @param secondPriority
-- @param fallback
--
local function getBestValue(dataKey, firstPriority, secondPriority, fallback)
	if firstPriority and firstPriority[dataKey] then return firstPriority[dataKey] end
	if secondPriority and secondPriority[dataKey] then return secondPriority[dataKey] end
	return fallback[dataKey];
end

---
-- Get the scaling structures (saved and defaults)
-- @param modelMeID
-- @param modelYouID
--
local function getScalingStuctures(modelMeID, modelYouID)
	local key, invertedKey = scalingLib:GetModelKeys(modelMeID, modelYouID);

	-- Saved structure
	local savedDataMe, savedDataYou;
	if scalingDB[key] then
		savedDataMe = scalingDB[key].me;
		savedDataYou = scalingDB[key].you;
	elseif scalingDB[invertedKey] then
		savedDataMe = scalingDB[invertedKey].you;
		savedDataYou = scalingDB[invertedKey].me;
	end

	-- Default structure
	local dataMe, dataYou = scalingLib:GetModelScaling(modelMeID, modelYouID);

	return savedDataMe, savedDataYou, dataMe, dataYou;
end

---
-- Reset a scaling field in the saved structures for a modelID tuple.
-- @param field typically "me" or "you"
--
local function resetStructure(field)
	local key, invertedKey = scalingLib:GetModelKeys(mainFrame.models.me.model, mainFrame.models.you.model);

	local structure = scalingDB[key] or scalingDB[invertedKey];
	if structure then
		if structure[field] then
			wipe(structure[field]);
			structure[field] = nil;
			-- If after removing the field the save structure is empty, we remove it.
			if tsize(structure) == 0 then
				scalingDB[key] = nil;
				scalingDB[invertedKey] = nil;
			end
		end
	end
end

---
-- Get the saved structure for the current two displayed models.
-- If the structure does not exist, create it.
--
local function getInitializedSavedStructure()
	local key, invertedKey = scalingLib:GetModelKeys(mainFrame.models.me.model, mainFrame.models.you.model);

	if not scalingDB[key] and not scalingDB[invertedKey] then
		scalingDB[key] = {};
	end
	return scalingDB[key] or scalingDB[invertedKey], scalingDB[key] == nil;
end

---
-- Save a scaling information for the current two displayed models.
-- @param dataName
-- @param isMe
-- @param value
--
local function saveStructureData(dataName, isMe, value)
	local structure, isInverted = getInitializedSavedStructure();
	local meYou;
	if (isMe and not isInverted) or (not isMe and isInverted) then
		meYou = "me";
	elseif (isMe and isInverted) or (not isMe and not isInverted) then
		meYou = "you";
	end
	if not structure[meYou] then
		structure[meYou] = {};
	end
	structure[meYou][dataName] = value;
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- LOADING & START DIALOG
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function loadScalingParameters(savedData, defaultData, meYou, facing)
	scalingLib:SetModelHeight(getBestValue("scale", savedData, defaultData, DEFAULT_SCALE[meYou]), mainFrame.models[meYou]);
	scalingLib:SetModelFeet(getBestValue("feet", savedData, defaultData, DEFAULT_SCALE[meYou]), mainFrame.models[meYou]);
	scalingLib:SetModelOffset(getBestValue("offset", savedData, defaultData, DEFAULT_SCALE[meYou]), mainFrame.models[meYou], facing);
	scalingLib:SetModelFacing(getBestValue("facing", savedData, defaultData, DEFAULT_SCALE[meYou]), mainFrame.models[meYou], facing);
end

---
-- Called when the two models are loaded.
-- This method initializes all scaling parameters.
--
local function modelsLoaded()
	if mainFrame.models.you.modelLoaded and mainFrame.models.me.modelLoaded then

		mainFrame.models.you.model = mainFrame.models.you:GetModelFileID();
		if mainFrame.models.you.model then
			mainFrame.models.you.model = tostring(mainFrame.models.you.model);
		end
		mainFrame.models.me.model = mainFrame.models.me:GetModelFileID();
		if mainFrame.models.me.model then
			mainFrame.models.me.model = tostring(mainFrame.models.me.model);
		end


		local savedDataMe, savedDataYou, dataMe, dataYou = getScalingStuctures(mainFrame.models.me.model, mainFrame.models.you.model);

		-- Configuration for model Me.
		loadScalingParameters(savedDataMe, dataMe, "me", true);

		-- Configuration for model You, if available.
		if mainFrame.models.you.model then
			loadScalingParameters(savedDataYou, dataYou, "you", false);
		else
			-- If there is no You model, play the read animation for the Me model.
			mainFrame.models.me:SetAnimation(520);
		end

		-- Place the modelIDs in the debug frame
		if mainFrame.models.you.model then
			mainFrame.debug.you:SetText(mainFrame.models.you.model);
		end
		if mainFrame.models.me.model then
			mainFrame.debug.me:SetText(mainFrame.models.me.model);
		end
	end
end

---
-- Start a dialog with unit ID targetType
-- @param targetType
-- @param fullText
-- @param event
-- @param eventInfo
--
function Storyline_API.startDialog(targetType, fullText, event, eventInfo)
	mainFrame.debug.text:SetText(event);

	-- Get NPC_ID
	local guid = UnitGUID(targetType);
	local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid or "");
	mainFrame.models.you.npc_id = npc_id;

	-- Dirty if to fix the flavor text appearing on naval mission table because Blizzard…
	if tContains(Storyline_NPC_BLACKLIST, npc_id) or tContains(Storyline_Data.npc_blacklist, npc_id)then
		SelectGossipOption(1);
		return;
	end

	local targetName = UnitName(targetType);

	if targetName and targetName:len() > 0 and targetName ~= UNKNOWN then
		mainFrame.chat.name:SetText(targetName);
	else
		if eventInfo.nameGetter and eventInfo.nameGetter() then
			mainFrame.chat.name:SetText(eventInfo.nameGetter());
		else
			mainFrame.chat.name:SetText("");
		end
	end

	if eventInfo.titleGetter and eventInfo.titleGetter() and eventInfo.titleGetter():len() > 0 then
		mainFrame.banner:Show();
		mainFrame.title:SetText(eventInfo.titleGetter());
		if eventInfo.getTitleColor and eventInfo.getTitleColor() then
			mainFrame.title:SetTextColor(eventInfo.getTitleColor());
		else
			mainFrame.title:SetTextColor(0.95, 0.95, 0.95);
		end
	else
		mainFrame.title:SetText("");
		mainFrame.banner:Hide();
	end

	mainFrame.models.me.modelLoaded = false;
	mainFrame.models.you.modelLoaded = false;
	mainFrame.models.you.model = "";
	mainFrame.models.me.model = "";

	-- Load player in the left model
	mainFrame.models.me:SetUnit("player", false);

	-- Load unit in the right model
	if UnitExists(targetType) and not UnitIsUnit("player", "npc") then
		mainFrame.models.you:SetUnit(targetType, false);
	else
		mainFrame.models.you:SetUnit("none");
		mainFrame.models.you.modelLoaded = true;
	end

	fullText = fullText:gsub(LINE_FEED_CODE .. "+", "\n");
	fullText = fullText:gsub(WEIRD_LINE_BREAK, "\n");

	local texts = { strsplit("\n", fullText) };
	if texts[#texts]:len() == 0 then
		texts[#texts] = nil;
	end
	mainFrame.chat.texts = texts;
	mainFrame.chat.currentIndex = 0;
	mainFrame.chat.eventInfo = eventInfo;
	mainFrame.chat.event = event;
	Storyline_NPCFrameObjectivesContent:Hide();
	mainFrame.chat.previous:Hide();
	showStorylineFame();

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

local function debugInit()
	if not Storyline_Data.config.debug then
		mainFrame.debug:Hide();
	end
	Storyline_NPCFrameDebugMeResetButton:SetScript("OnClick", function(self)
		resetStructure("me");
		modelsLoaded();
	end);
	Storyline_NPCFrameDebugYouResetButton:SetScript("OnClick", function(self)
		resetStructure("you");
		modelsLoaded();
	end);

	-- Scrolling on the 3D model frame to adjust the size of the models
--	Storyline_NPCFrameModelsMeScrollZone:EnableMouseWheel(true);
--	Storyline_NPCFrameModelsMeScrollZone:SetScript("OnMouseWheel", function(self, delta)
--		if IsAltKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelHeight(Storyline_NPCFrameModelsMe.scale - 0.1 * delta, true, true);
--			else
--				setModelHeight(Storyline_NPCFrameModelsMe.scale - 0.01 * delta, true, true);
--			end
--		elseif IsControlKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelFacing(Storyline_NPCFrameModelsMe.facing - 0.2 * delta, true, true);
--			else
--				setModelFacing(Storyline_NPCFrameModelsMe.facing - 0.02 * delta, true, true);
--			end
--		end
--	end);
--	Storyline_NPCFrameModelsMeScrollZone:RegisterForClicks("LeftButtonUp", "RightButtonUp");
--	Storyline_NPCFrameModelsMeScrollZone:SetScript("OnClick", function(self, button)
--		local factor = button == "LeftButton" and 1 or -1;
--		if IsAltKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelOffset(Storyline_NPCFrameModelsMe.offset - 0.1 * factor, true, true);
--			else
--				setModelOffset(Storyline_NPCFrameModelsMe.offset - 0.01 * factor, true, true);
--			end
--		elseif IsControlKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelFeet(Storyline_NPCFrameModelsMe.feet - 0.1 * factor, true, true);
--			else
--				setModelFeet(Storyline_NPCFrameModelsMe.feet - 0.01 * factor, true, true);
--			end
--		end
--	end);
--
--	Storyline_NPCFrameModelsYouScrollZone:EnableMouseWheel(true);
--	Storyline_NPCFrameModelsYouScrollZone:SetScript("OnMouseWheel", function(self, delta)
--		if IsAltKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelHeight(Storyline_NPCFrameModelsYou.scale - 0.1 * delta, false, true);
--			else
--				setModelHeight(Storyline_NPCFrameModelsYou.scale - 0.01 * delta, false, true);
--			end
--		elseif IsControlKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelFacing(Storyline_NPCFrameModelsYou.facing - 0.2 * delta, false, true);
--			else
--				setModelFacing(Storyline_NPCFrameModelsYou.facing - 0.02 * delta, false, true);
--			end
--		end
--	end);
--	Storyline_NPCFrameModelsYouScrollZone:RegisterForClicks("LeftButtonUp", "RightButtonUp");
--	Storyline_NPCFrameModelsYouScrollZone:SetScript("OnClick", function(self, button)
--		local factor = button == "LeftButton" and 1 or -1;
--		if IsAltKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelOffset(Storyline_NPCFrameModelsYou.offset - 0.1 * factor, false, true);
--			else
--				setModelOffset(Storyline_NPCFrameModelsYou.offset - 0.01 * factor, false, true);
--			end
--		elseif IsControlKeyDown() then
--			if IsShiftKeyDown() then -- If shift key down adjust my model
--			setModelFeet(Storyline_NPCFrameModelsYou.feet - 0.1 * factor, false, true);
--			else
--				setModelFeet(Storyline_NPCFrameModelsYou.feet - 0.01 * factor, false, true);
--			end
--		end
--	end);

	-- Debug for scaling
	Storyline_API.addon:RegisterChatCommand("storydebug", function()
		Storyline_API.startDialog("target", "Pouic", "SCALING_DEBUG", Storyline_API.EVENT_INFO.SCALING_DEBUG);
	end);

	setTooltipAll(Storyline_NPCFrameDebugMeResetButton, "TOP", 0, 0, "Reset values for 'my' model"); -- Debug, not localized
	setTooltipAll(Storyline_NPCFrameDebugYouResetButton, "TOP", 0, 0, "Reset values for 'his' model"); -- Debug, not localized
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

Storyline_API.addon = LibStub("AceAddon-3.0"):NewAddon("Storyline", "AceConsole-3.0");

function Storyline_API.addon:OnEnable()

	if not Storyline_Data then
		Storyline_Data = {};
	end
	if not Storyline_Data.scaling then
		Storyline_Data.scaling = {};
	end
	scalingDB = Storyline_Data.scaling;
	if not Storyline_Data.debug then
		Storyline_Data.debug = {};
	end
	if not Storyline_Data.debug.timing then
		Storyline_Data.debug.timing = {};
	end
	if not Storyline_Data.config then
		Storyline_Data.config = {};
	end
	if not Storyline_Data.npc_blacklist then
		Storyline_Data.npc_blacklist = {};
	end

	ForceGossip = function() return Storyline_Data.config.forceGossip == true end

	Storyline_API.locale.init();
	Storyline_API.consolePort.init();

	Storyline_NPCFrameBG:SetDesaturated(true);
	mainFrame.chat.next:RegisterForClicks("LeftButtonUp", "RightButtonUp");
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
			if not keyNumber then
				self:SetPropagateKeyboardInput(true);
				return;
			end

			local foundFrames = 0;
			for i = 1, 9 do
				if _G["Storyline_NPCFrameChatOption" .. i] and _G["Storyline_NPCFrameChatOption" .. i].IsVisible and _G["Storyline_NPCFrameChatOption" .. i]:IsVisible() then
					foundFrames = foundFrames + 1;
					if foundFrames == keyNumber then
						_G["Storyline_NPCFrameChatOption" .. i]:Click();
						self:SetPropagateKeyboardInput(false);
						return;
					end
				end
			end

			self:SetPropagateKeyboardInput(true);
			return;
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

	-- 3D models loaded
	mainFrame.models.me:SetScript("OnModelLoaded", function()
		mainFrame.models.me.modelLoaded = true;
		modelsLoaded();
	end);

	mainFrame.models.you:SetScript("OnModelLoaded", function()
		mainFrame.models.you.modelLoaded = true;
		modelsLoaded();
	end);

	-- Closing
	registerHandler("GOSSIP_CLOSED", function()
		hideStorylineFrame();
	end);
	registerHandler("QUEST_FINISHED", function()
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
	end;
	mainFrame:SetSize(Storyline_Data.config.width or 700, Storyline_Data.config.height or 450);
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
end