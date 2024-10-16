vim.cmd.colorscheme("dracula")

vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.colorcolumn = "89"

require('lualine').setup {
  options = {
    theme = "dracula",
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  }
}
