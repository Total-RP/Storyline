max_line_length = false

exclude_files = {
	"lib",
};

ignore = {
	-- Ignore global writes/accesses/mutations on anything prefixed with
	-- "Storyline". This is the standard prefix for all of our global frame names
	-- and mixins.
	"11./^Storyline",

	-- Ignore unused self. This would popup for Mixins and Objects
	"212/self",
};

globals = {
    -- Addon globals
    "Ellyb",
    "LibStub",
    "STORYLINE_BACKDROP_MIXED_DIALOG_TOOLTIP_400_24_5555",
};

std = "lua51+wow";

stds.wow = {
    -- WoW globals
    globals = {
        C_GossipInfo = {
            fields = {
                "ForceGossip",
            },
        },

        "QuestFrame",
        "UIPanelWindows",
    };

    read_globals = {
        -- Global functions
        AuraUtil = {
            fields = {
                "ForEachAura",
            },
        },
        C_CampaignInfo = {
            fields = {
                "GetCampaignID",
                "IsCampaignQuest",
            },
        },
        C_Garrison = {
            fields = {
                "GetFollowerInfo",
                "IsFollowerCollected",
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
        C_MajorFactions = {
            fields = {
                "GetMajorFactionData",
            },
        },
        C_Map = {
            fields = {
                "GetBestMapForUnit",
                "GetFallbackWorldMapID",
                "GetMapInfo",
            },
        },
        C_PvP = {
            fields = {
                "GetWarModeRewardBonus",
                "IsWarModeDesired",
            },
        },
        C_QuestInfoSystem = {
            fields = {
                "GetQuestRewardSpells",
                "GetQuestRewardSpellInfo",
            },
        },
        C_QuestLog = {
            fields = {
                "GetQuestDetailsTheme",
                "IsQuestCalling",
                "IsQuestFlaggedCompletedOnAccount",
                "QuestHasQuestSessionBonus",
                "QuestHasWarModeBonus",
            },
        },
        C_QuestOffer = {
            fields = {
                "GetQuestOfferMajorFactionReputationRewards",
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
                "NewTimer"
            },
        },
        CurrencyContainerUtil = {
            fields = {
                "GetCurrencyContainerInfo",
            },
        },
        GameTooltip = {
            fields = {
                "AddLine",
                "Hide",
                "SetItemByID",
                "SetOwner",
                "SetQuestCurrency",
                "SetQuestItem",
                "Show",
            },
        },
        GarrisonFollowerTooltip = {
            fields = {
                "Hide",
            },
        },
        Item = {
            fields = {
                "CreateFromItemID",
            },
        },
        QuestUtil = {
            fields = {
                "ApplyQuestIconActiveToTexture",
                "ApplyQuestIconOfferToTexture",
                "ShouldQuestIconsUseCampaignAppearance",
            },
        },
        Settings = {
            fields = {
                "OpenToCategory",
                "RegisterAddOnCategory",
                "RegisterCanvasLayoutCategory",
                "RegisterCanvasLayoutSubcategory",
            },
        },

        "AcceptQuest",
        "AcknowledgeAutoAcceptQuest",
        "BreakUpLargeNumbers",
        "CloseQuest",
        "CompleteQuest",
        "CreateColor",
        "CreateFrame",
        "CursorOnUpdate",
        "CustomGossipFrameManager",
        "DeclineQuest",
        "EquipItemByName",
        "format",
        "GameTooltip_ShowCompareItem",
        "GetActiveQuestID",
        "GetActiveTitle",
        "GetAvailableQuestInfo",
        "GetAvailableTitle",
        "GetColorForCurrencyReward",
        "GetContainerItemLink",
        "GetContainerNumSlots",
        "GetGreetingText",
        "GetInventoryItemLink",
        "GetInventorySlotInfo",
        "GetItemInfo",
        "GetLocale",
        "GetMoney",
        "GetNumActiveQuests",
        "GetNumAvailableQuests",
        "GetNumQuestChoices",
        "GetNumQuestCurrencies",
        "GetNumQuestItems",
        "GetNumQuestLogEntries",
        "GetNumQuestRewards",
        "GetNumRewardCurrencies",
        "GetNumRewardSpells",
        "GetObjectiveText",
        "GetProgressText",
        "GetQuestCurrencyID",
        "GetQuestCurrencyInfo",
        "GetQuestID",
        "GetQuestItemInfo",
        "GetQuestItemInfoLootType",
        "GetQuestItemLink",
        "GetQuestLogQuestText",
        "GetQuestLogTitle",
        "GetQuestMoneyToGet",
        "GetQuestPortraitGiver",
        "GetQuestPortraitTurnIn",
        "GetQuestReward",
        "GetQuestText",
        "GetSuggestedGroupSize",
        "GetRewardMoney",
        "GetRewardSkillPoints",
        "GetRewardSpell",
        "GetRewardText",
        "GetRewardTitle",
        "GetRewardXP",
        "GetTime",
        "GetTitleText",
        "HandleModifiedItemClick",
        "HideUIPanel",
        "hooksecurefunc",
        "IsAltKeyDown",
        "IsCharacterNewlyBoosted",
        "InCombatLockdown",
        "IsControlKeyDown",
        "IsInInstance",
        "IsModifiedClick",
        "IsQuestCompletable",
        "IsShiftKeyDown",
        "IsSpellKnownOrOverridesKnown",
        "PlayAutoAcceptQuestSound",
        "QuestFrame_HideQuestPortrait",
        "QuestFrame_ShowQuestPortrait",
        "QuestGetAutoAccept",
        "QuestFlagsPVP",
        "QuestIsFromAreaTrigger",
        "QuestModelScene",
        "ReloadUI",
        "ReputationEntryMixin",
        "ResetCursor",
        "SelectActiveQuest",
        "SelectAvailableQuest",
        "SetItemButtonQuality",
        "ShowUIPanel",
        "StaticPopup_Show",
        "strsplit",
        "strtrim",
        "tContains",
        "tinsert",
        "UnitClass",
        "UnitExists",
        "UnitFactionGroup",
        "UnitGUID",
        "UnitIsDead",
        "UnitIsUnit",
        "UnitName",
        "UnitPosition",
        "wipe",

        -- Global variables
        "ACCOUNT_COMPLETED_QUEST_NOTICE",
        "BONUS_SKILLPOINTS",
        "BONUS_SKILLPOINTS_TOOLTIP",
        "ChatTypeInfo",
        "COPPER_PER_GOLD",
        "COPPER_PER_SILVER",
        "Enum",
        "ERR_QUEST_REWARD_EXP_I",
        "ERR_QUEST_REWARD_MONEY_S",
        "GOODBYE",
        "GOSSIP_QUEST_OPTION_PREPEND",
        "GossipFrame",
        "LE_QUEST_FREQUENCY_DAILY",
        "LE_QUEST_FREQUENCY_WEEKLY",
        "NUM_BAG_SLOTS",
        "PLUS_PERCENT_FORMAT",
        "QUEST_KING_ANDUIN_WRYNN",
        "QUEST_KING_VARIAN_WRYNN",
        "QUEST_OBJECTIVES",
        "QUEST_REPUTATION_REWARD_TITLE",
        "QUEST_REPUTATION_REWARD_TOOLTIP",
        "QUEST_SESSION_BONUS_LOOT_REWARD_FRAME_TITLE",
        "QUEST_SUGGESTED_GROUP_NUM",
        "QUEST_WARCHIEF_SYLVANAS_WINDRUNNER",
        "QUEST_WARCHIEF_VOLJIN",
        "QuestInfoRewardsFrame",
        "REQUIRED_MONEY",
        "RETRIEVING_DATA",
        "REWARD_ABILITY",
        "REWARD_AURA",
        "REWARD_CHOICES",
        "REWARD_CHOOSE",
        "REWARD_FOLLOWER",
        "REWARD_ITEMS_ONLY",
        "REWARD_UNLOCK",
        "REWARDS",
        "TURN_IN_ITEMS",
        "UIParent",
        "UNKNOWN",
        "XP",
    },
};
