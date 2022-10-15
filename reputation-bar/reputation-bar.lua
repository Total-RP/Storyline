----------------------------------------------------------------------------------
---  Storyline
---  Reputation bar
---	---------------------------------------------------------------------------
---	Copyright 2016 Morgane "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
---
---	Licensed under the Apache License, Version 2.0 (the "License");
---	you may not use this file except in compliance with the License.
---	You may obtain a copy of the License at
---
---		http://www.apache.org/licenses/LICENSE-2.0
---
---	Unless required by applicable law or agreed to in writing, software
---	distributed under the License is distributed on an "AS IS" BASIS,
---	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
---	See the License for the specific language governing permissions and
---	limitations under the License.
----------------------------------------------------------------------------------
---

local Ellyb = Ellyb(...);

---@type StatusBar
local StorylineReputationBar = Storyline_NPCFriendshipStatusBar;

local customReputationColors = {
	NIGHTFALLEN = CreateColor(0.227,0.203,0.745, 1), -- Arcane thirst of the Nightfallen
}

local customReputationFactionID = {
	[1860]   = customReputationColors.NIGHTFALLEN,
	[1861]   = customReputationColors.NIGHTFALLEN,
	[1862]   = customReputationColors.NIGHTFALLEN,
	[1919]   = customReputationColors.NIGHTFALLEN,
}

local function OnReputationBarEnter(self)
	ReputationBarMixin.ShowFriendshipReputationTooltip(self, self.friendshipFactionID, self, "ANCHOR_TOPRIGHT")
end

StorylineReputationBar:SetScript("OnEnter", OnReputationBarEnter);

local SetStatusBarColorDefault = StorylineReputationBar.SetStatusBarColor;
function StorylineReputationBar:SetStatusBarColor(R, G, B, A)
	local customStatusBarColor = customReputationFactionID[StorylineReputationBar.friendshipFactionID];
	if customStatusBarColor then
		R, G, B, A = customStatusBarColor:GetRGBA();
	end
	SetStatusBarColorDefault(StorylineReputationBar, R, G, B, A);
end

hooksecurefunc(GossipFrame.FriendshipStatusBar, "Update", function() StorylineReputationBar:Update() end);
hooksecurefunc(QuestFrame.FriendshipStatusBar, "Update", function() StorylineReputationBar:Update() end)
