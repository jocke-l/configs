require("nvim-tree").setup()

local api = require("nvim-tree.api")

vim.keymap.set("n", "<Leader>tt", api.tree.toggle)
vim.keymap.set("n", "<Leader>tf", function () api.tree.toggle({ find_file = true }) end)
