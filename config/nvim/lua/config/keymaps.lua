-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- diff active tabs
map("n", "<leader>gw", function()
	vim.cmd("windo diffthis")
end, { noremap = true, desc = "Git diff (w)indows" })

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

map("n", "<leader>y", '"+y', { noremap = true, silent = true })
map("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- wrap text with quotes (i.e 3q" will wrap 3 words in quotes)
local function surround_in_quotes()
	local count = vim.v.count1 -- defaults to 1 if no count is given
	vim.cmd("normal! v" .. count .. "e") -- visually select N words
	vim.cmd('normal! "zy') -- yank selection into register z
	vim.cmd('normal! gv"_d') -- delete the selected text (without yanking again)
	vim.cmd('normal! i"' .. vim.fn.getreg("z") .. '"') -- insert quotes around it
	vim.cmd("stopinsert") -- return to normal mode
end
map("n", 'q"', surround_in_quotes, { noremap = true, silent = true })

-- Map <leader-j/k> to go to the next/prev method start
-- NOTE: Commented out for tmux navigator - experiment with ]m/[m or <leader>mj/<leader>mk
-- map("n", "<C-j>", ":normal ]mzz<CR>", { noremap = true, silent = true })
-- map("n", "<C-k>", ":normal [mzz<CR>", { noremap = true, silent = true })

-- Close the buffer
map("n", "<leader>q", ":bp|bd #<CR>", { noremap = true, silent = true })
map("n", "<leader>Q", ":%bd|e#|bd#<CR>", { noremap = true, silent = true })

-- [buffer] cycle through focus
-- NOTE. should start to use ]b and [b (or shift+h/l)
-- map("n", "<C-]>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- map("n", "<C-[>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- [buffer] move/reorder
-- NOTE. shoudl start to use ]B and [B
map("n", "<leader>]", ":BufferLineMoveNext<CR>", { noremap = true, silent = true })
map("n", "<leader>[", ":BufferLineMovePrev<CR>", { noremap = true, silent = true })

-- Map <C-j/k> to go to cnext/cprev
map("n", "<leader>j", ":cnext<CR>", { noremap = true, silent = true })
map("n", "<leader>k", ":cprev<CR>", { noremap = true, silent = true })

-- Used for highlighting word on click
map(
	"n",
	"<2-LeftMouse>",
	[[<cmd>exe 'highlight DoubleClick ctermbg=green guibg=green<bar>match DoubleClick /\V\<'.escape(expand('<cword>'), '\').'\>/'<cr>]],
	{ noremap = true, silent = true }
)

-- Rebinding Shift+J and Shift+K for visual block selection
map("n", "gK", "va{", { noremap = true, silent = true, desc = "Visual around {}" })
map("n", "gJ", "vi{", { noremap = true, silent = true, desc = "Visual inside {}" })

-- Pretty-print current JSONL line in a floating window
map("n", "<leader>jj", function()
	local line = vim.api.nvim_get_current_line()
	local result = vim.fn.system("jq .", line)
	if vim.v.shell_error ~= 0 then
		vim.notify("Not valid JSON on this line", vim.log.levels.WARN)
		return
	end
	local lines = vim.split(result, "\n")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].filetype = "json"
	vim.bo[buf].modifiable = false
	local width = math.min(120, vim.o.columns - 4)
	local height = math.min(#lines, vim.o.lines - 4)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	})
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true, silent = true })
end, { noremap = true, silent = true, desc = "Pretty-print JSONL line" })

-- " Moving between windows (from Ben Frain's talk at NeovimConf 2022) <Leader>1-6
for i = 1, 6 do
	local lhs = "<leader>" .. i
	local rhs = i .. "<c-w>w"
	map("n", lhs, rhs, { remap = true, desc = "Move to window " .. i })
end
