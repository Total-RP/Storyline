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
    "Ellyb",
    "LibStub",
    "StorylineBackgroundTexture",

};

read_globals = {
    -- Global functions
    C_CampaignInfo = {
        fields = {

        },
    },
    C_GossipInfo = {
        fields = {

        },
    },
    C_Map = {
        fields = {

        },
    },
    C_QuestLog = {
        fields = {

        },
    },
    C_Texture = {
        fields = {

        },
    },
    C_Timer = {
        fields = {

        },
    },
    QuestUtil = {
        fields = {

        },
    },

    "CreateFrame",
    "GetActiveQuestID",
    "GetActiveTitle",
    "GetAvailableQuestInfo",
    "GetAvailableTitle",
    "GetNumActiveQuests",
    "GetNumAvailableQuests",
    "GetQuestID",
    "GetTime",
    "SelectActiveQuest",
    "SelectAvailableQuest",
    "tContains",
    "tinsert",
    "UnitClass",
    "UnitFactionGroup",

    -- Global variables
    "Enum",
    "GOSSIP_QUEST_OPTION_PREPEND",
    "QUEST_KING_ANDUIN_WRYNN",
    "QUEST_KING_VARIAN_WRYNN",
    "QUEST_WARCHIEF_SYLVANAS_WINDRUNNER",
    "QUEST_WARCHIEF_VOLJIN",
};

std = "lua51";
