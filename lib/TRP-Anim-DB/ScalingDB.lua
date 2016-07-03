----------------------------------------------------------------------------------
-- Total RP 3: Dialogues animations
-- ---------------------------------------------------------------------------
-- Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----------------------------------------------------------------------------------

local MAJOR, MINOR = "TRP-Dialog-Scaling-DB", 1

local Lib = LibStub:NewLibrary(MAJOR, MINOR)

if not Lib then return end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Model scaling
-- Give the scaling between two models
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local DEFAULT_SCALE = {
	me = {
		scale = 1.45,
		feet = 0.4,
		offset = 0.215,
		facing = 0.75
	}
};
DEFAULT_SCALE.you = DEFAULT_SCALE.me;

local SCALE_MAPPING = {

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Human female
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["1000764~1011653"] = {
		["me"] = {
			["scale"] = 1.56,
		},
	},
	["1000764~940356"] = {
		["you"] = {
			["scale"] = 2.2,
			["offset"] = 0.195,
			["feet"] = 0.42,
		},
	},
	["1000764~1022598"] = {
		["you"] = {
			["scale"] = 1.27,
			["feet"] = 0.41,
		},
		["me"] = {
			["scale"] = 1.63,
		},
	},
	["1000764~1005887"] = {
		["me"] = {
			["scale"] = 1.81,
		},
		["you"] = {
			["scale"] = 1.31,
			["offset"] = 0.205,
			["feet"] = 0.43,
		},
	},
	["1000764~535052"] = {
		["me"] = {
			["scale"] = 1.58,
		},
		["you"] = {
			["offset"] = 0.205,
			["scale"] = 1.13,
			["feet"] = 0.43,
		},
	},
	["1000764~589715"] = {
		["me"] = {
			["scale"] = 1.58,
		},
		["you"] = {
			["scale"] = 1.38,
		},
	},
	["1000764~921844"] = {
		["me"] = {
			["scale"] = 1.61,
		},
		["you"] = {
			["offset"] = 0.215,
			["scale"] = 1.32,
			["feet"] = 0.42,
		},
	},
	["1000764~974343"] = {
		["me"] = {
			["scale"] = 1.61,
		},
		["you"] = {
			["scale"] = 1.27,
			["offset"] = 0.215,
			["feet"] = 0.41,
		},
	},
	["1000764~900914"] = {
		["you"] = {
			["scale"] = 2,
			["offset"] = 0.185,
			["feet"] = 0.41,
		},
	},
	["1000764~950080"] = {
		["you"] = {
			["scale"] = 1.61,
			["offset"] = 0.245,
		},
	},
	["1000764~878772"] = {
		["you"] = {
			["scale"] = 1.34,
			["offset"] = 0.175,
			["feet"] = 0.42,
		},
	},
	["1000764~307453"] = {
		["you"] = {
			["offset"] = 0.215,
			["scale"] = 1.05,
			["feet"] = 0.42,
		},
		["me"] = {
			["scale"] = 1.66,
		},
	},
	["1000764~307454"] = {
		["me"] = {
			["scale"] = 1.74,
		},
		["you"] = {
			["scale"] = 1.27,
		},
	},
	["1000764~119376"] = {
		["you"] = {
			["offset"] = 0.195,
			["scale"] = 1.91,
			["feet"] = 0.41,
		},
		["me"] = {
			["scale"] = 1.4,
		},
	},

	-- VS NPC
	["1000764~creature\\velen2\\velen2.m2"] = {
		["me"] = {
			["scale"] = 1.97,
		},
		["you"] = {
			["scale"] = 1.06,
		},
	},
	["1000764~creature\\dragondeepholm\\dragondeepholmmount.m2"] = {
		["you"] = {
			["offset"] = 0.325,
			["scale"] = 0.75,
			["feet"] = 0.4,
		},
	},
	["1000764~creature\\humanmalekid\\humanmalekid.m2"] = {
		["you"] = {
			["scale"] = 1.02,
			["offset"] = 0.115,
			["feet"] = 0.45,
		},
	},
	["1000764~creature\\kingvarianwrynn\\kingvarianwrynn.m2"] = {
		["me"] = {
			["scale"] = 1.52,
		},
		["you"] = {
			["scale"] = 1.29,
		},
	},
	["1000764~character\\broken\\male\\brokenmale.m2"] = {
		["you"] = {
			["scale"] = 1.3,
		},
	},
	["1000764~creature\\humanfemalekid\\humanfemalekid.m2"] = {
		["you"] = {
			["offset"] = 0.185,
			["feet"] = 0.43,
			["scale"] = 2.25,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Human male
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["1011653~940356"] = {
		["you"] = {
			["height"] = 1.99,
		},
		["me"] = {
			["height"] = 1.29,
		},
	},
	["1011653~878772"] = {
		["me"] = {
			["height"] = 1.29,
		},
		["you"] = {
			["height"] = 1.55,
		},
	},
	["1011653~589715"] = {
		["you"] = {
			["height"] = 1.350,
		},
		["me"] = {
			["height"] = 1.399,
		},
	},
	["1011653~921844"] = {
		["you"] = {
			["height"] = 1.299,
		},
		["me"] = {
			["height"] = 1.389,
		},
	},
	["1011653~119369"] = {
		["me"] = {
			["height"] = 1.279,
		},
		["you"] = {
			["height"] = 1.959,
		},
	},
	["1011653~950080"] = {
		["you"] = {
			["height"] = 1.599,
		},
		["me"] = {
			["height"] = 1.279,
		},
	},
	["1011653~917116"] = {
		["me"] = {
			["height"] = 1.289,
		},
		["you"] = {
			["height"] = 1.429,
		},
	},
	["1011653~1022598"] = {
		["me"] = {
			["scale"] = 1.65,
		},
	},
	["1011653~535052"] = {
		["you"] = {
			["scale"] = 1.15,
			["offset"] = 0.205,
		},
	},
	["1011653~307454"] = {
		["you"] = {
			["scale"] = 1.24,
		},
		["me"] = {
			["scale"] = 1.69,
		},
	},
	["1011653~974343"] = {
		["me"] = {
			["scale"] = 1.59,
		},
		["you"] = {
			["scale"] = 1.28,
		},
	},

	-- VS NPC
	["1011653~creature\\siberiantiger\\siberiantiger.m2"] = {
		["you"] = {
			["offset"] = 0.105,
			["scale"] = 1.35,
		},
	},
	["1011653~creature\\humlblacksmith\\humlblacksmith.m2"] = {
		["you"] = {
			["scale"] = 1.11,
			["offset"] = 0.135,
			["feet"] = 0.42,
		},
	},
	["1011653~creature\\humanmalekid\\humanmalekid.m2"] = {
		["you"] = {
			["offset"] = 0.135,
			["scale"] = 0.95,
		},
	},
	["1011653~creature\\druidcat\\druidcat.m2"] = {
		["you"] = {
			["scale"] = 2.45,
			["offset"] = 0.125,
		},
	},
	["1011653~creature\\anduin\\anduin.m2"] = {
		["you"] = {
			["scale"] = 1.61,
		},
	},
	["1011653~creature\\draeneimalekid\\draeneimalekid.m2"] = {
		["you"] = {
			["scale"] = 2.95,
		},
	},
	["1011653~creature\\humanfemalekid\\humanfemalekid.m2"] = {
		["you"] = {
			["scale"] = 2.45,
		},
	},
	["1011653~creature\\draeneifemalekid\\draeneifemalekid.m2"] = {
		["you"] = {
			["scale"] = 2.45,
		},
	},
	["1011653~creature\\velen2\\velen2.m2"] = {
		["you"] = {
			["height"] = 0.969,
		},
		["me"] = {
			["height"] = 1.809,
		},
	},
	["1011653~creature\\impoutland\\impoutland.m2"] = {
		["you"] = {
			["height"] = 2,
		},
		["me"] = {
			["height"] = 1.299,
		},
	},
	["1011653~creature\\arakkoa2\\arakkoa2.m2"] = {
		["you"] = {
			["height"] = 1.12,
		},
		["me"] = {
			["height"] = 1.49,
		},
	},
	["1011653~creature\\salamander\\salamandermale.m2"] = {
		["me"] = {
			["height"] = 1.639,
		},
		["you"] = {
			["height"] = 1.019,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Draenei male
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["1005887~307453"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 1.23,
		},
	},
	["1005887~950080"] = {
		["me"] = {
			["offset"] = 0.185,
		},
		["you"] = {
			["scale"] = 2.1,
			["offset"] = 0.245,
		},
	},
	["1005887~900914"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 2.52,
			["feet"] = 0.43,
		},
	},
	["1005887~589715"] = {
		["me"] = {
			["offset"] = 0.185,
		},
		["you"] = {
			["scale"] = 1.82,
			["offset"] = 0.245,
		},
	},
	["1005887~535052"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 1.31,
		},
	},
	["1005887~110258"] = {
		["me"] = {
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.7,
			["offset"] = 0.245,
		},
	},
	["1005887~921844"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 1.57,
		},
	},
	["1005887~940356"] = {
		["you"] = {
			["offset"] = 0.225,
			["scale"] = 2.7599,
			["feet"] = 0.42,
		},
		["me"] = {
			["scale"] = 1.44,
			["offset"] = 0.195,
		},
	},
	["1005887~878772"] = {
		["you"] = {
			["offset"] = 0.195,
			["scale"] = 1.9,
			["feet"] = 0.41,
		},
		["me"] = {
			["offset"] = 0.205,
		},
	},
	["1005887~119369"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["offset"] = 0.195,
			["scale"] = 2.25,
			["feet"] = 0.42,
		},
	},
	["1005887~974343"] = {
		["me"] = {
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.42,
			["offset"] = 0.225,
		},
	},
	["1005887~1022598"] = {
		["you"] = {
			["scale"] = 1.44,
		},
		["me"] = {
			["offset"] = 0.195,
			["scale"] = 1.44,
		},
	},
	["1005887~1011653"] = {
		["you"] = {
			["scale"] = 1.61,
		},
		["me"] = {
			["offset"] = 0.195,
			["scale"] = 1.38,
		},
	},
	["1005887~119376"] = {
		["me"] = {
			["offset"] = 0.185,
		},
		["you"] = {
			["offset"] = 0.215,
			["scale"] = 2.399,
			["feet"] = 0.41,
		},
	},
	["1005887~307454"] = {
		["me"] = {
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.38,
			["offset"] = 0.235,
		},
	},
	["1005887~949470"] = {
		["me"] = {
			["scale"] = 1.42,
		},
		["you"] = {
			["scale"] = 1.68,
			["offset"] = 0.195,
		},
	},
	["1005887~968705"] = {
		["me"] = {
			["scale"] = 1.56,
		},
		["you"] = {
			["scale"] = 1.05,
		},
	},

	-- VS NPC
	["1005887~creature\\agronn\\agronn.m2"] = {
		["me"] = {
			["scale"] = 3.44999999999999,
		},
		["you"] = {
			["scale"] = 1.2,
		},
	},
	["1005887~creature\\ogredraenor\\ogredraenor.m2"] = {
		["me"] = {
			["scale"] = 2.15,
		},
		["you"] = {
			["scale"] = 1.45,
		},
	},
	["1005887~character\\broken\\male\\brokenmale.m2"] = {
		["me"] = {
			["offset"] = 0.215,
		},
		["you"] = {
			["scale"] = 1.66,
			["offset"] = 0.225,
		},
	},
	["1005887~creature\\humanfemalekid\\humanfemalekid.m2"] = {
		["you"] = {
			["scale"] = 3.38,
			["feet"] = 0.43,
			["offset"] = 0.215,
			["facing"] = 0.73,
		},
	},
	["1005887~creature\\humanmalekid\\humanmalekid.m2"] = {
		["you"] = {
			["scale"] = 1.4,
			["facing"] = 0.79,
			["offset"] = 0.125,
			["feet"] = 0.45,
		},
	},
	["1005887~creature\\kingvarianwrynn\\kingvarianwrynn.m2"] = {
		["me"] = {
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.37,
			["offset"] = 0.245,
		},
	},
	["1005887~creature\\arakkoaoutland\\arakkoaoutland.m2"] = {
		["me"] = {
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 1.6,
			["offset"] = 0.215,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Gnome male
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- VS player models
	["900914~878772"] = {
		["me"] = {
			["scale"] = 1.58,
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.08,
			["offset"] = 0.185,
		},
	},
	["900914~1011653"] = {
		["me"] = {
			["scale"] = 2.06,
			["offset"] = 0.185,
			["feet"] = 0.42,
		},
		["you"] = {
			["scale"] = 1.3,
			["offset"] = 0.225,
		},
	},
	["900914~900914"] = {
		["me"] = {
			["offset"] = 0.195,
		},
		["you"] = {
			["offset"] = 0.205,
		},
	},
	["900914~307454"] = {
		["me"] = {
			["scale"] = 2.5,
			["offset"] = 0.205,
			["feet"] = 0.42,
		},
		["you"] = {
			["scale"] = 1.3,
		},
	},
	["900914~1022598"] = {
		["me"] = {
			["scale"] = 2.779,
			["offset"] = 0.195,
			["feet"] = 0.42,
		},
		["you"] = {
			["scale"] = 1.38,
			["offset"] = 0.245,
		},
	},
	["900914~921844"] = {
		["me"] = {
			["scale"] = 2.5199,
			["offset"] = 0.205,
		},
		["you"] = {
			["scale"] = 1.35,
		},
	},
	["900914~589715"] = {
		["you"] = {
			["offset"] = 0.235,
			["scale"] = 1.37,
		},
		["me"] = {
			["offset"] = 0.175,
			["scale"] = 2.24,
		},
	},
	["900914~535052"] = {
		["me"] = {
			["scale"] = 2.599,
			["offset"] = 0.195,
		},
		["you"] = {
			["scale"] = 1.12,
		},
	},
	["900914~974343"] = {
		["me"] = {
			["scale"] = 2.389,
			["offset"] = 0.185,
			["feet"] = 0.42,
		},
		["you"] = {
			["scale"] = 1.26,
		},
	},
	["900914~119376"] = {
		["you"] = {
			["offset"] = 0.195,
			["scale"] = 1.34,
		},
		["me"] = {
			["offset"] = 0.165,
		},
	},
	["900914~950080"] = {
		["you"] = {
			["offset"] = 0.265,
			["scale"] = 1.21,
		},
		["me"] = {
			["offset"] = 0.175,
			["scale"] = 1.6,
		},
	},
	["900914~119369"] = {
		["you"] = {
			["offset"] = 0.185,
			["scale"] = 1.41,
		},
		["me"] = {
			["offset"] = 0.175,
		},
	},

	-- VS NPC
	["900914~creature\\draenorancient\\draenorancientgorgrond.m2"] = {
		["me"] = {
			["scale"] = 7.5499,
			["feet"] = 0.42,
		},
		["you"] = {
			["scale"] = 0.75,
		},
	},
	["900914~creature\\kingvarianwrynn\\kingvarianwrynn.m2"] = {
		["me"] = {
			["scale"] = 2.6999,
			["offset"] = 0.215,
		},
		["you"] = {
			["scale"] = 1.37,
			["offset"] = 0.235,
		},
	},
	["900914~character\\broken\\male\\brokenmale.m2"] = {
		["you"] = {
			["scale"] = 1.37,
			["feet"] = 0.38,
			["facing"] = 0.79,
		},
		["me"] = {
			["offset"] = 0.175,
			["scale"] = 2.1,
		},
	},
	["900914~creature\\humanfemalekid\\humanfemalekid.m2"] = {
		["me"] = {
			["scale"] = 1.31,
			["offset"] = 0.175,
		},
		["you"] = {
			["scale"] = 1.59,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Dwarf female
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["950080~878772"] = {
		["me"] = {
			["height"] = 1.299,
		},
		["you"] = {
			["height"] = 1.179,
		},
	},
	["950080~968705"] = {
		["you"] = {
			["height"] = 1.029,
		},
		["me"] = {
			["height"] = 2,

		},
	},
	["950080~974343"] = {
		["you"] = {
			["height"] = 1.23,
		},
		["me"] = {
			["height"] = 1.709,
		},
	},
	["950080~307454"] = {
		["me"] = {
			["height"] = 1.639,
		},
		["you"] = {
			["height"] = 1.299,
		},
	},
	["950080~1011653"] = {
		["me"] = {
			["height"] = 1.599,
		},
		["you"] = {
			["height"] = 1.279,
		},
	},
	["950080~940356"] = {
		["me"] = {
			["height"] = 1.299,
		},
		["you"] = {
			["height"] = 1.799,
		},
	},
	["950080~535052"] = {
		["you"] = {
			["height"] = 1.299,
		},
		["me"] = {
			["height"] = 1.769,
		},
	},

	-- VS NPC
	["950080~creature\\blingtron\\blingtron.m2"] = {
		["me"] = {
			["height"] = 1.269,
		},
		["you"] = {
			["height"] = 1.579,
		},
	},
	["950080~creature\\humanmalekid\\humanmalekid.m2"] = {
		["you"] = {
			["height"] = 0.799,
		},
		["me"] = {
			["height"] = 1.299,

		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Loup loup !
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["creature\\wolfdraenor\\wolfdraenor.m2~1000764"] = {
		["me"] = {
			["height"] = 1.74,
		},
		["you"] = {
			["height"] = 1.299,
		},
	},
	["creature\\wolfdraenor\\wolfdraenor.m2~307453"] = {
		["you"] = {
			["height"] = 1.24,
		},
		["me"] = {
			["height"] = 2,
		},
	},
	["creature\\wolfdraenor\\wolfdraenor.m2~1011653"] = {
		["me"] = {
			["height"] = 1.799,
		},
		["you"] = {
			["height"] = 1.299,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Night elves Female
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["921844~974343"] = {
		["you"] = {
			["scale"] = 1.41,
		},
		["me"] = {
			["scale"] = 1.56,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Blood elves Female
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models
	["110258~1018060"] = {
		["you"] = {
			["scale"] = 1.25,
		},
		["me"] = {
			["scale"] = 1.55,
		},
	},
	["110258~968705"] = {
		["me"] = {
			["scale"] = 1.79,
		},
		["you"] = {
			["scale"] = 1.05,
		},
	},

	-- VS NPC
	["110258~creature\\thralldoomplate\\thralldoomplate.m2"] = {
		["you"] = {
			["scale"] = 1.15,
		},
		["me"] = {
			["scale"] = 1.55,
		},
	},
	["110258~creature\\miev\\miev.m2"] = {
		["you"] = {
			["scale"] = 1.25,
		},
		["me"] = {
			["scale"] = 1.75,
		},
	},

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Troll male
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	-- VS player models

	-- VS NPC
	["1022938~creature\\khadgar2\\khadgar2.m2"] = {
		["me"] = {
			["offset"] = 0.125,
			["scale"] = 1.46,
		},
	},
	["1022938~creature\\velen2\\velen2.m2"] = {
		["you"] = {
			["scale"] = 1.03,
		},
		["me"] = {
			["scale"] = 1.79,
			["offset"] = 0.165,
		},
	},
	["1022938~creature\\naaru\\naaru.m2"] = {
		["me"] = {
			["scale"] = 2.65,
			["offset"] = 0.175,
		},
		["you"] = {
			["scale"] = 1.51,
			["offset"] = 0.215,
		},
	},
}

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Scaling API
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function Lib:GetModelScaling(model1, model2)
	local key = model1 .. "~" .. model2;
	if SCALE_MAPPING[key] then
		return SCALE_MAPPING[key].me or DEFAULT_SCALE.me, SCALE_MAPPING[key].you or DEFAULT_SCALE.you, false;
	end

	local inverted = model2 .. "~" .. model1;
	if SCALE_MAPPING[inverted] then
		return SCALE_MAPPING[inverted].you or DEFAULT_SCALE.you, SCALE_MAPPING[key].me or DEFAULT_SCALE.me, true;
	end

	return DEFAULT_SCALE.me, DEFAULT_SCALE.you;
end

function Lib:GetModelDefaultScaling()
	return DEFAULT_SCALE;
end

function Lib:SetModelHeight(scale, frame)
	scale = scale or DEFAULT_SCALE.me.scale;
	frame.scale = scale;
	frame:InitializeCamera(scale);
end

function Lib:SetModelFacing(facing, frame, isMe)
	facing = facing or DEFAULT_SCALE.me.facing;
	frame.facing = facing;
	frame:SetFacing(facing * (isMe and 1 or -1));
end

function Lib:SetModelFeet(feet, frame)
	feet = feet or DEFAULT_SCALE.me.feet;
	frame.feet = feet;
	frame:SetHeightFactor(feet);
end

function Lib:SetModelOffset(offset, frame, isMe)
	offset = offset or DEFAULT_SCALE.me.offset;
	frame.offset = offset;
	frame:SetTargetDistance(offset * (isMe and 1 or -1));
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- DEBUG AND MAINTENANCE
-- Don't use it on your code. :)
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local debugPlayerModelList = {
	-- Alliance
	"1000764",
	"1011653",
	"940356",
	"900914",
	"950080",
	"878772",
	"1022598",
	"1005887",
	"535052",
	"589715",
	"921844",
	"974343",
	"307453",
	"307454",

	-- Horde
	--	"119376",
	--	"119369",
}

--function TRP3_API.extended.animations.debugMissingScaling()
--	local alreadyTreated = {};
--	local count = 0;
--	for _, firstModel in pairs(debugPlayerModelList) do
--		for _, secondModel in pairs(debugPlayerModelList) do
--			if firstModel ~= secondModel then
--				local key, invertedKey = firstModel .. "~" .. secondModel, secondModel .. "~" .. firstModel;
--				if not TRP3_API.extended.animations.SCALE_MAPPING[key] and not TRP3_API.extended.animations.SCALE_MAPPING[invertedKey] and not alreadyTreated[key] and not alreadyTreated[invertedKey] then
--					alreadyTreated[key] = true;
--					alreadyTreated[invertedKey] = true;
--					count = count + 1;
--					print(("Missing scaling for %s + %s"):format(firstModel, secondModel));
--				end
--			end
--		end
--	end
--	print(("Total %s"):format(count));
--end
--
--local IMPORT = {
--
--}
--
--function TRP3_API.extended.animations.API.debugComplete()
--	if not TRP3_API.extended.animations.Data.debug.finalImport then
--		TRP3_API.extended.animations.Data.debug.finalImport = {};
--	end
--	wipe(TRP3_API.extended.animations.Data.debug.finalImport);
--	-- Find which key to import
--	local toImport = {};
--	for key, info in pairs(IMPORT) do
--		local firstModel = key:sub(1, key:find("~") - 1);
--		local secondModel = key:sub(key:find("~") + 1);
--		local invertedKey = secondModel .. "~" .. firstModel;
--		if not TRP3_API.extended.animations.SCALE_MAPPING[key] and not TRP3_API.extended.animations.SCALE_MAPPING[invertedKey] then
--			print("new to import: " .. key);
--			TRP3_API.extended.animations.Data.debug.finalImport[key] = info;
--		end
--	end
--end