----------------------------------------------------------------------------------
--- Storyline
--- ------------------------------------------------------------------------------
--- Copyright 2019 Morgane "Ellypse" Parize <ellypse@totalrp3.info> @EllypseCelwe
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

local STATIC_BACKGROUNDS = {
    ["1409"] = "charactercreate-startingzone-exilesreach",

    --Blood Elf

    ["467"] = "charactercreate-startingzone-bloodelf", -- Sunstrider Isle (Eversong)
    ["94"] = "charactercreate-startingzone-bloodelf", -- Eversong
    ["1267"] = "charactercreate-startingzone-bloodelf", -- Eversong 2

    --Draenei

    ["1325"] = "charactercreate-startingzone-draenei", -- Azuremyst
    ["97"] = "charactercreate-startingzone-draenei", -- Azuremyst 2
    ["98"] = "charactercreate-startingzone-draenei", -- Tides' Hollow (Microdungeon)
    ["99"] = "charactercreate-startingzone-draenei", -- Stillpine Hold (Microdungeon)
    ["468"] = "charactercreate-startingzone-draenei", -- Ammen Vale (Azuremyst)
    ["776"] = "charactercreate-startingzone-draenei", -- Azuremyst (Orphan)
    ["891"] = "charactercreate-startingzone-draenei", -- Azuremyst (Legion Scenario)
    ["892"] = "charactercreate-startingzone-draenei", -- Azuremyst (Legion Scenario 2)
    ["893"] = "charactercreate-startingzone-draenei", -- Azuremyst (Legion Scenario 3)
    ["894"] = "charactercreate-startingzone-draenei", -- Azuremyst (Legion Scenario 4)

    --Worgen

    ["179"] = "charactercreate-startingzone-worgen", -- Gilneas (Orphan)
    ["180"] = "charactercreate-startingzone-worgen", -- Emberstone Mine (Microdungeon)
    ["181"] = "charactercreate-startingzone-worgen", -- Greymane Manor (Microdungeon)
    ["182"] = "charactercreate-startingzone-worgen", -- Greymane Manor 2 (Microdungeon)
    ["202"] = "charactercreate-startingzone-worgen", -- Gilneas City (Gilneas)
    ["217"] = "charactercreate-startingzone-worgen", -- Ruins of Gilneas
    ["218"] = "charactercreate-startingzone-worgen", -- Ruins of Gilneas City (Orphan)
    ["1030"] = "charactercreate-startingzone-worgen", -- Greymane Manor 3 (Microdungeon)
    ["1031"] = "charactercreate-startingzone-worgen", -- Greymane Manor 4 (Microdungeon)
    ["1271"] = "charactercreate-startingzone-worgen", -- Gilneas
    ["1273"] = "charactercreate-startingzone-worgen", -- Ruins of Gilneas 2
    ["1577"] = "charactercreate-startingzone-worgen", -- Gilneas City 2 (Gilneas)

    --Goblin

    ["194"] = "charactercreate-startingzone-goblin", -- Kezan
    ["195"] = "charactercreate-startingzone-goblin", -- Kaja'mine (Microdungeon)
    ["196"] = "charactercreate-startingzone-goblin", -- Kaja'mine 2 (Microdungeon)
    ["197"] = "charactercreate-startingzone-goblin", -- Kaja'mine 3 (Microdungeon)

    --["174"] = "charactercreate-startingzone-goblin", -- The Lost Isles
    --["175"] = "charactercreate-startingzone-goblin", -- Kaja'mite Cavern (Microdungeon)
    --["176"] = "charactercreate-startingzone-goblin", -- Volcanoth's Lair (Microdungeon)
    --["177"] = "charactercreate-startingzone-goblin", -- Gallywix Labor Mine (Microdungeon)
    --["178"] = "charactercreate-startingzone-goblin", -- Gallywix Labor Mine 2 (Microdungeon)

    --Human

    ["37"] = "charactercreate-startingzone-human", -- Elwynn Forest
    ["38"] = "charactercreate-startingzone-human", -- Fargodeep Mine (Microdungeon)
    ["39"] = "charactercreate-startingzone-human", -- Fargodeep Mine (Microdungeon)
    ["40"] = "charactercreate-startingzone-human", -- Jasperlode Mine (Microdungeon)
    ["425"] = "charactercreate-startingzone-human", -- Northshire (Elwynn Forest)
    ["426"] = "charactercreate-startingzone-human", -- Echo Ridge Mine (Microdungeon)
    ["1256"] = "charactercreate-startingzone-human", -- Elwynn Forest 2

    --Dwarf

    ["27"] = "charactercreate-startingzone-dwarf", -- Dun Morogh
    ["28"] = "charactercreate-startingzone-dwarf", -- Colridge Pass (Microdungeon)
    ["29"] = "charactercreate-startingzone-dwarf", -- The Grizzled Den (Microdungeon)
    ["31"] = "charactercreate-startingzone-dwarf", -- Gol'Bolar Quarry (Microdungeon)
    ["427"] = "charactercreate-startingzone-dwarf", -- Coldridge Valley (Orphan)
    ["428"] = "charactercreate-startingzone-dwarf", -- Frostmane Hovel (Microdungeon)
    ["470"] = "charactercreate-startingzone-dwarf", -- Frostmane Hold (Microdungeon)
    ["523"] = "charactercreate-startingzone-dwarf", -- Dun Morogh (Orphan)
    ["843"] = "charactercreate-startingzone-dwarf", -- Coldridge Valley (Orphan)
    ["1253"] = "charactercreate-startingzone-dwarf", -- Dun Morogh 2

    --Gnome

    ["30"] = "charactercreate-startingzone-gnome", -- New Tinkertown (The Gnomeregan Starting Zone)
    ["469"] = "charactercreate-startingzone-gnome", -- New Tinkertown 2 (The Outdoor Gnome Zone)
    --["840"] = "charactercreate-startingzone-gnome", -- Gnomeregan 1 (Dungeon)
    --["841"] = "charactercreate-startingzone-gnome", -- Gnomeregan 2 (Dungeon)
    --["842"] = "charactercreate-startingzone-gnome", -- Gnomeregan 3 (Dungeon)
    --["1371"] = "charactercreate-startingzone-gnome", -- Gnomeregan A
    --["1372"] = "charactercreate-startingzone-gnome", -- Gnomeregan B
    --["1380"] = "charactercreate-startingzone-gnome", -- Gnomeregan C
    --["1374"] = "charactercreate-startingzone-gnome", -- Gnomeregan D

    --Night Elf

    ["57"] = "charactercreate-startingzone-nightelf", -- Teldrassil
    ["58"] = "charactercreate-startingzone-nightelf", -- Shadowthread Cave (Microdungeon)
    ["59"] = "charactercreate-startingzone-nightelf", -- Fel Rock (Microdungeon)
    ["60"] = "charactercreate-startingzone-nightelf", -- Ban'ethil Barrow Den (Microdungeon)
    ["61"] = "charactercreate-startingzone-nightelf", -- Ban'ethil Barrow Den 2 (Microdungeon)
    ["460"] = "charactercreate-startingzone-nightelf", -- Shadowglen (Teldrassil)
    ["1308"] = "charactercreate-startingzone-nightelf", -- Teldrassil 2

    --Orc

    ["1"] = "charactercreate-startingzone-orc", -- Durotar
    ["2"] = "charactercreate-startingzone-orc", -- Burning Blade Coven (Microdungeon)
    ["3"] = "charactercreate-startingzone-orc", -- Tiragarde Keep (Microdungeon)
    ["4"] = "charactercreate-startingzone-orc", -- Tiragarde Keep 2 (Microdungeon)
    ["5"] = "charactercreate-startingzone-orc", -- Skull Rock (Microdungeon)
    ["6"] = "charactercreate-startingzone-orc", -- Dustwind Cave (Microdungeon)
    ["461"] = "charactercreate-startingzone-orc", -- Valley of Trials (Durotar)
    ["1305"] = "charactercreate-startingzone-orc", -- Durotar 2

    --Troll

    ["463"] = "charactercreate-startingzone-troll", -- Echo Isles (Durotar)
    ["464"] = "charactercreate-startingzone-troll", -- Spitescale Cavern (Microdungeon)

    --Tauren

    ["7"] = "charactercreate-startingzone-tauren", -- Mulgore
    ["8"] = "charactercreate-startingzone-tauren", -- Palemane Rock (Microdungeon)
    ["9"] = "charactercreate-startingzone-tauren", -- The Venture Co. Mine (Microdungeon)
    ["462"] = "charactercreate-startingzone-tauren", -- Camp Narache (Mulgore)
    ["1306"] = "charactercreate-startingzone-tauren", -- Mulgore 2

    --Undead (or Forsaken if you're feeling politically correct)

    ["18"] = "charactercreate-startingzone-undead", -- Tirisfal Glades
    ["19"] = "charactercreate-startingzone-undead", -- Scarlet Monastery Entrance (Microdungeon)
    ["20"] = "charactercreate-startingzone-undead", -- Keeper's Rest (Microdungeon)
    --["302"] = "charactercreate-startingzone-undead", -- Scarlet Monastery 1 (Dungeon)
    --["303"] = "charactercreate-startingzone-undead", -- Scarlet Monastery 2 (Dungeon)
    --["304"] = "charactercreate-startingzone-undead", -- Scarlet Monastery 3 (Dungeon)
    --["305"] = "charactercreate-startingzone-undead", -- Scarlet Monastery 4 (Dungeon)
    --["431"] = "charactercreate-startingzone-undead", -- Scarlet Halls 1 (Dungeon)
    --["432"] = "charactercreate-startingzone-undead", -- Scarlet Halls 2 (Dungeon)
    --["435"] = "charactercreate-startingzone-undead", -- Scarlet Monastery New 1 (Dungeon)
    --["436"] = "charactercreate-startingzone-undead", -- Scarlet Monastery New 2 (Dungeon)
    ["465"] = "charactercreate-startingzone-undead", -- Deathknell (Tirisfal Glades)
    ["466"] = "charactercreate-startingzone-undead", -- Night's Web Hollow (Microdungeon)
    --["804"] = "charactercreate-startingzone-undead", -- SM Newer 1 (Dungeon)
    --["805"] = "charactercreate-startingzone-undead", -- SM Newer 2 (Dungeon)
    ["997"] = "charactercreate-startingzone-undead", -- Tirisfal Glades 2
    ["1247"] = "charactercreate-startingzone-undead", -- Tirisfal Glades 3
    --["1465"] = "charactercreate-startingzone-undead", -- Scarlet Halls (Dungeon)

    --Pandaren
    ["378"] = "charactercreate-startingzone-pandaren", -- The Wandering Isle
    ["709"] = "charactercreate-startingzone-pandaren", -- The Wandering Isle (Legion)

    --region Shadowlands
    ["1533"] = "CovenantChoice-Offering-Preview-Frame-Background-Kyrian",
    ["1569"] = "CovenantChoice-Offering-Preview-Frame-Background-Kyrian",
    ["1813"] = "CovenantChoice-Offering-Preview-Frame-Background-Kyrian",

    ["1536"] = "CovenantChoice-Offering-Preview-Frame-Background-Necrolord",
    ["1689"] = "CovenantChoice-Offering-Preview-Frame-Background-Necrolord",
    ["1741"] = "CovenantChoice-Offering-Preview-Frame-Background-Necrolord",
    ["1814"] = "CovenantChoice-Offering-Preview-Frame-Background-Necrolord",

    ["1565"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",
    ["1603"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",
    ["1643"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",
    ["1709"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",
    ["1739"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",
    ["1740"] = "CovenantChoice-Offering-Preview-Frame-Background-NightFae",

    ["1525"] = "CovenantChoice-Offering-Preview-Frame-Background-Venthyr",
    ["1688"] = "CovenantChoice-Offering-Preview-Frame-Background-Venthyr",
    ["1734"] = "CovenantChoice-Offering-Preview-Frame-Background-Venthyr",
    ["1738"] = "CovenantChoice-Offering-Preview-Frame-Background-Venthyr",
    ["1742"] = "CovenantChoice-Offering-Preview-Frame-Background-Venthyr",

    --endregion

}

-- Use the game's Map API to get a known map ID for the player, bubbling up the chain (cave level > sub-zone > zone > continent)
local function getBestKnownMapId(pool)
    local mapID = C_Map.GetBestMapForUnit("player")
    if mapID then
        repeat
            if pool[tostring(mapID)] then
                return mapID
            end
            local mapInfo = C_Map.GetMapInfo(mapID)
            mapID = mapInfo and mapInfo.parentMapID or 0
        until mapID == 0
    end
    return C_Map.GetFallbackWorldMapID();
end

local function getCustomBackgroundForPlayer()
    return DYNAMIC_BACKGROUNDS[tostring(getBestKnownMapId(DYNAMIC_BACKGROUNDS))]
end

local function getCustomZoneBackground()
    return STATIC_BACKGROUNDS[tostring(getBestKnownMapId(STATIC_BACKGROUNDS))]
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

    -- BfA 8.3
    [58582] = { bgAtlas = "QuestBG-Horde", sealAtlas = "Quest-Horde-WaxSeal" },
    [58496] = { bgAtlas = "QuestBG-Alliance", sealAtlas = "Quest-Alliance-WaxSeal"},
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

function StorylineBackgroundTexture:RefreshBackground()

    self.SealTexture:Hide()
    self.SealText:Hide()

    local questId = GetQuestID()
    local theme = C_QuestLog.GetQuestDetailsTheme(questId);

    -- Special waxed seal quests
    if theme and theme.background then
        self.backgroundLayer:SetAtlas(theme.background);
        self.backgroundLayer:SetTexCoord(0.2, 0.99, 0.60, 0.95)
        self.dimmingLayer:SetAlpha(0.5)
        self.backgroundLayer:Show()
        self.middlegroundLayer:Hide()
        self.foregroundLayer:Hide()

    elseif SEAL_QUESTS[questId] ~= nil then
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
    elseif Storyline_Data.config.dynamicBackgrounds and getCustomZoneBackground() then
        local zoneBackground = getCustomZoneBackground()
        self.backgroundLayer:SetTexCoord(0, 1, 0, 1)
        self.backgroundLayer:SetAtlas(zoneBackground, false)
        self.dimmingLayer:SetAlpha(0.7)
        self.backgroundLayer:Show()
        self.middlegroundLayer:Hide()
        self.foregroundLayer:Hide()
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