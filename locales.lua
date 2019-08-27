----------------------------------------------------------------------------------
--  Storyline
--	---------------------------------------------------------------------------
--	Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--	Copyright 2015 Renaud "Ellypse" Parize (ellypse@totalrp3.info)
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

---@class Storyline_API
Storyline_API = {
	lib = {},
	locale = {},
};

local localeContent = {
	SL_STORYLINE = "Storyline",
	SL_SELECT_DIALOG_OPTION = "Select dialog option",
	SL_SELECT_AVAILABLE_QUEST = "Select available quest",
	SL_ACCEPTANCE = "I accept.",
	SL_DECLINE = "I refuse.",
	SL_NEXT = "Continue",
	SL_CONTINUE = "Complete quest",
	SL_NOT_YET = "Come back when it's done",
	SL_CHECK_OBJ = "Check objectives",
	SL_RESET = "Rewind",
	SL_RESET_TT = "Rewind this dialogue.",
	SL_REWARD_MORE = "You will also get",
	SL_REWARD_MORE_SUB = "\nMoney: |cffffffff%s|r\nExperience: |cffffffff%s xp|r\n\n|cffffff00Click:|r Get your reward!",
	SL_GET_REWARD = "Get your reward",
	SL_SELECT_REWARD = "Select your reward",
	SL_CONFIG = "Settings",
	SL_CONFIG_WELCOME = [[Thank you for using Storyline!

You can follow Storyline developers on Twitter |cff55acee@EllypseCelwe|r and |cff55acee@Telkostrasz|r to get news about the add-on and sneek peaks of its development.
]],
	SL_CONFIG_LANGUAGE = "Language",
	SL_CONFIG_TEXTSPEED_TITLE = "Text animation speed",
	SL_CONFIG_TEXTSPEED = "%.1fx",
	SL_CONFIG_TEXTSPEED_INSTANT = "No animation",
	SL_CONFIG_TEXTSPEED_HIGH = "Fast",
	SL_CONFIG_AUTOEQUIP = "Auto equip reward (experimental)",
	SL_CONFIG_AUTOEQUIP_TT = "Auto equip rewards if it has a better item lvl.",
	SL_CONFIG_FORCEGOSSIP = "Show flavor texts",
	SL_CONFIG_FORCEGOSSIP_TT = "Show flavor texts on NPCs like merchants or fly masters.",
	SL_CONFIG_USE_KEYBOARD = "Use keyboard shortcuts",
	SL_CONFIG_USE_KEYBOARD_TT = "Use keyboard shortcuts to navigate inside dialogs (space bar to advance, backspace to go back, keys 1 to 0 to select a dialog choice)",
	SL_CONFIG_HIDEORIGINALFRAMES = "Hide original frames",
	SL_CONFIG_HIDEORIGINALFRAMES_TT = "Hide the original quest frame and NPC dialogs frame.",
	SL_CONFIG_LOCKFRAME = "Lock frame",
	SL_CONFIG_LOCKFRAME_TT = "Lock Storyline frame so it cannot be moved by mistake.",
	SL_CONFIG_SAMPLE_TEXT = "Grumpy wizards make toxic brew for the evil queen and jack",
	SL_CONFIG_BIG_SAMPLE_TEXT = [[Here’s to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They’re not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can’t do is ignore them.]],
	SL_CONFIG_QUEST_TITLE = "Quest title",
	SL_CONFIG_DIALOG_TEXT = "Dialog text",
	SL_CONFIG_NPC_NAME = "NPC name",
	SL_CONFIG_NEXT_ACTION = "Next action",
	SL_CONFIG_DIALOG_CHOICES = "Dialog choices",
	SL_CONFIG_STYLING_OPTIONS = "Styling options",
	SL_CONFIG_STYLING_OPTIONS_SUBTEXT = "", -- Nothing for now, maybe later
	SL_CONFIG_MISCELLANEOUS_SUBTEXT = "", -- Nothing for now, maybe later
	SL_CONFIG_MISCELLANEOUS = "Miscellaneous options",
	SL_CONFIG_DEBUG = "Debug mode",
	SL_CONFIG_DEBUG_TT = "Enable the debug frame showing development data under Storyline frame",
	SL_CONFIG_DISABLE_IN_INSTANCES = "Disable Storyline in instances",
	SL_CONFIG_DISABLE_IN_INSTANCES_TT = "Automatically disable Storyline when you are inside an instance (dungeon, battleground, raid, scenario…)",
	SL_CONFIG_DISABLE_IN_DMF = "Disable Storyline on DMF island",
	SL_CONFIG_DISABLE_IN_DMF_TT = "Automatically disable Storyline when you are in the Darkmoon Faire Island.",
	SL_CONFIG_UI_LAYOUT_ENGINE = "Use default frames position",
	SL_CONFIG_UI_LAYOUT_ENGINE_TT = [[Use the default layout so that Storyline appears on the left like the character or spell frame and gets pushed if new frames are opened.

The frame cannot be moved when using the default position. This option requires a reload of the UI.]],
	SL_RESIZE = "Resize",
	SL_RESIZE_TT = "Drag and drop to resize",
	SL_ABOUT = "About",
	SL_ABOUT_TEXT = [[This is add-on is being maintained and updated thanks to the help of Ellypse's Patreon (|cffcccccchttp://patreon.com/Ellypse|r) supporters:

%s
]],
	SL_BYPASS_NPC = "Bypass this NPC's gossip dialog",
	SL_BYPASS_NPC_TT = [[Mark this NPC so that its flavor gossip dialog should always be bypassed to directly access its functionality.

Useful for vendors, flight masters or tables to tend to talk to a lot.]],
};

Storyline_API.locale.info = {}

--@localization(locale="enUS", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["enUS"] = {
	localeText = "English",
	localeContent = localeContent
}

--@localization(locale="frFR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["frFR"] = {
	localeText = "Français",
	localeContent = localeContent
}

--@localization(locale="esES", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["esES"] = {
	localeText = "Español",
	localeContent = localeContent
}

--@localization(locale="deDE", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["deDE"] = {
	localeText = "Deutsch",
	localeContent = localeContent
}

--@localization(locale="itIT", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["itIT"] = {
	localeText = "Italiano",
	localeContent =	localeContent
}

--@localization(locale="ruRU", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["ruRU"] = {
	localeText = "Russian",
	localeContent = localeContent
}

--@localization(locale="zhTW", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["zhTW"] = {
	localeText = "Traditional Chinese",
	localeContent = localeContent
}

--@localization(locale="koKR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["koKR"] = {
	localeText = "Korean",
	localeContent = localeContent
}

--@localization(locale="ptBR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
Storyline_API.locale.info["ptBR"] = {
	localeText = "Brazilian Portuguese",
	localeContent = localeContent
}

local error, tostring = error, tostring;

local LOCALS = Storyline_API.locale.info;
local DEFAULT_LOCALE = "enUS";
Storyline_API.locale.DEFAULT_LOCALE = DEFAULT_LOCALE;
local effectiveLocal = {};
local localeFont;
local current;

-- Initialize a locale for the addon.
function Storyline_API.locale.init()
	-- Register config

	current = Storyline_Data.config.locale or GetLocale();
	if not LOCALS[current] then
		current = DEFAULT_LOCALE;
	end
	-- Pick the right font
	if current == "zhCN" then
		localeFont = "Fonts\\ARKai_T.TTF";
	elseif current == "zhTW" then
		localeFont = "Fonts\\bLEI00D.TTF";
	elseif current == "ruRU" then
		localeFont = "Fonts\\FRIZQT___CYR.TTF";
	elseif current == "koKR" then
		localeFont = "Fonts\\2002.TTF";
	else
		localeFont = "Fonts\\FRIZQT__.TTF";
	end
	effectiveLocal = LOCALS[current].localeContent;

	Storyline_Data.config.locale = current;
	Storyline_API.locale.localeFont = localeFont;
end

--	Return the localized text link to this key.
--	If the key isn't present in the current Locals table, then return the default localization.
--	If the key is totally unknown from TRP3, then an error will be lifted.
local function getText(key)
	if effectiveLocal[key] or LOCALS[DEFAULT_LOCALE].localeContent[key] then
		return effectiveLocal[key] or LOCALS[DEFAULT_LOCALE].localeContent[key];
	end
	error("Unknown localization key: ".. tostring(key));
end
Storyline_API.locale.getText = getText;

function Storyline_API.locale.getLocales()
	return Storyline_API.locale.info;
end
