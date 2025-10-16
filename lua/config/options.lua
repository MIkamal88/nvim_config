local opt = vim.opt

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- Tabs not spaces
opt.expandtab = false

-- Mostly for cmp?
opt.completeopt = { "menu" }

-- Ignore case when searching
opt.ignorecase = true

-- Set term gui colors
opt.termguicolors = true

-- Faster completions
opt.updatetime = 200

opt.shell = "fish"
-- Change DapBreakpoint Icon
vim.fn.sign_define("DapBreakpoint", { text = "" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- More space in Command Line for displaying messages.
opt.cmdheight = 1

-- Disable autoformat
vim.g.autoformat = false

-- Folding
-- vim.o.foldenable = true
-- vim.o.foldlevel = 99
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldtext = ""
-- vim.opt.foldcolumn = "0"
-- vim.opt.fillchars:append({fold = " "})
