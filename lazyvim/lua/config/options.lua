-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.opt.colorcolumn = { 80, 100, 120 }
vim.opt.whichwrap = "b,s,<,>,h,l,[,]"

vim.g.lazyvim_python_lsp = "basedpyright"
