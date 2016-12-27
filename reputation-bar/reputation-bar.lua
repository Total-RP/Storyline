----------------------------------------------------------------------------------
--  Storyline
--  Reputation bar
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

Storyline_API.reputationBar = {};
local API = Storyline_API.reputationBar;

-- API
local GetFriendshipReputation = GetFriendshipReputation;

-- Imports
local statusBar = Storyline_NPCFriendshipStatusBar;


local customReputationColors = {
	[1391545] = { -- Arcane thirst of the Nightfallen
		r = .227,
		g = .203,
		b = .745
	},
	["DEFAULT"] = {
		r = .709,
		g = .396,
		b = .031
	}
}

function API.update()
	local id, rep, maxRep, name, text, texture, reaction, threshold, nextThreshold = GetFriendshipReputation();
	if ( id and id > 0 ) then
		if ( not nextThreshold ) then
			threshold, nextThreshold, rep = 0, 1, 1;
		end

		statusBar.icon:SetTexture(texture or "Interface\\Common\\friendship-heart");

		-- Nice touch: we will recolor the status bar for some specific rep, because its prettier :3
		local statusBarColor = customReputationColors[texture] or customReputationColors["DEFAULT"];
		statusBar:SetStatusBarColor(statusBarColor.r, statusBarColor.g, statusBarColor.b);

		statusBar:SetMinMaxValues(threshold, nextThreshold);
		statusBar:SetValue(rep);
		statusBar:Show();
	else
		statusBar:Hide();
	end
end