use = require('packer').use

require('packer').startup(function()
  --Plugins list
  --(Colorschemes)
  use 'morhetz/gruvbox' -- gruvbox colorscheme
  use 'ayu-theme/ayu-vim' -- ayu colorscheme
  use 'tomasr/molokai' -- molokai colorscheme
  use 'rose-pine/neovim'
  use 'dracula/vim'
  use 'cseelus/nvim-colors-tone'

  --(Syntax highlighting)

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
  -- use 'johnsyweb/vim-makeshift'


  --(Package management)
  use 'wbthomason/packer.nvim' -- Package manager

  --(Without category)
  use 'tpope/vim-surround'
  use 'rickhowe/diffchar.vim' -- modify diffing capabilities
  use 'Yggdroot/indentLine' -- show how much tabs were used 
  use 'windwp/nvim-autopairs' -- quotes autocompletion
  use 'vim-test/vim-test' -- unittests support for several languages
  use 'tomtom/tcomment_vim'
  use 'luochen1990/rainbow'

end)

--load plugins with empty setup here, other load based on preferences
require 'nvim-autopairs'.setup{}

--Set nvim options
vim.o.mouse = ""
vim.o.colorcolumn = "80"
vim.o.wildmenu=true
vim.o.termguicolors=true
vim.o.background='dark'
vim.o.relativenumber = true
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.number = true
vim.cmd "set path=$PWD/**" 
vim.cmd "set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp" 

--Set globals
vim.g.python_highlight_all = 1
vim.g.challenger_deep_termcolors = 256
vim.g.mapleader = ','
vim.g.rainbow_active = 1

--Set look & feel
vim.cmd "colorscheme gruvbox"

--Set misc
vim.api.nvim_exec([[
  au FocusLost * silent! wa
]], false)
vim.cmd "command! Wq wq"

--Set keymaps
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<M-l>', '<cmd>bn<cr>', opts)
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>bp<cr>', opts)
vim.api.nvim_set_keymap('t', '<M-h>', '<C-\\><C-n><cmd>bp<cr>', opts)
vim.api.nvim_set_keymap('t', '<M-l>', '<C-\\><C-n><cmd>bn<cr>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<esc>o', opts)
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', 'vr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


--Set language lsp
local servers = { 'clangd', 'rust_analyzer', 'ltex', 'pyright', 'ocamllsp', 'gopls'}

local lspconfig = require('lspconfig')
--
-- enable nvim-cmp additionsl capabilities and set up servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end
local luasnip = require'luasnip'
local cmp = require 'cmp'
local lspkind = require "lspkind"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    else
        return t "<Tab>"
      end
  end
_G.s_tab_complete = function()
    if luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
end

cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 75, 
            before = function (entry, vim_item)
              if entry.kind == "Keyword" then
                return false
              end
              return vim_item
              end
        })
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),
    sources = {
      { name = 'nvim_lsp', weight = 1 },
      { name = 'luasnip', weight = 2 },
    },
}

require("luasnip.loaders.from_vscode").lazy_load()

vim.api.nvim_exec([[let g:makeshift_systems = {'Cargo.toml':'cargo'} ]], true)



