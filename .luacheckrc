max_line_length = false

exclude_files = {
	"lib",
};

ignore = {
	-- Ignore global writes/accesses/mutations on anything prefixed with
	-- "Storyline_". This is the standard prefix for all of our global frame names
	-- and mixins.
	"11./^Storyline_",

	-- Ignore unused self. This would popup for Mixins and Objects
	"212/self",
};

globals = {
    -- Addon globals
    "Ellyb",
    "LibStub",
    "STORYLINE_BACKDROP_MIXED_DIALOG_TOOLTIP_400_24_5555",
    "StorylineBackgroundTexture",

    -- WoW globals
    "QuestFrame",
    "UIPanelWindows",
};

read_globals = {
    -- Global functions
    C_CampaignInfo = {
        fields = {
            "GetCampaignID",
            "IsCampaignQuest",
        },
    },
    C_GossipInfo = {
        fields = {
            "CloseGossip",
            "GetActiveQuests",
            "GetAvailableQuests",
            "GetOptions",
            "GetText",
            "SelectActiveQuest",
            "SelectAvailableQuest",
            "SelectOption",
        },
    },
    C_Map = {
        fields = {
            "GetBestMapForUnit",
            "GetFallbackWorldMapID",
            "GetMapInfo",
        },
    },
    C_QuestLog = {
        fields = {
            "GetQuestDetailsTheme",
            "IsQuestCalling",
        },
    },
    C_Texture = {
        fields = {
            "GetAtlasInfo",
        },
    },
    C_Timer = {
        fields = {
            "After",
        },
    },
    QuestUtil = {
        fields = {
            "ApplyQuestIconActiveToTexture",
            "ApplyQuestIconOfferToTexture",
            "ShouldQuestIconsUseCampaignAppearance",
        },
    },

    "AcceptQuest",
    "AcknowledgeAutoAcceptQuest",
    "CloseQuest",
    "CompleteQuest",
    "CreateFrame",
    "CustomGossipFrameManager",
    "DeclineQuest",
    "EquipItemByName",
    "format",
    "GetActiveQuestID",
    "GetActiveTitle",
    "GetAvailableQuestInfo",
    "GetAvailableTitle",
    "GetContainerItemLink",
    "GetContainerNumSlots",
    "GetGreetingText",
    "GetInventoryItemLink",
    "GetInventorySlotInfo",
    "GetItemInfo",
    "GetLocale",
    "GetNumActiveQuests",
    "GetNumAvailableQuests",
    "GetNumQuestChoices",
    "GetNumQuestItems",
    "GetNumQuestLogEntries",
    "GetNumQuestRewards",
    "GetObjectiveText",
    "GetProgressText",
    "GetQuestID",
    "GetQuestItemInfo",
    "GetQuestItemLink",
    "GetQuestLogQuestText",
    "GetQuestLogTitle",
    "GetQuestPortraitGiver",
    "GetQuestPortraitTurnIn",
    "GetQuestReward",
    "GetQuestText",
    "GetSuggestedGroupSize",
    "GetRewardText",
    "GetTime",
    "GetTitleText",
    "HideUIPanel",
    "hooksecurefunc",
    "InCombatLockdown",
    "IsInInstance",
    "IsQuestCompletable",
    "PlayAutoAcceptQuestSound",
    "QuestFrame_HideQuestPortrait",
    "QuestFrame_ShowQuestPortrait",
    "QuestGetAutoAccept",
    "QuestFlagsPVP",
    "QuestIsFromAreaTrigger",
    "QuestModelScene",
    "SelectActiveQuest",
    "SelectAvailableQuest",
    "ShowUIPanel",
    "StaticPopup_Show",
    "tContains",
    "tinsert",
    "UnitClass",
    "UnitExists",
    "UnitFactionGroup",
    "UnitIsDead",
    "UnitIsUnit",
    "UnitPosition",
    "wipe",

    -- Global variables
    "ChatTypeInfo",
    "Enum",
    "GOODBYE",
    "GOSSIP_QUEST_OPTION_PREPEND",
    "NUM_BAG_SLOTS",
    "QUEST_KING_ANDUIN_WRYNN",
    "QUEST_KING_VARIAN_WRYNN",
    "QUEST_OBJECTIVES",
    "QUEST_SUGGESTED_GROUP_NUM",
    "QUEST_WARCHIEF_SYLVANAS_WINDRUNNER",
    "QUEST_WARCHIEF_VOLJIN",
    "QuestInfoRewardsFrame",
    "REWARDS",
    "TURN_IN_ITEMS",
    "UIParent",
};

std = "lua51";
