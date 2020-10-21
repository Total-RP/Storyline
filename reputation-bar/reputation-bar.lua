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

---@type StatusBar
local StorylineReputationBar = Storyline_NPCFriendshipStatusBar;

-- API
local GetFriendshipReputation = GetFriendshipReputation;


local customReputationColors = {
	[1391545]   = CreateColor(0.227,0.203,0.745, 1), -- Arcane thirst of the Nightfallen
	["DEFAULT"] = CreateColor(0.709,0.396,0.031, 1),
}
local DEFAULT_ICON = [[Interface\Common\friendship-heart]];

hooksecurefunc("NPCFriendshipStatusBar_Update", function(_, factionID --[[ = nil ]])
	local id, rep, maxRep, name, text, texture, reaction, threshold, nextThreshold = GetFriendshipReputation(factionID);
	StorylineReputationBar.friendshipFactionID = id;
	if ( id and id > 0 ) then
		if ( not nextThreshold ) then
			threshold, nextThreshold, rep = 0, 1, 1;
		end

		StorylineReputationBar.icon:SetTexture(texture or DEFAULT_ICON);

		-- Nice touch: we will recolor the status bar for some specific rep, because its prettier :3
		---@type ColorMixin
		local statusBarColor = customReputationColors[texture] or customReputationColors["DEFAULT"];
		StorylineReputationBar:SetStatusBarColor(statusBarColor:GetRGB());

		StorylineReputationBar:SetMinMaxValues(threshold, nextThreshold);
		StorylineReputationBar:SetValue(rep);
		StorylineReputationBar:Show();
	else
		StorylineReputationBar:Hide();
	end
end)