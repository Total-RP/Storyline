return {
	IsNil = function(value) return value == nil end,
	Not = function(func) return function(value) return not func(value) end end,
	NilTo = function(toValue) return function(value) return value or toValue end end,
	Is = function(expected) return function(value) return value == expected end end
}