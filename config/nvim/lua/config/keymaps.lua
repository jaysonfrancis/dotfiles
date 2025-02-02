-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local nvim_set_km = vim.api.nvim_set_keymap

-- commenting (switch to "gc")
-- nvim_set_km("v", "<//>", ":CommentToggle<CR>", { noremap = true, silent = true })
-- nvim_set_km("n", "<//>", ":CommentToggle<CR>", { noremap = true, silent = true })

-- reveal active file in neotree
map("n", "<leader>fr", ":Neotree reveal<CR>", {})

-- remove search highligts with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- line switcher (ty prime)
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

-- find files map
map("n", "<c-P>", require("fzf-lua").files, { desc = "Fzf Files" })
map("n", "<c-F>", require("fzf-lua").live_grep, { desc = "Fzf Live Grep" })
map("n", "<c-H>", require("fzf-lua").helptags, { desc = "Fzf Help" })

-- neo tree (or leader+fe and fE)
map("n", "<c-N>", ":Neotree toggle<CR>", { desc = "Neotree toggle" })

nvim_set_km("n", "<leader>y", '"+y', { noremap = true, silent = true })
nvim_set_km("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- Map <leader-j/k> to go to the next/prev method start
nvim_set_km("n", "<C-j>", ":normal ]mzz<CR>", { noremap = true, silent = true })
nvim_set_km("n", "<C-k>", ":normal [mzz<CR>", { noremap = true, silent = true })

-- Close the buffer
nvim_set_km("n", "<leader>q", ":bp|bd #<CR>", { noremap = true, silent = true })
nvim_set_km("n", "<leader>Q", ":%bd|e#|bd#<CR>", { noremap = true, silent = true })

-- [buffer] cycle through focus
-- NOTE. should start to use ]b and [b (or shift+h/l)
-- nvim_set_km("n", "<C-]>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- nvim_set_km("n", "<C-[>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- [buffer] move/reorder
-- NOTE. shoudl start to use ]B and [B
nvim_set_km("n", "<leader>]", ":BufferLineMoveNext<CR>", { noremap = true, silent = true })
nvim_set_km("n", "<leader>[", ":BufferLineMovePrev<CR>", { noremap = true, silent = true })

-- Map <C-j/k> to go to cnext/cprev
nvim_set_km("n", "<leader>j", ":cnext<CR>", { noremap = true, silent = true })
nvim_set_km("n", "<leader>k", ":cprev<CR>", { noremap = true, silent = true })

-- Used for highlighting word on click
nvim_set_km(
	"n",
	"<2-LeftMouse>",
	[[<cmd>exe 'highlight DoubleClick ctermbg=green guibg=green<bar>match DoubleClick /\V\<'.escape(expand('<cword>'), '\').'\>/'<cr>]],
	{ noremap = true, silent = true }
)

-- Rebinding Shift+J and Shift+K for visual block selection
nvim_set_km("n", "K", "va{", { noremap = true, silent = true })
nvim_set_km("n", "J", "vi{", { noremap = true, silent = true })

-- " Moving between windows (from Ben Frain's talk at NeovimConf 2022) <Leader>1-6
for i = 1, 6 do
	local lhs = "<leader>" .. i
	local rhs = i .. "<c-w>w"
	map("n", lhs, rhs, { remap = true, desc = "Move to window " .. i })
end
