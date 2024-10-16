return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  -- Theme
  use('dracula/vim')
  use('nvim-lualine/lualine.nvim')

  -- Navigation
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
      {'nvim-lua/plenary.nvim'},
    }
  })
  use('nvim-tree/nvim-tree.lua')

  -- Code intelligence
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' })
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')

  -- Git
  use('lewis6991/gitsigns.nvim')

  -- Utilities
  use('tpope/vim-surround')
end)
