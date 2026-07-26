return {
	{
		"iamcco/markdown-preview.nvim",
		keys = {
			{ "<leader>uP", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview (Browser)" },
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		opts = {
			modes = { "n", "i", "c", "v", "V" },
			hybrid_modes = { "n", "i", "c", "v", "V" },

			preview = {
				icon_provider = "internal",
			},

			markdown = {
				headings = {
					enable = true,
					shift_width = 3,
					heading_1 = {
						style = "label",
						sign = false,
					},
					heading_2 = {
						style = "label",
						sign = false,
					},
					heading_3 = {
						style = "label",
						sign = false,
					},
					heading_4 = {
						style = "label",
						sign = false,
					},
					heading_5 = {
						style = "label",
						sign = false,
					},
					heading_6 = {
						style = "label",
						sign = false,
					},
				},
				code_blocks = {
					style = "block",
					sign = false,
				},
				checkboxes = {
					enable = true,
				},
				block_quotes = {
					enable = true,
				},
				horizontal_rules = {
					enable = true,
				},
				list_items = {
					enable = true,
				},
				tables = {
					enable = true,
				},
			},

			latex = {
				enable = true,
			},

			html = {
				enable = true,
			},

			yaml = {
				enable = true,
			},
		},
		keys = {
			{ "<leader>um", "<cmd>Markview Toggle<cr>", desc = "Toggle Markview" },
			{ "<leader>uM", "<cmd>Markview splitToggle<cr>", desc = "Toggle Markview Split" },
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<leader>uP", desc = "Markdown Preview (Browser)" },
			},
		},
	},
}
