local use = require('packer').use

require('packer').startup(function()

use 'airblade/vim-gitgutter' -- git integration
--use 'hrsh7th/cmp-buffer'
--use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/cmp-nvim-lsp'
--use 'hrsh7th/cmp-path'
use 'hrsh7th/nvim-cmp'
use 'L3MON4D3/LuaSnip' -- snippets engine
use 'lervag/vimtex'
use 'morhetz/gruvbox' -- gruvbox colorscheme
use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
use 'nvim-lualine/lualine.nvim'
use 'rafamadriz/friendly-snippets' -- snippets collection
use 'regen100/cmake-language-server'
use 'rhysd/committia.vim'
use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
use 'tomasr/molokai' -- molokai colorscheme
use 'vim-test/vim-test' -- unittests support
use 'wbthomason/packer.nvim' -- Package manager
use 'windwp/nvim-autopairs' -- quotes autocompletion
use 'Yggdroot/indentLine'
use 'onsails/lspkind.nvim' -- fancy incons for nvim lsp
end)
require'lspconfig'.pyright.setup{}
require'lspconfig'.ltex.setup{}
require'nvim-autopairs'.setup{}
require'lspconfig'.cmake.setup{}


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'iceberg_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '🭐', right = '🭅'},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
      lualine_a = {'buffers'},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'branch', 'diff'}
  },
  extensions = {}
}


require'lualine'.setup()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


vim.api.nvim_set_keymap('n', 'vD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'vd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'vr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

local servers = { 'pyright'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
local use = require('packer').use

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- luasnip setup
local luasnip = require 'luasnip'

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")


require("luasnip.loaders.from_vscode").lazy_load()


vim.cmd[[
set path=$PWD/**
set wildmenu
set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp
colorscheme molokai
command! Wq wq
]]

-- Completion
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({

  -- ... Your other configuration ...

  mapping = {

    -- ... Your other mappings ...


    ['<c-space>'] = cmp.mapping.complete(),

    -- ... Your other mappings ...
  },

  -- ... Your other configuration ...
})

-- End completion



vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = true
vim.opt.relativenumber = true

vim.g.mapleader = ','
vim.g.challenger_deep_termcolors = 256
vim.g.python_highlight_all = 1

vim.api.nvim_set_keymap('n', '<M-l>', '<cmd>bn<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>bp<cr>', {noremap=true})

vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'cmake'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end
require('lspConf')
