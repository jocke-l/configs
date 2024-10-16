require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "python",
    "c",
    "javascript",
    "typescript",
    "go",
    "haskell",
  },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
