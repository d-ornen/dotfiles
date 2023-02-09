require "lspconfig".cmake.setup{}
require "lspconfig".pyright.setup{}
require "lspconfig".ltex.setup{}
require "lspconfig".rust_analyzer.setup{}
require'lspconfig'.ocamllsp.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.ansiblels.setup{}

local luasnip = require'luasnip'
local lspconfig = require('lspconfig')
local cmp = require 'cmp'
local lspkind = require "lspkind"
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
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
-- Setup lspconfig.


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- enable nvim-cmp additionsl capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'cmake', 'ocamllsp', 'gopls'}
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
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
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}


vim.g.rainbow_active = 1
