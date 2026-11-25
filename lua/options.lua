require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.number = true
o.swapfile = false
o.shell = "fish"
o.timeoutlen = 1000
o.conceallevel = 2

o.scrolloff = 8
o.sidescrolloff = 8
o.inccommand = "split" -- live preview of :s substitutions
o.confirm = true -- ask to save instead of failing on :q with unsaved changes

-- Treesitter folding, all folds open by default (zc/zo/za to fold, zR/zM all)
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevelstart = 99
o.foldtext = ""

