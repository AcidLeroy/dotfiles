-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--
--vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
  }
  -- This will help with fuzzy finding speed
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


   use ({
       'morhetz/gruvbox',
       config = function()
           vim.cmd('colorscheme gruvbox')
       end,
      requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
   })


  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
     {'williamboman/mason.nvim'},
     {'williamboman/mason-lspconfig.nvim'},

    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}


  use("folke/zen-mode.nvim")
  use("github/copilot.vim")

  use("ggandor/leap.nvim")

  use{"nvim-tree/nvim-tree.lua", 
    requires =  {'nvim-tree/nvim-web-devicons'} 
  }

  use("yamatsum/nvim-cursorline")

  use {
	  'akinsho/bufferline.nvim', tag = '*',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-tree/nvim-web-devicons'} }
  }

end)
