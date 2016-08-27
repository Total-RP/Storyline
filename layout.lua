----------------------------------------------------------------------------------
-- Storyline layout
-- ---------------------------------------------------------------------------
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

local ShowUIPanel = ShowUIPanel;
local HideUIPanel = HideUIPanel;

local Storyline_NPCFrame = Storyline_NPCFrame;


local defaultFramesWeWantToReplace = {
	"QuestFrame",
	"GossipFrame",
};

Storyline_API.layout = {};

---
-- Lock the frame so it cannot be dragged.
-- @param shouldLockTheFrame boolean (optional) Tell if the frame should be locked or not.
--
local lockFrame = function(shouldLockTheFrame)
	if shouldLockTheFrame == nil then
		shouldLockTheFrame = true;
	end
	Storyline_Data.config.lockFrame = shouldLockTheFrame;
end
Storyline_API.layout.lockFrame = lockFrame;

---
-- Unlock the frame so it can be dragged again.
local unlockFrame = function()
	Storyline_Data.config.lockFrame = false;
end
Storyline_API.layout.unlockFrame = unlockFrame;

---
-- Return true if the frame is locked and should not be dragged around.
-- @return boolean
local isFrameLocked = function()
	return Storyline_Data.config.lockFrame or false;
end
Storyline_API.layout.isFrameLocked = isFrameLocked;

local Storyline_FrameLayoutOptions = {
	area = "left", 		-- The frame appear on the left, with the other frames
	pushable = 1, 		-- The frame can be pushed by other frames
	width = 830,		-- Predefined width of the frame (I'm using the same width as the encounter journal)
	height = 519		-- Predefined height of the frame (16:10 ratio using the width of 830)
};

---
-- Add the Storyline frame to the array of frames managed by the game UI layout engine.
-- Parameters inside the array defined the size of the frame and its priority against other frames.
local registerToUILayoutEngine = function()
	-- Add Storyline_NPCFrame to the array of frames managed by the UI layout engine
	UIPanelWindows["Storyline_NPCFrame"] = Storyline_FrameLayoutOptions;

	-- Resize the frame to the pre-defined values
	Storyline_NPCFrame:SetSize(Storyline_FrameLayoutOptions.width, Storyline_FrameLayoutOptions.height);
	Storyline_NPCFrameResizeButton.onResizeStop(Storyline_FrameLayoutOptions.width, Storyline_FrameLayoutOptions.height);

	-- Lock the frame
	lockFrame();

	-- Hide the resize and lock buttons
	Storyline_NPCFrameLock:Hide();
	Storyline_NPCFrameResizeButton:Hide();
end
Storyline_API.layout.registerToUILayoutEngine = registerToUILayoutEngine;

local hiddenFrames = CreateFrame("FRAME");
hiddenFrames:Hide();

---
-- Remove Storyline frame from the array of frames managed by the game UI layout engine.
-- We should no longer call upon the UI layout engine to open Storyline inside the add-on,
-- but if we do, it will fail silently.
local unregisterFromUILayoutEngine = function()
	-- Remove our frame from the array of frames managed by the UI layout engine
	UIPanelWindows["Storyline_NPCFrame"] = nil;

	-- Show the resize and lock buttons
	Storyline_NPCFrameLock:Show();
	Storyline_NPCFrameResizeButton:Show();
end
Storyline_API.layout.unregisterFromUILayoutEngine = unregisterFromUILayoutEngine;

local framesUILayoutEngineSettings = {};

local removeFrameFromUILayoutEngine = function(frameName)
	local info = UIPanelWindows[frameName];
	if not info then return end

	framesUILayoutEngineSettings[frameName] = info;

	local frame = _G[frameName];
	frame:SetAttribute("UIPanelLayout-defined", false);
	UIPanelWindows[frameName] = nil;
	frame:SetParent(hiddenFrames);
end

local addToLayoutEngine = function(frameName)
	local frame = _G[frameName];
	UIPanelWindows[frameName] = framesUILayoutEngineSettings[frameName];
	frame:SetAttribute("UIPanelLayout-defined", true);
	for name, value in pairs(UIPanelWindows[frameName]) do
		frame:SetAttribute("UIPanelLayout-" .. name, value);
	end
	frame:SetParent(UIParent);
end

---
-- The quest reward frame is somehow decoupled from the quest frame
-- and is still shown out of the frame.
-- The workaround is to hide it everytime ¯\_(ツ)_/¯
Storyline_API.layout.hideQuestRewardFrameIfNeed = function()
	if Storyline_Data.config.hideOriginalFrames then
		QuestInfoRewardsFrame:Hide();
	else
		QuestInfoRewardsFrame:Show();
	end
end


---
-- Return true if we are using the UI layout engine
-- @return boolean
local useUILayoutEngine = function()
	return Storyline_Data.config.useLayoutEngine;
end

---
-- Show Storyline's frame using the right function according to the settings
local showStorylineFrame = function()
	if useUILayoutEngine() then
		ShowUIPanel(Storyline_NPCFrame);
	else
		Storyline_NPCFrame:Show();
	end
	PlaySound("QUESTLOGOPEN")
end
Storyline_API.layout.showStorylineFrame = showStorylineFrame;

---
-- Hide Storyline's frame using the right function according to the settings
local hideStorylineFrame = function()
	if useUILayoutEngine() then
		HideUIPanel(Storyline_NPCFrame);
	else
		Storyline_NPCFrame:Hide();
	end
	PlaySound("QUESTLOGCLOSE")
end
Storyline_API.layout.hideStorylineFrame = hideStorylineFrame;

---
-- Show Storyline's frame if it is hidden and hide it if it is shown.
-- @param showFrame (optional) True to show the frame, false to hide it.
local toggleStorylineFrame = function(showFrame)
	if showFrame == nil then
		showFrame = not Storyline_NPCFrame:IsShown();
	end
	if showFrame then
		showStorylineFrame();
	else
		hideStorylineFrame();
	end
end
Storyline_API.layout.toggleStorylineFrame = toggleStorylineFrame;

Storyline_API.layout.showDefaultFrames = function()
	hideStorylineFrame();
	for _, frame in pairs(defaultFramesWeWantToReplace) do
		addToLayoutEngine(frame);
	end
end


---
-- Remove the default quest frame and dialog frames from the array of frames
-- managed by the game UI layout engine.
-- When function will call for those frames to be placed by the UI layout engine
-- it will fail silently and the frames will not be shown at all.
local hideDefaultFrames = function()
	hideStorylineFrame();
	for _, frame in pairs(defaultFramesWeWantToReplace) do
		_G[frame]:Hide();
		removeFrameFromUILayoutEngine(frame)
	end
end
Storyline_API.layout.hideDefaultFrames = hideDefaultFrames;

Storyline_API.lib.registerHandler("PLAYER_ENTERING_WORLD", function()
	if Storyline_Data.config.disableInInstances and Storyline_Data.config.hideOriginalFrames then
		if IsInInstance() then
			Storyline_API.layout.showDefaultFrames();
		else
			Storyline_API.layout.hideDefaultFrames();
		end
	end
end)

---
-- When Storyline's frame is hidden, try to call the cancelMethod registered if it exists.
-- This is for when Storyline's frame is hidden by an external event (probably the UI layout engine)
-- so we need to close the quest or dialog frame too.
Storyline_NPCFrame:SetScript("OnHide", function()
	if Storyline_NPCFrameChat.eventInfo and Storyline_NPCFrameChat.eventInfo.cancelMethod then
		Storyline_NPCFrameChat.eventInfo.cancelMethod();
		Storyline_NPCFrameChat.eventInfo = nil;
	end
	if useUILayoutEngine then
		CloseGossip(); -- Force CloseGossip() when Storyline is close if using the layout engine to prevent issue with NPC dialogs.
	end
end)