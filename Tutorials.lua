----------------------------------------------------------------------------------
--- Storyline tutorials
--- ---------------------------------------------------------------------------
--- Copyright 2019 Renaud "Ellypse" Parize (ellypse@totalrp3.info)
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

local CustomTutorials = LibStub('CustomTutorials-2.1');

Storyline_API.Tutorials = {};

function Storyline_API.Tutorials.register(id, data)
    data.title = "Storyline";
    data.savedvariable = Storyline_Data;
    data.key = id .. 'Tutorial';

    CustomTutorials.RegisterTutorials("Storyline" .. id, data);
end

function Storyline_API.Tutorials.trigger(id, step, ...)
    CustomTutorials.TriggerTutorial("Storyline" .. id, step or 1, ...);
end

--- Tutorials

Storyline_API.Tutorials.register("RewardChoice", {
    {
        text = "Select your reward by clicking on it. You can also Ctrl+Click on a reward to see what it looks like in the Dressing Room or Shift+Click a reward to create a chat link for it.",
        point = 'LEFT',
        relPoint = 'RIGHT',
        anchor = Storyline_NPCFrameObjectivesContent,
    }
});