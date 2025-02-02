return {
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {},
		},
	},

	-- Formatters via conform.nvim
	-- https://github.com/stevearc/conform.nvim
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format" },
				rust = { "rustfmt" },
			},
		},
	},
}
