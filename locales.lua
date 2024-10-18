----------------------------------------------------------------------------------
--  Storyline
--	---------------------------------------------------------------------------
--	Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--	Copyright 2015 Morgane "Ellypse" Parize (ellypse@totalrp3.info)
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

STORYLINE_BACKDROP_MIXED_DIALOG_TOOLTIP_400_24_5555 = {
	bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile     = true,
	tileEdge = true,
	tileSize = 400,
	edgeSize = 24,
	insets   = { left = 5, right = 5, top = 5, bottom = 5 },
};

Storyline_API.locale.info = {

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_EN
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["enUS"] = {
		localeText = "English",
		localeContent = {
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

Join us on discord.totalrp.com to get news about the add-on.
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
			SL_CONFIG_HIDE_COUNT = "Hide dialog count",
			SL_CONFIG_HIDE_COUNT_TT = "Hides the x/x dialog count at the bottom-right of the dialog frame.",
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
			SL_USE_DYNAMIC_BACKGROUNDS = "Use animated backgrounds based on the current zone when possible",

			TUTORIAL_DIALOG_SCROLL = "When there are many dialog choices available, the pulsating glowing bottom border indicates that you can scroll on the list to navigate to more dialog choices.",
			TUTORIAL_REWARD_CHOICES = [[This quest offers you to choose your reward.
Click on the reward you want to accept.

You can also %s to preview the reward's appearance in the Dressing Room or %s to create a chat link for the item.]]
		}
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_FR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["frFR"] = {
		localeText = "Français",
		--@localization(locale="frFR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {
			["SL_ACCEPTANCE"] = "J'accepte.",
			["SL_CHECK_OBJ"] = "Vérifier objectifs",
			["SL_CONFIG"] = "Configuration",
			["SL_CONFIG_AUTOEQUIP"] = "Équipement automatique (expérimental)",
			["SL_CONFIG_AUTOEQUIP_TT"] = "Équipe automatiquement les récompense si elles ont un meilleur niveau d'équipement.",
			["SL_CONFIG_BIG_SAMPLE_TEXT"] = [=[« C'est un trou de verdure où chante une rivière,
Accrochant follement aux herbes des haillons
D'argent ; où le soleil, de la montagne fière,
Luit : c'est un petit val qui mousse de rayons. »
— Arthur Rimbaud]=],
			["SL_CONFIG_DEBUG"] = "Mode débug",
			["SL_CONFIG_DEBUG_TT"] = "Activer le mode débug pour afficher la fenêtre d'informations de développement sous la fenêtre principale de Storyline.",
			["SL_CONFIG_DIALOG_CHOICES"] = "Options de dialogue",
			["SL_CONFIG_DIALOG_TEXT"] = "Texte de dialogues",
			["SL_CONFIG_DISABLE_IN_INSTANCES"] = "Désactiver Storyline en instance",
			["SL_CONFIG_DISABLE_IN_INSTANCES_TT"] = "Désactiver Storyline automatiquement dans les instances (donjons, champs de bataille, raid, scenario…)",
			["SL_CONFIG_FORCEGOSSIP"] = "Forcer les textes des PNJs",
			["SL_CONFIG_FORCEGOSSIP_TT"] = "Forcer l'affichage des textes des PNJs normalement masqués, comme les marchands ou les maîtres de vol.",
			["SL_CONFIG_HIDEORIGINALFRAMES"] = "Cacher les fenêtres originales",
			["SL_CONFIG_HIDEORIGINALFRAMES_TT"] = "Cacher les fenêtres originales du jeu (quêtes et dialogues de PNJs) pour qu'il n'y ait que Storyline de visible à l'écran.",
			["SL_CONFIG_LANGUAGE"] = "Langue",
			["SL_CONFIG_LOCKFRAME"] = "Verrouiller la fenêtre",
			["SL_CONFIG_LOCKFRAME_TT"] = "Verrouiller la fenêtre de Storyline pour empêcher un déplacement par erreur.",
			["SL_CONFIG_MISCELLANEOUS"] = "Options diverses",
			["SL_CONFIG_NEXT_ACTION"] = "Action suivante",
			["SL_CONFIG_NPC_NAME"] = "Nom du PNJ",
			["SL_CONFIG_QUEST_TITLE"] = "Titre de la quête",
			["SL_CONFIG_SAMPLE_TEXT"] = "Voix ambiguë d’un cœur qui au zéphyr préfère les jattes de kiwi.",
			["SL_CONFIG_STYLING_OPTIONS"] = "Options d’affichage",
			["SL_CONFIG_TEXTSPEED"] = "%.1fx",
			["SL_CONFIG_TEXTSPEED_HIGH"] = "Rapide",
			["SL_CONFIG_TEXTSPEED_INSTANT"] = "Pas de défilement",
			["SL_CONFIG_TEXTSPEED_TITLE"] = "Vitesse d'animation du texte",
			["SL_CONFIG_UI_LAYOUT_ENGINE"] = "Position par défaut",
			["SL_CONFIG_UI_LAYOUT_ENGINE_TT"] = [=[Utiliser les positions de fenêtres par défaut, alignées sur la gauche, comme pour la fenêtre de personnage ou le grimoire.

La fenêtre ne peut plus être déplacée dans ce mode. Cette option requière un rechargement de l'interface.]=],
			["SL_CONFIG_USE_KEYBOARD"] = "Utiliser les raccourcis clavier",
			["SL_CONFIG_USE_KEYBOARD_TT"] = "Utiliser les raccourcis clavier pour naviguer dans les dialogues (barre espace pour avancer, touche retour pour revenir en arrière, touches 1 à 0 pour sélectionner une option de dialogue).",
			["SL_CONFIG_WELCOME"] = [=[Merci d'utiliser Storyline!

Rejoignez-nous sur discord.totalrp.com pour recevoir des informations sur les mises à jour de l'add-on.]=],
			["SL_CONTINUE"] = "Terminer la quête",
			["SL_DECLINE"] = "Je refuse.",
			["SL_GET_REWARD"] = "Prenez votre récompense",
			["SL_NEXT"] = "Continuer",
			["SL_NOT_YET"] = "Revenez quand cela sera fait",
			["SL_RESET"] = "Début",
			["SL_RESET_TT"] = "Revenir au début du dialogue",
			["SL_RESIZE"] = "Redimensionner",
			["SL_RESIZE_TT"] = "Cliquer-glisser pour redimensionner",
			["SL_REWARD_MORE"] = "Vous recevrez aussi",
			["SL_REWARD_MORE_SUB"] = [=[
Argent: |cffffffff%s|r
Expérience: |cffffffff%s xp|r

|cffffff00Clic:|r Prenez votre récompense !]=],
			["SL_SELECT_AVAILABLE_QUEST"] = "Sélectionnez une quête",
			["SL_SELECT_DIALOG_OPTION"] = "Sélectionnez une option",
			["SL_SELECT_REWARD"] = "Choisissez votre récompense",
			["SL_STORYLINE"] = "Storyline",
		}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_SP
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["esES"] = {
		localeText = "Español",
		--@localization(locale="esES", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_DE
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["deDE"] = {
		localeText = "Deutsch",
		--@localization(locale="deDE", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@

	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_IT
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["itIT"] = {
		localeText = "Italiano",
		--@localization(locale="itIT", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent =	{}
		--@end-do-not-package@

	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_RU
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["ruRU"] = {
		localeText = "Russian",
		--@localization(locale="ruRU", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_ZHCN
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["zhCN"] = {
		localeText = "Simplified Chinese",
		--@localization(locale="zhCN", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_ZHTW
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["zhTW"] = {
		localeText = "Traditional Chinese",
		--@localization(locale="zhTW", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_koKR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


	["koKR"] = {
		localeText = "Korean",
		--@localization(locale="koKR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@

	},


	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- LOCALE_ptBR
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	["ptBR"] = {
		localeText = "Brazilian Portuguese",
		--@localization(locale="ptBR", format="lua_table", table-name="localeContent", handle-unlocalized="ignore")@
		--@do-not-package@
		localeContent = {}
		--@end-do-not-package@

	},
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
