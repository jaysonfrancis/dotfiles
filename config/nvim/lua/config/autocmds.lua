-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- syntax highlighting for jsonl lines
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jsonl",
	callback = function()
		vim.bo.filetype = "json"
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	--- Remove the whitespace eol ---
	pattern = "*",
	callback = function()
		-- Save cursor position
		local curpos = vim.api.nvim_win_get_cursor(0)
		-- Remove trailing whitespace
		vim.cmd([[%s/\s\+$//e]])
		-- Restore cursor position
		vim.api.nvim_win_set_cursor(0, curpos)
	end,
})

-- Toggle relative numbers in normal mode only
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})
