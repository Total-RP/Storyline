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

};

read_globals = {

};

std = "lua51";
