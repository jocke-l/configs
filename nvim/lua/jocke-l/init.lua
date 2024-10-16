require("jocke-l.packer")
require("jocke-l.theme")
require("jocke-l.lsp")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.wrapscan = false
vim.opt.mouse = "a"
vim.opt.incsearch = true
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

vim.keymap.set("n", "<leader>\\", function () vim.cmd("nohlsearch") end)
