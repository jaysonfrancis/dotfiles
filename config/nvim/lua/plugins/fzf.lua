local config = require("fzf-lua.config")
local actions = require("fzf-lua.actions")
-- I added this because the alt- keybinds weren't working in default lazyvim
return {
	{
		"ibhagwan/fzf-lua",
		opts = function(_, opts)
			opts.files["actions"] = {
				["ctrl-i"] = { actions.toggle_ignore },
				["ctrl-h"] = { actions.toggle_hidden },
			}

			opts.grep["actions"] = {
				["ctrl-i"] = { actions.toggle_ignore },
				["ctrl-h"] = { actions.toggle_hidden },
			}
		end,
	},
}
