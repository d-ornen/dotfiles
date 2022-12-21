use = require('packer').use

require('packer').startup(function()
--(Colorschemes)
use 'morhetz/gruvbox' -- gruvbox colorscheme
use 'ayu-theme/ayu-vim' -- ayu colorscheme
use 'tomasr/molokai' -- molokai colorscheme
use 'rose-pine/neovim'
use 'dracula/vim'

--(Syntax highlighting)
--use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

--(Autocompletion)
use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
use 'hrsh7th/nvim-cmp' -- a completion plugin for neovim coded in lua
use 'hrsh7th/cmp-nvim-lsp' -- completion support for lsp
use 'saadparwaiz1/cmp_luasnip' -- luasnip completion source
use 'onsails/lspkind.nvim' -- fancy incons for nvim lsp

--(Snippets)
use 'L3MON4D3/LuaSnip' -- snippets engine
use 'rafamadriz/friendly-snippets'

--(Latex)
use 'lervag/vimtex'

--(Git)
use 'airblade/vim-gitgutter' -- git integration
use 'rhysd/committia.vim' -- neat commit message editor layout

-- (Build system support)
use 'johnsyweb/vim-makeshift'


--(Package management)
use 'wbthomason/packer.nvim' -- Package manager

--(Without category)
use 'tpope/vim-surround'
use 'rickhowe/diffchar.vim' -- modify diffing capabilities
use 'Yggdroot/indentLine' -- show how much tabs were used 
use 'windwp/nvim-autopairs' -- quotes autocompletion
use 'vim-test/vim-test' -- unittests support for several languages
end)

require "core.themes"
require "core.options"
require "core.cmds"
require "core.globals"
require "core.keymaps"
require "plugins" -- all plugins configurations start here
