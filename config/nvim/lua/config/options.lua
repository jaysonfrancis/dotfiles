-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.minipairs_disable = true -- disable the quote matching
vim.g.autoformat = true -- auto format on save

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = true -- Enable wrapping
opt.textwidth = 0 -- Automatically wrap lines
opt.colorcolumn = "101" -- Show color column at the 101st character as a visual aid
-- opt.linebreak = true
-- opt.showbreak = "↪ " -- Adds a subtle arrow for wrapped lines.
-- opt.breakindent = true
--opt.breakindentopt = "shift:2"  -- Indent wrapped lines by 2 spaces.

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true -- false
opt.incsearch = true

opt.ignorecase = true -- search case insensitive
opt.smartcase = true -- search matters if capital letter
opt.inccommand = "split" -- "for incsearch while sub

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

-- reccomended via checkhealth
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- folding
opt.foldmethod = "expr" -- Use treesitter for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Treesitter foldingj
--opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldcolumn = "0" -- Don't show fold column
opt.foldtext = "" -- Don't show fold text
opt.foldnestmax = 4
opt.foldlevel = 99
opt.foldlevelstart = 99
-- set foldopen-=block

opt.foldopen:remove("block")

-- ftdetect/md_jinja.lua
-- vim.filetype.add({
-- 	extension = {
-- 		["md.jinja"] = "markdown.jinja",
-- 	},
-- })
