--- These are a bunch of utilitarian functions with a simple input and output mechanism.
--- Their main goal is to be used for functional programming, passed in Observable chains.
local Utils = {}

--- Creates a new static function that will always be called with the given parameters.
---@generic T
---@param functionToBeCalled fun(T)
---@vararg T
---@return fun():T
function Utils.CallWith(functionToBeCalled, ...)
    local parameters = { ... }
    return function(...)
        tAppendAll(parameters, { ... })
        return functionToBeCalled(unpack(parameters))
    end
end

---@param template string
---@return Button
function Utils.CreateButton(template)
    return CreateFrame("BUTTON", nil, nil, template)
end
---@return Frame
function Utils.CreateFrame()
    return CreateFrame("FRAME")
end

function Utils.IsTrue(value)
    return value == true
end

function Utils.Is(expectedValue)
    return function(value) return value == expectedValue end
end

function Utils.First(value)
    return function(...)
        return value, ...
    end
end

function Utils.IsNil(value)
    return value == nil
end

function Utils.Not(booleanFunc)
    return function(value)
        return not booleanFunc(value)
    end
end

function Utils.Add(add)
    return function(value)
        return value + add
    end
end

function Utils.TakeNth(n)
    return function(...)
        local values = { ... }
        return values[n]
    end
end

function Utils.Round(decimals)
    return function(num)
        local mult = 10^(decimals or 0)
        return math.floor(num * mult + 0.5) / mult
    end
end

local LINE_FEED_CODE = string.char(10)
local CARRIAGE_RETURN_CODE = string.char(13)
local WEIRD_LINE_BREAK = LINE_FEED_CODE .. CARRIAGE_RETURN_CODE .. LINE_FEED_CODE
function Utils.Split(text)

    text = text:gsub(LINE_FEED_CODE .. "+", "\n");
    text = text:gsub(WEIRD_LINE_BREAK, "\n");

    local texts = {};
    -- Don't use lines that just contains spaces (because of Blizzard's interns)
    for _, part in pairs({ strsplit("\n", text) }) do
        if strtrim(text):len() > 0 then
            table.insert(texts, part);
        end
    end
    return texts
end

return Utils