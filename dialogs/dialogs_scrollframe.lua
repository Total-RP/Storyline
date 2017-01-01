----------------------------------------------------------------------------------
-- Storyline
-- Dialogs scroll frame API
--
-- This API will provide everything necessary to display the scroll frame containing dialogs choices.
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

-- Setting up our global API
Storyline_API.dialogs.scrollFrame = {};
local API = Storyline_API.dialogs.scrollFrame;

local scrollFrame = Storyline_DialogChoicesScrollFrame;
local borderBottom = Storyline_DialogChoicesScrollFrame.borderBottom;
local borderTop = Storyline_DialogChoicesScrollFrame.borderTop;
local container = Storyline_DialogChoicesScrollFrame.container;
API.container = container;

local FRAME_PROPORTIONS = {
	TOP = {
		ANCHOR = "Storyline_NPCFrame",
		MAX = 500,
		MIN = 60
	},
	BOTTOM = {
		ANCHOR = "Storyline_NPCFrameChat",
		MAX = 450,
		MIN = 20
	},
	WIDTH = {
		MAX = 650,
		MIN = 300
	}
}

function API.show(totalButtonHeights)
	if totalButtonHeights and totalButtonHeights > API.getHeight() then
		API.showBorderBottom();
	end
	scrollFrame:Show();
end

function API.getHeight()
	return scrollFrame:GetHeight();
end


function API.showBorderBottom()
	borderBottom:Show();
	borderBottom.pulse:Play();
end

function API.hideBorderBottom()
	borderBottom:Hide();
	borderBottom.pulse:Stop();
end

function API.showBorderTop()
	borderTop:Show();
	borderTop.pulse:Play();
end

function API.hideBorderTop()
	borderTop:Hide();
	borderTop.pulse:Stop();
end

function API.hide()
	scrollFrame:Hide();
	API.hideBorderBottom();
	API.hideBorderTop();
end

function API.refreshMargins(width, height)
	if not width then
		width = Storyline_NPCFrame:GetWidth();
	end
	if not height then
		height = Storyline_NPCFrame:GetHeight();
	end
	local availableHeight = height - _G[FRAME_PROPORTIONS.BOTTOM.ANCHOR]:GetHeight();

	local marginTop = 20 * availableHeight / 100;
	local marginBottom = 10 * availableHeight / 100;


	if marginTop > FRAME_PROPORTIONS.TOP.MAX then
		marginTop = FRAME_PROPORTIONS.TOP.MAX
	elseif marginTop < FRAME_PROPORTIONS.TOP.MIN then
		marginTop = FRAME_PROPORTIONS.TOP.MIN
	end
	if marginBottom > FRAME_PROPORTIONS.BOTTOM.MAX then
		marginBottom = FRAME_PROPORTIONS.BOTTOM.MAX
	elseif marginBottom < FRAME_PROPORTIONS.BOTTOM.MIN then
		marginBottom = FRAME_PROPORTIONS.BOTTOM.MIN
	end

	local frameWidth = 35 * width / 100;

	if frameWidth > FRAME_PROPORTIONS.WIDTH.MAX then
		frameWidth = FRAME_PROPORTIONS.WIDTH.MAX
	elseif frameWidth < FRAME_PROPORTIONS.WIDTH.MIN then
		frameWidth = FRAME_PROPORTIONS.WIDTH.MIN
	end

	scrollFrame:SetPoint("TOP", _G[FRAME_PROPORTIONS.TOP.ANCHOR], "TOP", 0, -1 * marginTop);
	scrollFrame:SetPoint("BOTTOM", _G[FRAME_PROPORTIONS.BOTTOM.ANCHOR], "TOP", 0, marginBottom);
	scrollFrame:SetWidth(frameWidth);
	scrollFrame.container:SetWidth(frameWidth);
end

scrollFrame:HookScript("OnMousewheel", function(self, delta)
	local currentScroll = self:GetVerticalScroll();
	local maxScroll = self:GetVerticalScrollRange();

	if currentScroll >= maxScroll - 1 then
		API.hideBorderBottom();
	else
		API.showBorderBottom();
	end
	if currentScroll < 20 then
		API.hideBorderTop();
	else
		API.showBorderTop();
	end
end)
