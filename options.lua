----------------------------------------------------------------------------------
-- Storyline options
-- ---------------------------------------------------------------------------
-- Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
-- Copyright 2015 Morgane "Ellypse" Parize (ellypse@totalrp3.info)
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
local loc = Storyline_API.locale.getText;
local setupListBox = Storyline_API.lib.setupListBox;
local setTooltipForSameFrame = Storyline_API.lib.setTooltipForSameFrame;

Storyline_API.options = {}

local function hideOriginalFrames()
	GossipFrame:ClearAllPoints();
	local frameWidth = GossipFrame:GetWidth();
	GossipFrame:SetPoint("TOPLEFT", frameWidth * -1, 0);
	QuestFrame:ClearAllPoints();
	frameWidth = QuestFrame:GetWidth();
	QuestFrame:SetPoint("TOPLEFT", frameWidth * -1, 0);
end

Storyline_API.options.hideOriginalFrames = hideOriginalFrames;

local function showOriginalFrames()
	GossipFrame:ClearAllPoints();
	GossipFrame:SetPoint("TOPLEFT", 16, -116);
	QuestFrame:ClearAllPoints();
	QuestFrame:SetPoint("TOPLEFT", 16, -116);
end

Storyline_API.options.showOriginalFrames = showOriginalFrames;

local function decorateTextOptions(title, optionKey, affectedText)

	if not Storyline_Data.config[optionKey] then
		Storyline_Data.config[optionKey] = {}
	end

	-- Option title & text sample
	StorylineTextOptionsPanel[optionKey].Title:SetText(title);
	StorylineTextOptionsPanel[optionKey].TextSample:SetText(loc("SL_CONFIG_SAMPLE_TEXT"));

	-- Size slider
	_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderLow"]:SetText(9);
	_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderHigh"]:SetText(25);
	StorylineTextOptionsPanel[optionKey].SizeSlider:SetScript("OnValueChanged", function(self, scale)
		_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderText"]:SetText(scale);
		local font, _, outline = affectedText:GetFont();
		affectedText:SetFont(font, scale, outline);
		StorylineTextOptionsPanel[optionKey].TextSample:SetFont(font, scale, outline);
		Storyline_Data.config[optionKey].Size = scale;
		Storyline_NPCFrameChat:SetHeight(Storyline_NPCFrameChatText:GetHeight() + Storyline_NPCFrameChatName:GetHeight() + Storyline_NPCFrameChatNextText:GetHeight() + 50);
	end);
	StorylineTextOptionsPanel[optionKey].SizeSlider:SetValue(Storyline_Data.config[optionKey].Size or select(2, affectedText:GetFont()));

	local fonts = Storyline_API.lib.getFonts();

	if not Storyline_Data.config[optionKey].Font then
		Storyline_Data.config[optionKey].Font = Storyline_API.lib.getDefaultFont();
	end

	local font = Storyline_API.lib.getFontPath(Storyline_Data.config[optionKey].Font);
	local _, scale, outline = affectedText:GetFont();
	affectedText:SetFont(font, scale, outline);
	StorylineTextOptionsPanel[optionKey].TextSample:SetFont(font, scale, outline);

	setupListBox(StorylineTextOptionsPanel[optionKey].FontDropDown, fonts, function(fontIndex)
		local dropdownTextFont = Storyline_API.lib.getFontPath(fontIndex);
		local _, dropdownTextScale, dropdownTextOutline = affectedText:GetFont();
		affectedText:SetFont(dropdownTextFont, dropdownTextScale, dropdownTextOutline);
		StorylineTextOptionsPanel[optionKey].TextSample:SetFont(dropdownTextFont, dropdownTextScale, dropdownTextOutline);
		Storyline_Data.config[optionKey].Font = fontIndex;
	end, nil, 100, true, true);
	StorylineTextOptionsPanel[optionKey].FontDropDown:SetSelectedValue(Storyline_Data.config[optionKey].Font);
end

local function decorateTextTemplateOptions(title, optionKey, defaultTextOptions, callback)

	if not Storyline_Data.config[optionKey] then
		Storyline_Data.config[optionKey] = {
			Font = Storyline_API.lib.getDefaultFont(),
			Size = defaultTextOptions[2],
			Outline = defaultTextOptions[3]
		}
	end

	-- Option title & text sample
	StorylineTextOptionsPanel[optionKey].Title:SetText(title);
	StorylineTextOptionsPanel[optionKey].TextSample:SetText(loc("SL_CONFIG_SAMPLE_TEXT"));

	-- Size slider
	_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderLow"]:SetText(9);
	_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderHigh"]:SetText(25);
	StorylineTextOptionsPanel[optionKey].SizeSlider:SetScript("OnValueChanged", function(self, scale)
		_G["StorylineTextOptionsPanel" .. optionKey .. "SizeSliderText"]:SetText(scale);
		Storyline_Data.config[optionKey].Size = scale;
		StorylineTextOptionsPanel[optionKey].TextSample:SetFont(Storyline_Data.config[optionKey].Font, Storyline_Data.config[optionKey].Size, Storyline_Data.config[optionKey].Outline);
		callback(Storyline_Data.config[optionKey]);
	end);
	StorylineTextOptionsPanel[optionKey].SizeSlider:SetValue(Storyline_Data.config[optionKey].Size);

	local fonts = Storyline_API.lib.getFonts();
	local font = Storyline_API.lib.getFontPath(Storyline_Data.config[optionKey].Font);
	StorylineTextOptionsPanel[optionKey].TextSample:SetFont(font, Storyline_Data.config[optionKey].Size, Storyline_Data.config[optionKey].Outline);

	setupListBox(StorylineTextOptionsPanel[optionKey].FontDropDown, fonts, function(fontIndex)
		Storyline_Data.config[optionKey].Font = fontIndex;
		local dropdownTextFont = Storyline_API.lib.getFontPath(fontIndex);
		StorylineTextOptionsPanel[optionKey].TextSample:SetFont(dropdownTextFont, Storyline_Data.config[optionKey].Size, Storyline_Data.config[optionKey].Outline);
		callback(Storyline_Data.config[optionKey]);
	end, nil, 100, true, true);
	StorylineTextOptionsPanel[optionKey].FontDropDown:SetSelectedValue(Storyline_Data.config[optionKey].Font);

	callback(Storyline_Data.config[optionKey]);
end

Storyline_API.options.init = function()

	local mainCategory = Settings.RegisterCanvasLayoutCategory(StorylineOptionsPanel, "Storyline", "Storyline");
	mainCategory.ID = "Storyline";
	Settings.RegisterAddOnCategory(mainCategory);

	local subCategoryTextOptions = Settings.RegisterCanvasLayoutSubcategory(mainCategory, StorylineTextOptionsPanel, "Text options", "Text options");
	subCategoryTextOptions.ID = "Text options";
	local subCategoryMiscOptions = Settings.RegisterCanvasLayoutSubcategory(mainCategory, StorylineMiscellaneousOptionsPanel, "Miscellaneous options", "Miscellaneous options");
	subCategoryMiscOptions.ID = "Miscellaneous options";

	-- Options main panel
	StorylineOptionsPanel.Title:SetText(loc("SL_CONFIG"));
	StorylineOptionsPanel.SubText:SetText(loc("SL_CONFIG_WELCOME"));


	local localeTab = {};
	for locale, localeInfo in pairs(Storyline_API.locale.getLocales()) do
		tinsert(localeTab, {localeInfo.localeText, locale});
	end

	local init = true;
	StorylineOptionsPanel.Locale.Label:SetText(loc("SL_CONFIG_LANGUAGE"));
	setupListBox(StorylineOptionsPanel.Locale.DropDown, localeTab, function(locale)
		Storyline_Data.config.locale = locale;
		if not init then
			ReloadUI();
		end
	end, nil, 100, true);
	StorylineOptionsPanel.Locale.DropDown:SetSelectedValue(Storyline_Data.config.locale or Storyline_API.locale.DEFAULT_LOCALE);
	init = false;

	-- Force gossip option
	--StorylineOptionsPanel.ForceGossip.Text:SetText(loc("SL_CONFIG_FORCEGOSSIP"));
	--StorylineOptionsPanel.ForceGossip.tooltip = loc("SL_CONFIG_FORCEGOSSIP_TT");
	--StorylineOptionsPanel.ForceGossip:SetScript("OnClick", function(self)
	--	Storyline_Data.config.forceGossip = self:GetChecked() == true;
	--end);
	--if Storyline_Data.config.forceGossip == nil then
	--	Storyline_Data.config.forceGossip = false;
	--end
	--StorylineOptionsPanel.ForceGossip:SetChecked(Storyline_Data.config.forceGossip);

	-- Hide original frames option
	StorylineOptionsPanel.HideOriginalFrames.Text:SetText(loc("SL_CONFIG_HIDEORIGINALFRAMES"));
	StorylineOptionsPanel.HideOriginalFrames.tooltip = loc("SL_CONFIG_HIDEORIGINALFRAMES_TT");
	StorylineOptionsPanel.HideOriginalFrames:SetScript("OnClick", function(self)
		Storyline_Data.config.hideOriginalFrames = self:GetChecked() == true;
		if Storyline_Data.config.hideOriginalFrames then
			Storyline_API.layout.hideDefaultFrames();
		else
			Storyline_API.layout.showDefaultFrames();
		end
	end);
	if Storyline_Data.config.hideOriginalFrames == nil then
		Storyline_Data.config.hideOriginalFrames = true;
	end
	StorylineOptionsPanel.HideOriginalFrames:SetChecked(Storyline_Data.config.hideOriginalFrames);
	if Storyline_Data.config.hideOriginalFrames then
		Storyline_API.layout.hideDefaultFrames();
	end

	-- Lock Storyline frame option
	StorylineOptionsPanel.LockFrame.Text:SetText(loc("SL_CONFIG_LOCKFRAME"));
	StorylineOptionsPanel.LockFrame.tooltip = loc("SL_CONFIG_LOCKFRAME_TT");
	StorylineOptionsPanel.LockFrame:SetScript("OnClick", function(self)
		Storyline_Data.config.lockFrame = self:GetChecked() == true;
		Storyline_NPCFrameLock:SetChecked(Storyline_Data.config.lockFrame);
	end);
	if Storyline_Data.config.lockFrame == nil then
		Storyline_Data.config.lockFrame = false;
	end
	StorylineOptionsPanel.LockFrame:SetChecked(Storyline_Data.config.lockFrame);
	Storyline_NPCFrameLock:SetChecked(Storyline_Data.config.lockFrame);

	setTooltipForSameFrame(Storyline_NPCFrameLock, "BOTTOMRIGHT", 0, 0, loc("SL_CONFIG_LOCKFRAME"), loc("SL_CONFIG_LOCKFRAME_TT"))

	-- Use layout engine option
	if Storyline_Data.config.useLayoutEngine == nil then
		Storyline_Data.config.useLayoutEngine = false; -- By default, this option is disabled
	end
	StorylineOptionsPanel.UseLayoutEngine.Text:SetText(loc("SL_CONFIG_UI_LAYOUT_ENGINE"));
	StorylineOptionsPanel.UseLayoutEngine.tooltip = loc("SL_CONFIG_UI_LAYOUT_ENGINE_TT");
	StorylineOptionsPanel.UseLayoutEngine:SetChecked(Storyline_Data.config.useLayoutEngine);

	if Storyline_Data.config.useLayoutEngine then
		-- If we are using the default engine, the frame is locked. Set the option's checkbox accordingly and disable it
		Storyline_Data.config.lockFrame = true;
		StorylineOptionsPanel.LockFrame:SetChecked(Storyline_Data.config.lockFrame);
		Storyline_NPCFrameLock:SetChecked(Storyline_Data.config.lockFrame);
		StorylineOptionsPanel.LockFrame:Disable();

		-- Register the frame to the UI layout engine
		Storyline_API.layout.registerToUILayoutEngine();
	end

	StorylineOptionsPanel.UseLayoutEngine:SetScript("OnClick", function(self)
		-- Set config variable to status of checkbox
		Storyline_Data.config.useLayoutEngine = self:GetChecked() == true;
		-- This option require a ReloadUI() to be effective
		ReloadUI();
	end);


	-- Disable Storyline when inside instances
	if Storyline_Data.config.disableInInstances == nil then
		Storyline_Data.config.disableInInstances = false; -- By default, this option is disabled
	end
	StorylineOptionsPanel.DisableInInstances.Text:SetText(loc("SL_CONFIG_DISABLE_IN_INSTANCES"));
	StorylineOptionsPanel.DisableInInstances.tooltip = loc("SL_CONFIG_DISABLE_IN_INSTANCES_TT");
	StorylineOptionsPanel.DisableInInstances:SetScript("OnClick", function(self)
		Storyline_Data.config.disableInInstances = self:GetChecked() == true;
		Storyline_NPCFrameLock:SetChecked(Storyline_Data.config.disableInInstances);

		if IsInInstance() then
			if Storyline_Data.config.disableInInstances then
				Storyline_API.layout.showDefaultFrames();
			else
				Storyline_API.layout.hideDefaultFrames();
			end
		end
	end);
	StorylineOptionsPanel.DisableInInstances:SetChecked(Storyline_Data.config.disableInInstances);

	-- Disable Storyline when inside Darkmoon Faire Island
	if Storyline_Data.config.disableInDMF == nil then
		Storyline_Data.config.disableInDMF = false; -- By default, this option is disabled
	end
	StorylineOptionsPanel.DisableInDMF.Text:SetText(loc("SL_CONFIG_DISABLE_IN_DMF"));
	StorylineOptionsPanel.DisableInDMF.tooltip = loc("SL_CONFIG_DISABLE_IN_DMF_TT");
	StorylineOptionsPanel.DisableInDMF:SetScript("OnClick", function(self)
		Storyline_Data.config.disableInDMF = self:GetChecked() == true;

		local _, _, _, mapID = UnitPosition("player")
		if mapID and mapID == 974 then
			if Storyline_Data.config.disableInDMF then
				Storyline_API.layout.showDefaultFrames();
			else
				Storyline_API.layout.hideDefaultFrames();
			end
		end
	end);
	StorylineOptionsPanel.DisableInDMF:SetChecked(Storyline_Data.config.disableInDMF);

	-- Hide dialog count
	if Storyline_Data.config.hideCount == nil then
		Storyline_Data.config.hideCount = false; -- By default, this option is disabled
	end
	StorylineOptionsPanel.HideCount.Text:SetText(loc("SL_CONFIG_HIDE_COUNT"));
	StorylineOptionsPanel.HideCount.tooltip = loc("SL_CONFIG_HIDE_COUNT_TT");
	StorylineOptionsPanel.HideCount:SetScript("OnClick", function(self)
		Storyline_Data.config.hideCount = self:GetChecked() == true;
		if Storyline_Data.config.hideCount then
			Storyline_NPCFrameChatCountText:Hide();
		else
			Storyline_NPCFrameChatCountText:Show();
		end
	end);
	StorylineOptionsPanel.HideCount:SetChecked(Storyline_Data.config.hideCount);
	if Storyline_Data.config.hideCount then
		Storyline_NPCFrameChatCountText:Hide();
	else
		Storyline_NPCFrameChatCountText:Show();
	end

	-- Text speed slider
	local textSpeedFactor = Storyline_Data.config.textSpeedFactor or 0.5;
	local textSpeedTextSampleAnimation = 0;
	StorylineOptionsPanel.TextSpeed.Title:SetText(loc("SL_CONFIG_TEXTSPEED_TITLE"));
	StorylineOptionsPanel.TextSpeed.TextSample:SetText(loc("SL_CONFIG_BIG_SAMPLE_TEXT"));
	StorylineOptionsPanelTextSpeedSliderLow:SetText(loc("SL_CONFIG_TEXTSPEED_INSTANT"));
	StorylineOptionsPanelTextSpeedSliderHigh:SetText(loc("SL_CONFIG_TEXTSPEED_HIGH"));
	StorylineOptionsPanel.TextSpeed.Slider:SetScript("OnValueChanged", function(self, speed)
		StorylineOptionsPanelTextSpeedSliderText:SetText(loc("SL_CONFIG_TEXTSPEED"):format(speed));
		textSpeedFactor = speed;
		Storyline_Data.config.textSpeedFactor = textSpeedFactor;
		textSpeedTextSampleAnimation = 0;
	end);
	StorylineOptionsPanel.TextSpeed.Slider:SetValue(textSpeedFactor);

	local ANIMATION_TEXT_SPEED = 80;
	local function onUpdateTextSpeedSample(self, elapsed)
		if textSpeedTextSampleAnimation == nil then return end
		textSpeedTextSampleAnimation = textSpeedTextSampleAnimation + (elapsed * (ANIMATION_TEXT_SPEED * Storyline_Data.config.textSpeedFactor));
		if textSpeedFactor == 0 or textSpeedTextSampleAnimation >= StorylineOptionsPanel.TextSpeed.TextSample:GetText():len() then
			textSpeedTextSampleAnimation = nil;
			StorylineOptionsPanel.TextSpeed.TextSample:SetAlphaGradient(StorylineOptionsPanel.TextSpeed.TextSample:GetText():len(), 1);
		else
			StorylineOptionsPanel.TextSpeed.TextSample:SetAlphaGradient(textSpeedTextSampleAnimation, 30);
		end
	end

	StorylineOptionsPanel:SetScript("OnUpdate", onUpdateTextSpeedSample);

	-- Text options panel
	StorylineTextOptionsPanel.Title:SetText(loc("SL_CONFIG_STYLING_OPTIONS"));
	StorylineTextOptionsPanel.SubText:SetText(loc("SL_CONFIG_STYLING_OPTIONS_SUBTEXT"));

	decorateTextOptions(loc("SL_CONFIG_QUEST_TITLE"), "QuestTitle", Storyline_NPCFrame.Banner.Title);
	decorateTextOptions(loc("SL_CONFIG_DIALOG_TEXT"), "DialogText", Storyline_NPCFrameChatText);
	decorateTextOptions(loc("SL_CONFIG_NPC_NAME"), "NPCName", Storyline_NPCFrameChatName);
	decorateTextOptions(loc("SL_CONFIG_NEXT_ACTION"), "NextAction", Storyline_NPCFrameChatNextText);
	decorateTextTemplateOptions(loc("SL_CONFIG_DIALOG_CHOICES"), "DialogOptions", Storyline_API.dialogs.buttons.getDefaultFontStyle(), Storyline_API.dialogs.buttons.setFontStyle);

	-- Miscellaneous options panel
	StorylineMiscellaneousOptionsPanel.Title:SetText(loc("SL_CONFIG_MISCELLANEOUS"));
	StorylineMiscellaneousOptionsPanel.SubText:SetText(loc("SL_CONFIG_MISCELLANEOUS_SUBTEXT"));

	-- Auto equip option
	StorylineMiscellaneousOptionsPanel.AutoEquip.Text:SetText(loc("SL_CONFIG_AUTOEQUIP"));
	StorylineMiscellaneousOptionsPanel.AutoEquip.tooltip = loc("SL_CONFIG_AUTOEQUIP_TT");
	StorylineMiscellaneousOptionsPanel.AutoEquip:SetScript("OnClick", function(self)
		Storyline_Data.config.autoEquip = self:GetChecked() == true;
	end);
	if Storyline_Data.config.autoEquip == nil then
		Storyline_Data.config.autoEquip = false;
	end
	StorylineMiscellaneousOptionsPanel.AutoEquip:SetChecked(Storyline_Data.config.autoEquip);


	-- Use keyboard (on by default)
	StorylineMiscellaneousOptionsPanel.UseKeyboard.Text:SetText(loc("SL_CONFIG_USE_KEYBOARD"));
	StorylineMiscellaneousOptionsPanel.UseKeyboard.tooltip = loc("SL_CONFIG_USE_KEYBOARD_TT");
	StorylineMiscellaneousOptionsPanel.UseKeyboard:SetScript("OnClick", function(self)
		Storyline_Data.config.useKeyboard = self:GetChecked() == true;
	end);
	if Storyline_Data.config.useKeyboard == nil then
		Storyline_Data.config.useKeyboard = true;
	end
	StorylineMiscellaneousOptionsPanel.UseKeyboard:SetChecked(Storyline_Data.config.useKeyboard);

	-- Use dynamic backgrounds (on by default)
	StorylineMiscellaneousOptionsPanel.DynamicBackgrounds.Text:SetText(loc("SL_USE_DYNAMIC_BACKGROUNDS"));
	StorylineMiscellaneousOptionsPanel.DynamicBackgrounds:SetScript("OnClick", function(self)
		Storyline_Data.config.dynamicBackgrounds = self:GetChecked() == true;
		if Storyline_NPCFrame:IsVisible() then
			Storyline_API.displaySpecialBackgrounds()
		end
	end);
	if Storyline_Data.config.dynamicBackgrounds == nil then
		Storyline_Data.config.dynamicBackgrounds = true;
	end
	StorylineMiscellaneousOptionsPanel.DynamicBackgrounds:SetChecked(Storyline_Data.config.dynamicBackgrounds);

	-- Debug mode option
	StorylineMiscellaneousOptionsPanel.DebugMode.Text:SetText(loc("SL_CONFIG_DEBUG"));
	StorylineMiscellaneousOptionsPanel.DebugMode.tooltip = loc("SL_CONFIG_DEBUG_TT");
	StorylineMiscellaneousOptionsPanel.DebugMode:SetScript("OnClick", function(self)
		Storyline_Data.config.debug = self:GetChecked() == true;
		if Storyline_Data.config.debug then
			Storyline_NPCFrameDebug:Show();
		else
			Storyline_NPCFrameDebug:Hide();
		end
	end);
	if Storyline_Data.config.debug == nil then
		Storyline_Data.config.debug = false;
	end
	StorylineMiscellaneousOptionsPanel.DebugMode:SetChecked(Storyline_Data.config.debug);

end
