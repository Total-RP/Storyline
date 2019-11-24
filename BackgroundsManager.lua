----------------------------------------------------------------------------------
--- Storyline
--- ------------------------------------------------------------------------------
--- Copyright 2019 Renaud "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
---
--- Licensed under the Apache License, Version 2.0 (the "License");
--- you may not use this file except in compliance with the License.
--- You may obtain a copy of the License at
---
--- http://www.apache.org/licenses/LICENSE-2.0
---
--- Unless required by applicable law or agreed to in writing, software
--- distributed under the License is distributed on an "AS IS" BASIS,
--- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--- See the License for the specific language governing permissions and
--- limitations under the License.
----------------------------------------------------------------------------------

local DYNAMIC_BACKGROUNDS = {

    --region Battle for Azeroth

    ["1161"] = "TiragardeSound", -- Boralus
    ["895"] = "TiragardeSound",
    ["1196"] = "TiragardeSound",
    ["876"] = "TiragardeSound", -- Kul Tiras, fallback for all Alliance zones
    ["942"] = "Stormsong",
    ["1198"] = "Stormsong",
    ["896"] = "Drustvar",
    ["1197"] = "Drustvar",
    ["862"] = "Zuldazar",
    ["1181"] = "Zuldazar",
    ["1193"] = "Zuldazar",
    ["1163"] = "Zuldazar", -- Dazar'alor
    ["1164"] = "Zuldazar", -- Dazar'alor
    ["1165"] = "Zuldazar", -- Dazar'alor
    ["1352"] = "Zuldazar", -- Battle for Dazar'alor
    ["1353"] = "Zuldazar", -- Battle for Dazar'alor
    ["1354"] = "Zuldazar", -- Battle for Dazar'alor
    ["1356"] = "Zuldazar", -- Battle for Dazar'alor
    ["1357"] = "Zuldazar", -- Battle for Dazar'alor
    ["1358"] = "Zuldazar", -- Battle for Dazar'alor
    ["1364"] = "Zuldazar", -- Battle for Dazar'alor
    ["1367"] = "Zuldazar", -- Battle for Dazar'alor
    ["875"] = "Zuldazar", -- Zandalar, fallback for all Horde zones
    ["864"] = "Voldun",
    ["1195"] = "Voldun",
    ["863"] = "Nazmir",
    ["1194"] = "Nazmir",
    ["1355"] = "Nazjatar",
    ["1504"] = "Nazjatar",
    ["1528"] = "Nazjatar",
    ["1462"] = "Mechagon",
    ["1490"] = "Mechagon",
    ["1491"] = "Mechagon",
    ["1493"] = "Mechagon",
    ["1494"] = "Mechagon",
    ["1497"] = "Mechagon",

    --endregion

    --region Legion

    ["630"] = "Azsuna",
    ["867"] = "Azsuna",
    ["1187"] = "Azsuna",
    ["41"] = "Dalaran",
    ["125"] = "Dalaran",
    ["126"] = "Dalaran",
    ["501"] = "Dalaran",
    ["502"] = "Dalaran",
    ["625"] = "Dalaran",
    ["626"] = "Dalaran",
    ["627"] = "Dalaran",
    ["628"] = "Dalaran",
    ["629"] = "Dalaran",
    ["650"] = "Highmountain",
    ["869"] = "Highmountain",
    ["870"] = "Highmountain",
    ["1189"] = "Highmountain",
    ["634"] = "Stormheim",
    ["696"] = "Stormheim",
    ["865"] = "Stormheim",
    ["866"] = "Stormheim",
    ["1190"] = "Stormheim",
    ["680"] = "Suramar",
    ["1191"] = "Suramar",
    ["641"] = "Valsharah",
    ["868"] = "Valsharah",
    ["1188"] = "Valsharah",
    ["905"] = "Argus",
    ["994"] = "Argus",
    ["885"] = "Argus", -- Antoran Wastes
    ["882"] = "Argus", -- Mac'Aree
    ["830"] = "Argus", -- Krokuun
    ["831"] = "Argus", -- Vindicaar
    ["887"] = "Argus", -- Vindicaar
    ["883"] = "Argus", -- Vindicaar
    ["619"] = "Legion", -- Fallback for all legion zones

    --endregion

    --region Old world

    ["14"] = "ArathiHighlands", -- Arathi Highlands
    ["93"] = "ArathiHighlands", -- Arathi Basin
    ["837"] = "ArathiHighlands", -- Arathi Basin
    ["844"] = "ArathiHighlands", -- Arathi Basin
    ["906"] = "ArathiHighlands", -- Arathi Highlands
    ["943"] = "ArathiHighlands", -- Arathi Highlands
    ["1044"] = "ArathiHighlands", -- Arathi Highlands
    ["1158"] = "ArathiHighlands", -- Arathi Highlands
    ["1244"] = "ArathiHighlands", -- Arathi Highlands
    ["1366"] = "ArathiHighlands", -- Arathi Basin
    ["1383"] = "ArathiHighlands", -- Arathi Basin
    ["63"] = "Ashenvale",
    ["1310"] = "Ashenvale",
    ["76"] = "Azshara",
    ["697"] = "Azshara",
    ["1209"] = "Azshara",
    ["62"] = "Darkshore",
    ["1203"] = "Darkshore",
    ["1309"] = "Darkshore",
    ["1332"] = "Darkshore",
    ["1333"] = "Darkshore",
    ["1338"] = "Darkshore",
    ["1343"] = "Darkshore",
    ["1"] = "Durotar",
    ["1305"] = "Durotar",
    ["25"] = "HillsbradFoothills", -- Hillsbrad Foothills
    ["274"] = "HillsbradFoothills", -- Old Hillsbrad Foothills
    ["623"] = "HillsbradFoothills", -- Hillsbrad Foothills (Southshore vs. Tarren Mill)
    ["10"] = "NorthernBarrens", -- Northern Barrens
    ["1307"] = "NorthernBarrens", -- Northern Barrens
    ["21"] = "SilverpineForest",
    ["1248"] = "SilverpineForest",
    ["199"] = "SouthernBarrens",
    ["1329"] = "SouthernBarrens",

    --endregion

    --region Warlords of Draenor

    ["525"] = "FrostfireRidge",
    ["543"] = "Gorgrond",
    ["1170"] = "Gorgrond", -- Mag'har Scenario
    ["107"] = "Nagrand",
    ["550"] = "Nagrand",
    ["104"] = "ShadowmoonValley",
    ["539"] = "ShadowmoonValley",
    ["542"] = "SpiresofArak",
    ["535"] = "Talador",
    ["534"] = "TannanJungle",
    ["577"] = "TannanJungle",
    ["572"] = "Talador", -- Draenor, fallback for all Warlords of Draenor content


    --endregion
}

-- Use the game's Map API to get a known map ID for the player, bubbling up the chain (cave level > sub-zone > zone > continent)
local function getBestKnownMapId()
    local mapID = C_Map.GetBestMapForUnit("player")
    if mapID then
        repeat
            if DYNAMIC_BACKGROUNDS[tostring(mapID)] then
                return mapID
            end
            local mapInfo = C_Map.GetMapInfo(mapID)
            mapID = mapInfo and mapInfo.parentMapID or 0
        until mapID == 0
    end
    return C_Map.GetFallbackWorldMapID();
end

local function getCustomBackgroundForPlayer()
    return DYNAMIC_BACKGROUNDS[tostring(getBestKnownMapId())]
end

---@class StorylineBackgroundTexture: Texture
StorylineBackgroundTexture = {}

local DEFAULT_BACKGROUND_TEXTURE = [[Interface\DRESSUPFRAME\DressUpBackground-NightElf1]]

-- This part is copied from Blizzard's QuestInfo.lua, as it is not exposed via a proper API
local SEAL_QUESTS = {
    [40519] = { bgAtlas = "QuestBG-Alliance", text = "|cff042c54"..QUEST_KING_VARIAN_WRYNN.."|r", sealAtlas = "Quest-Alliance-WaxSeal"},
    [43926] = { bgAtlas = "QuestBG-Horde", text = "|cff480404"..QUEST_WARCHIEF_VOLJIN.."|r", sealAtlas = "Quest-Horde-WaxSeal"},
    [47221] = { bgAtlas = "QuestBG-TheHandofFate", },
    [47835] = { bgAtlas = "QuestBG-TheHandofFate", },
    [49929] = { bgAtlas = "QuestBG-Alliance", text = "|cff042c54"..QUEST_KING_ANDUIN_WRYNN.."|r", sealAtlas = "Quest-Alliance-WaxSeal" },
    [49930] = { bgAtlas = "QuestBG-Horde", text = "|cff480404"..QUEST_WARCHIEF_SYLVANAS_WINDRUNNER.."|r", sealAtlas = "Quest-Horde-WaxSeal" },
    [50476] = { bgAtlas = "QuestBG-Horde", sealAtlas = "Quest-Horde-WaxSeal" },
    -- BfA start quests
    [46727] = { bgAtlas = "QuestBG-Alliance", text = "|cff042c54"..QUEST_KING_ANDUIN_WRYNN.."|r", sealAtlas = "Quest-Alliance-WaxSeal" },
    [50668] = { bgAtlas = "QuestBG-Horde", text = "|cff480404"..QUEST_WARCHIEF_SYLVANAS_WINDRUNNER.."|r", sealAtlas = "Quest-Horde-WaxSeal"},

    [51795] = { bgAtlas = "QuestBG-Alliance" },
    [52058] = { bgAtlas = "QuestBG-Alliance", text = "|cff042c54"..QUEST_KING_ANDUIN_WRYNN.."|r", sealAtlas = "Quest-Alliance-WaxSeal"},

    [51796] = { bgAtlas = "QuestBG-Horde" },

    [53372] = { bgAtlas = "QuestBG-Horde", text = "|cff480404"..QUEST_WARCHIEF_SYLVANAS_WINDRUNNER.."|r", sealAtlas = "Quest-Horde-WaxSeal"},
    [53370] = { bgAtlas = "QuestBG-Alliance", text = "|cff042c54"..QUEST_KING_ANDUIN_WRYNN.."|r", sealAtlas = "Quest-Alliance-WaxSeal"},
};

function Storyline_API.isASealedQuest(questId)
    return SEAL_QUESTS[questId] ~= nil
end
local EXCEPTION_QUESTS = {
    [53029] = true,
    [53026] = true,
    [51211] = true,
    [52428] = true,
};

function StorylineBackgroundTexture:OnLoad()
    self.dimmingLayer:SetVertexColor(0.7, 0.7, 0.7, 1)
    self.SealText:SetFontObjectsToTry("QuestFont_Huge", "QuestFont_Large", "Fancy14Font", "Fancy12Font");
end

function StorylineBackgroundTexture:RefreshBackground(questId)

    self.SealTexture:Hide()
    self.SealText:Hide()

    -- Special waxed seal quests
    if SEAL_QUESTS[questId] ~= nil then
        local specialQuestDisplayInfo = SEAL_QUESTS[questId];
        self.backgroundLayer:SetAtlas(specialQuestDisplayInfo.bgAtlas);
        self.backgroundLayer:SetTexCoord(0.2, 0.99, 0.5, 0.95)
        self.dimmingLayer:SetAlpha(0.5)
        self.backgroundLayer:Show()
        self.middlegroundLayer:Hide()
        self.foregroundLayer:Hide()

        if specialQuestDisplayInfo.sealAtlas then
            self.SealTexture:Show();
            self.SealTexture:SetAtlas(specialQuestDisplayInfo.sealAtlas);
        end

        if specialQuestDisplayInfo.text then
            self.SealText:Show();
            self.SealText:SetText(specialQuestDisplayInfo.text);
        end

        -- War campaign quests, with a faction themed background
    elseif C_CampaignInfo.IsCampaignQuest(questId) and not EXCEPTION_QUESTS[questId] then
        self.backgroundLayer:SetAtlas( "QuestBG-" .. UnitFactionGroup("player"));
        self.backgroundLayer:SetTexCoord(0.2, 0.99, 0.5, 0.95)
        self.dimmingLayer:SetAlpha(0.5)
        self.backgroundLayer:Show()
        self.middlegroundLayer:Hide()
        self.foregroundLayer:Hide()

        -- Dynamic backgrounds
    elseif Storyline_Data.config.dynamicBackgrounds and getCustomBackgroundForPlayer() then
        local dynamicBackground = getCustomBackgroundForPlayer()

        self:ApplyGarrisonBackgroundAtlas(self.backgroundLayer, "locBackTexCoordRange", "_GarrMissionLocation-" .. dynamicBackground .. "-Back")
        self:ApplyGarrisonBackgroundAtlas(self.middlegroundLayer, "locMidTexCoordRange", "_GarrMissionLocation-" .. dynamicBackground .. "-Mid")
        self:ApplyGarrisonBackgroundAtlas(self.foregroundLayer, "locForeTexCoordRange", "_GarrMissionLocation-" .. dynamicBackground .. "-Fore")

        self.dimmingLayer:SetAlpha(0.7)

        -- Regular class themed backgrounds
    else
        local classFilename = select(2, UnitClass("player"))
        if classFilename then
            self.backgroundLayer:SetAtlas("dressingroom-background-" .. classFilename)
            self.backgroundLayer:SetTexCoord(0, 1, 0.25, 0.75)
        else
            self.backgroundLayer:SetTexture(DEFAULT_BACKGROUND_TEXTURE)
        end
        self.dimmingLayer:SetAlpha(0.7)
        self.backgroundLayer:Show()
        self.middlegroundLayer:Hide()
        self.foregroundLayer:Hide()
    end

end

function StorylineBackgroundTexture:ApplyGarrisonBackgroundAtlas(texture, textureCoordRangeKey, atlas)
    if atlas then
        local info = C_Texture.GetAtlasInfo(atlas);
        if info and info.width and info.width ~= 0 then
            texture:SetAtlas(atlas, true);
            texture:SetTexCoord(0.25, 0.75, 0, 1)
            texture:Show();
        else
            texture:Hide();
        end
    else
        texture:Hide();
    end
end