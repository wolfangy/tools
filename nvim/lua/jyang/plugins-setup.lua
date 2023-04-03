local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(
    function(use)
          use 'wbthomason/packer.nvim'
          -- My plugins here
         
          -- lua functions that many plugins use
          use 'nvim-lua/plenary.nvim'

          -- preferred colorscheme
          use 'bluz71/vim-nightfly-guicolors'

          -- tmux
          use 'christoomey/vim-tmux-navigator' 

          -- maximize the window by toggling
          use 'szw/vim-maximizer' 

          -- update / trim surround
          use 'tpope/vim-surround' 

          -- replace with the register
          use 'vim-scripts/ReplaceWithRegister' 

          -- commenting with `gc`
          use 'numToStr/Comment.nvim'

          -- file explorer
          use 'nvim-tree/nvim-tree.lua'

          -- icons
          use 'kyazdani42/nvim-web-devicons'

          -- statusline
          use 'nvim-lualine/lualine.nvim'

          -- fuzzy finding
          use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
          use({ "nvim-telescope/telescope.nvim", branch="0.1.x" })

          -- autocompletion
          use 'hrsh7th/nvim-cmp'
          use 'hrsh7th/cmp-buffer'
          use 'hrsh7th/cmp-path'

          -- snippets
          use 'L3MON4D3/LuaSnip'
          use 'saadparwaiz1/cmp_luasnip'
          use 'rafamadriz/friendly-snippets'

          -- managing & installing lsp servers
          use 'williamboman/mason.nvim'
          use 'williamboman/mason-lspconfig.nvim'
          
          -- coc
        --   use {'neoclide/coc.nvim', branch = 'release'}

          -- configuring lsp servers
          use 'neovim/nvim-lspconfig'
          
          -- lsp in autocompletion
          use 'hrsh7th/cmp-nvim-lsp' 
          
          -- enhance UI for lsp
          use ({ "glepnir/lspsaga.nvim", branch = "main" }) 
          
          -- icon for autocompletion window
          use 'onsails/lspkind.nvim' 


          -- Automatically set up your configuration after cloning packer.nvim
          -- Put this at the end after all plugins
          if packer_bootstrap then
            require('packer').sync()
          end
    end
)
