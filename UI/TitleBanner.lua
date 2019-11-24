---@type Storyline
local _, Storyline = ...

local Rx = Storyline.Rx
local Ellyb = Ellyb(...)

--region Banner
local TitleBanner = CreateFrame("FRAME", nil, Storyline_NPCFrame, nil)
TitleBanner.rx = Rx.bindingsFor(TitleBanner)
TitleBanner:SetSize(384, 96)
TitleBanner:SetPoint("TOP", Storyline_NPCFrame, "TOP", 0, 0)
TitleBanner:SetFrameStrata("HIGH")

-- Show the title banner when we do have a quest title
Storyline.State.questTitle
    :map(Rx.util.toVisibility)
    :bindTo(TitleBanner.rx.visibility)

local BannerTexture = TitleBanner:CreateTexture()
BannerTexture:SetAtlas("GarrMission_RewardsBanner")
BannerTexture:SetAllPoints(TitleBanner)
--endregion

--region Banner text
local BannerText = TitleBanner:CreateFontString()
BannerText.rx = Rx.bindingsFor(BannerText)

-- Dynamic font size
Mixin(BannerText, ShrinkUntilTruncateFontStringMixin)
BannerText:SetFontObjectsToTry("GameFontNormalHuge", "GameFontNormalMed2", "GameFontNormalMed3", "GameFontNormalLarge");

-- Position
BannerText:SetPoint("RIGHT", -45, 0)
BannerText:SetPoint("TOP", 0, -22)
BannerText:SetPoint("BOTTOM", 0, 35)
BannerText:SetJustifyV("MIDDLE")
BannerText:SetJustifyH("CENTER")

-- Text color
BannerText:SetTextColor(Ellyb.ColorManager.WHITE:GetRGB())

-- Subscribe to quest title
Storyline.State.questTitle
    :bindTo(BannerText.rx.text)

-- Dynamic right anchor, to make room for the faction emblem when it's a war campaign quest
Storyline.State.isWarCampaign
    :subscribe(function(isWarCampaign)
        if isWarCampaign then
            BannerText:SetPoint("LEFT", 80, 0)
        else
            BannerText:SetPoint("LEFT", 45, 0)
        end
    end)

--endregion

--region Faction emblem
local FactionEmblem = TitleBanner:CreateTexture(nil, "OVERLAY")
FactionEmblem.rx = Rx.bindingsFor(FactionEmblem)
FactionEmblem:SetPoint("RIGHT", BannerText, "LEFT", 0, -2)
FactionEmblem:SetSize(30, 33)

-- Bind visibility of the FactionEmblem
Storyline.State.isWarCampaign
    :map(Rx.util.toVisibility)
    :bindTo(FactionEmblem.rx.visibility)


-- Subscribe to the player faction to set the atlas on the FactionEmblem
Rx.Observable.createFromGameEvent("UNIT_FACTION")
    :filter(function(unit) return unit == "player" end)
    :map(function()
        if UnitFactionGroup("player") == "Alliance" then
            return "bfa-landingbutton-alliance-up"
        else
            return "bfa-landingbutton-horde-up"
        end
    end)
    :bindTo(FactionEmblem.rx.atlas)

--endregion

