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

local FRIENDSHIP_BAR_COLORS = {
	[1] = PURE_RED_COLOR,
	[2] = FACTION_ORANGE_COLOR,
	[3] = FACTION_YELLOW_COLOR,
	[4] = FACTION_GREEN_COLOR,
};

local customReputationColors = {
	[1391545]   = CreateColor(0.227,0.203,0.745, 1), -- Arcane thirst of the Nightfallen
}
local DEFAULT_ICON = [[Interface\Common\friendship-heart]];

local function OnReputationBarLoad(self)
	local texture = self:CreateTexture(nil, "BORDER", nil, -1);
	texture:SetGradient("VERTICAL", Ellyb.Color.CreateFromRGBA(8/255, 93/255, 72/255, 1), Ellyb.Color.CreateFromRGBA(11/255, 136/255, 105/255, 1));
	self:SetStatusBarTexture(texture);
end

local function OnReputationBarEnter(self)
	ReputationBarMixin.ShowFriendshipReputationTooltip(self, self.friendshipFactionID, self, "ANCHOR_TOPRIGHT")
end

local function OnReputationBarLeave(self)
	GameTooltip:Hide();
end

StorylineReputationBar:SetScript("OnLoad", OnReputationBarLoad);
StorylineReputationBar:SetScript("OnEnter", OnReputationBarEnter);
StorylineReputationBar:SetScript("OnLeave", OnReputationBarLeave);

local function UpdateFriendship(_, factionID)
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID or 0);
	if reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0 then
		StorylineReputationBar.friendshipFactionID = reputationInfo.friendshipFactionID;
		if ( not reputationInfo.nextThreshold ) then
			reputationInfo.reactionThreshold, reputationInfo.nextThreshold, reputationInfo.standing = 0, 1, 1;
		end

		StorylineReputationBar.icon:SetTexture(reputationInfo.texture or DEFAULT_ICON);

		local numColors = 4;
		local colorIndex;
		if (not reputationInfo.overrideColor) then
			local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(reputationInfo.friendshipFactionID);

			colorIndex = StorylineReputationBar:GetColorIndex(rankInfo.currentLevel, rankInfo.maxLevel, numColors);
		else
			colorIndex = reputationInfo.overrideColor;
		end

		-- Nice touch: we will recolor the status bar for some specific rep, because its prettier :3
		---@type ColorMixin
		local statusBarColor = customReputationColors[reputationInfo.texture] or FRIENDSHIP_BAR_COLORS[colorIndex];
		StorylineReputationBar:SetStatusBarColor(statusBarColor:GetRGB());

		StorylineReputationBar:SetMinMaxValues(reputationInfo.reactionThreshold, reputationInfo.nextThreshold);
		StorylineReputationBar:SetValue(reputationInfo.standing);
		StorylineReputationBar:Show();
	else
		StorylineReputationBar:Hide();
	end
end

hooksecurefunc(GossipFrame.FriendshipStatusBar, "Update", UpdateFriendship)
hooksecurefunc(QuestFrame.FriendshipStatusBar, "Update", UpdateFriendship)
