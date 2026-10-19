local Storyline_API = select(2, ...);

Storyline_API.Ellyb = {};

-- Temporary; will be removed once all internal logging in Ellyb is ripped out.

function Storyline_API.Ellyb.Log(...)
	if Storyline_API.Log then
		Storyline_API.Log(...);
	end
end

function Storyline_API.Ellyb.Logf(...)
	if Storyline_API.Logf then
		Storyline_API.Logf(...);
	end
end
