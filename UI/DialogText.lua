---@type Storyline
local _, Storyline = ...

local Rx = Storyline.Rx

---@type Frame
local Storyline_NPCFrameChat = Storyline_NPCFrameChat

--region NPC name

---@type FontString
local NPCName = Storyline_NPCFrameChat:CreateFontString(nil, nil, "GameFontNormalLarge")
NPCName.rx = Rx.bindingsFor(NPCName)
NPCName:SetPoint("TOP", Storyline_NPCFrameChat, "TOP", 0, -10)
NPCName:SetPoint("RIGHT", Storyline_NPCFrameChat, "RIGHT", -20, 0)
NPCName:SetTextColor(1, 0.75, 0)

-- Subscribe to the NPC name value
Storyline.State.npcName:bindTo(NPCName.rx.text)

--endregion

--region Chat bubble tail

local ChatBubbleTail = Storyline_NPCFrameChat:CreateTexture(nil, "OVERLAY")
ChatBubbleTail.rx = Rx.bindingsFor(ChatBubbleTail)
ChatBubbleTail:SetTexture([[Interface\Tooltips\CHATBUBBLE-TAIL]])
ChatBubbleTail:SetTexCoord(1, 0, 1, 0)
ChatBubbleTail:SetSize(19, 19)
ChatBubbleTail:SetPoint("BOTTOMRIGHT", Storyline_NPCFrameChat, "TOPRIGHT", -120, -2)

-- Subscribe to NPC name, only show chat bubble if we have an NPC talking
Storyline.State.npcName
    :map(Rx.util.toVisibility)
    :bindTo(ChatBubbleTail.rx.visibility)

--endregion

--region Dialog text

local DialogText = Storyline_NPCFrameChat:CreateFontString(nil, nil, "GameFontNormalLarge")
DialogText.rx = Rx.bindingsFor(DialogText)
DialogText:SetJustifyV("TOP")
DialogText:SetJustifyH("LEFT")
DialogText:SetPoint("TOP", NPCName, "TOP", 0, -15)
DialogText:SetPoint("LEFT", Storyline_NPCFrameChat, "LEFT", 30, 0)
DialogText:SetPoint("RIGHT", Storyline_NPCFrameChat, "RIGHT", -30, 0)

-- Attach TOP anchor to container top or NPC name text if we have an NPC name
Storyline.State.npcName:subscribe(function(npcName)
    if npcName ~= nil then
        DialogText:SetPoint("TOP", NPCName, "BOTTOM", 0, -10)
    else
        DialogText:SetPoint("TOP", Storyline_NPCFrameChat, "TOP", 0, -20)
    end
end)

-- Subscribe to the dialog step text
Storyline.State.dialogStepText:bindTo(DialogText.rx.text)

--endregion

--region Next action

local DialogAction = Storyline_NPCFrameChat:CreateFontString(nil, nil, "GameFontNormalSmall")
DialogAction.rx = Rx.bindingsFor(DialogAction)
DialogAction:SetPoint("TOP", DialogText, "BOTTOM", 0, -10)
DialogAction:SetText("Continue")

-- Subscribe to the next action
Storyline.State.nextAction:bindTo(DialogAction.rx.text)

--endregion

-- Update the frame height when the dialog text is set
DialogText.rx.hook("SetText")
    :subscribe(function()
    Storyline_NPCFrameChat:SetHeight(
        NPCName:GetStringHeight() +
            DialogText:GetStringHeight() +
            DialogAction:GetStringHeight() +
            55
    )
end)