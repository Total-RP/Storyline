local Class = require "Libraries.Self"
local Rx = require "Libraries.WoWRx"
local U = require "Utils"
local WoWScheduler = require "Libraries.WoWScheduler"

---@class LabeledSlider
local LabeledSlider = Class("LabeledSlider")

---@param labelText string
---@param inputSubject Subject
function LabeledSlider:new(labelText, inputSubject, min, max, step)
    self.container = CreateFrame("FRAME")
    self.container:SetSize(150, 42)

    self.label = self.container:CreateFontString(nil, "ARTWORK", "GameFontNormalLeftYellow")
    self.label:SetPoint("TOPLEFT")
    self.label:SetHeight(12)

    ---@type Slider
    self.slider = CreateFrame("Slider", nil, self.container, "HorizontalSliderTemplate")
    self.slider:SetPoint("TOPLEFT", self.label, "BOTTOMLEFT", 0, -5)
    self.slider:SetSize(150, 20)
    self.slider:SetMinMaxValues(min, max)
    self.slider:SetValueStep(step)
    self.slider:SetObeyStepOnDrag(true)

    inputSubject:subscribe(function(value)
        self.slider:SetValue(value)
    end)

    inputSubject
        :map(function(value)
            return labelText .. ": " .. tostring(value)
        end)
        :map(U.First(self.label))
        :subscribe(self.label.SetText)

    Rx.Script(self.slider, "OnValueChanged")
      :map(U.TakeNth(2))
        :map(U.Round(2))
        :distinctUntilChanged()
        :bindTo(inputSubject)

    Rx.Script(self.slider, "OnMouseWheel")
        :map(function(_, orientation)
            local increment = step
            if IsShiftKeyDown() then
                increment = increment * 10
            end
            if orientation < 0 then
                return math.max(self.slider:GetValue() - increment, min)
            else
                return math.min(self.slider:GetValue() + increment, max)
            end
        end)
        :bindTo(inputSubject)
end

return LabeledSlider