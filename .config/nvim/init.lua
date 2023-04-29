-- convert all buffers to tabs
use = require('packer').use

require('packer').startup(function()
  --Plugins list
  --(Colorschemes)
  use 'morhetz/gruvbox' -- gruvbox colorscheme
  use 'ayu-theme/ayu-vim' -- ayu colorscheme
  use 'tomasr/molokai' -- molokai colorscheme
  use 'Mofiqul/vscode.nvim'
  use 'rose-pine/neovim'
  use 'dracula/vim'
  use 'cseelus/nvim-colors-tone'

  --(Syntax highlighting)
  use 'nvim-treesitter/nvim-treesitter'

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
  use 'tomtom/tcomment_vim'
  use 'luochen1990/rainbow'
  use 'chentoast/marks.nvim'

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
vim.cmd [[ autocmd TabEnter * if &buftype == 'terminal' | execute 'startinsert' | endif ]]

--Set globals
vim.g.python_highlight_all = 1
vim.g.challenger_deep_termcolors = 256
vim.g.mapleader = ','
vim.g.rainbow_active = 1

--Set look & feel
vim.cmd "colorscheme molokai"

--Set misc
vim.api.nvim_exec([[
  au FocusLost * silent! wa
]], false)
vim.cmd "command! Wq wq"

--Set keymaps
local opts = { noremap=true, silent=true }
-- how do we move tabs
vim.api.nvim_set_keymap('n', '<M-l>', '<cmd>tabnext<cr>', opts)
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>tabprev<cr>', opts)
vim.api.nvim_set_keymap('n', '<S-M-l>', '<cmd>+tabmove<cr>', opts)
vim.api.nvim_set_keymap('n', '<S-M-h>', '<cmd>-tabmove<cr>', opts)

vim.api.nvim_set_keymap('t', '<M-h>', '<cmd>tabprev<cr>', opts)
vim.api.nvim_set_keymap('t', '<M-l>', '<cmd>tabnext<cr>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<esc>o', opts)
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', 'vr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'sr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'fm', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})



--Set language lsp
local servers = { 'clangd', 'zls', 'rust_analyzer', 'ltex', 'pyright', 'ocamllsp', 'gopls'}

local lspconfig = require('lspconfig')
require'lspconfig'.tsserver.setup{}
--enable nvim-cmp additionsl capabilities and set up servers
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

require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
vim.g.vimtex_view_method = 'mupdf'

-- oneliner to iterate over colorschemes with f2, f3
local color_schemes = vim.fn.getcompletion('', 'color'); local current_index = 1; local function set_colorscheme(index) current_index = index; vim.cmd('colorscheme ' .. color_schemes[current_index]) end; local function next_colorscheme() local next_index = current_index + 1; if next_index > #color_schemes then next_index = 1 end; set_colorscheme(next_index) end; local function prev_colorscheme() local prev_index = current_index - 1; if prev_index < 1 then prev_index = #color_schemes end; set_colorscheme(prev_index) end; _G.next_colorscheme = next_colorscheme; _G.prev_colorscheme = prev_colorscheme; vim.api.nvim_set_keymap('n', '<F2>', '<Cmd>lua prev_colorscheme()<CR>', { noremap = true }); vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua next_colorscheme()<CR>', { noremap = true })
