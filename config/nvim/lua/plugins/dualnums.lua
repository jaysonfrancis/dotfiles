return {
	"shrynx/line-numbers.nvim",
	opts = {
		mode = "both", -- "relative", "absolute", "both", "none"
		format = "abs_rel", -- or "rel_abs"
		separator = " ",
		rel_highlight = { link = "LineNr" },
		abs_highlight = { link = "LineNr" },
		current_rel_highlight = { link = "CursorLineNr" },
		current_abs_highlight = { link = "CursorLineNr" },
	},
}
