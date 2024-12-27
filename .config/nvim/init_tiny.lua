-- convert all buffers to tabs
vim.g.loaded_matchparen = 1


--Set nvim options
vim.o.mouse = ""
vim.o.colorcolumn = "80"
vim.o.wildmenu=true
vim.o.termguicolors=true
vim.o.background='dark'
vim.o.relativenumber = true
vim.o.foldenable = true
vim.o.foldmethod = 'manual'
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

--Set look & feel
vim.cmd "colorscheme elflord"

--Set misc
vim.api.nvim_exec([[
  au FocusLost * silent! wa
]], false)
vim.cmd "command! Wq wq"

--Set keymaps
local opts = { noremap=true, silent=true }
-- how do we move tabs
vim.api.nvim_set_keymap('n', 'M-l', '<cmd>tabnext<cr>', opts)
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>tabprev<cr>', opts)
vim.api.nvim_set_keymap('n', '<S-M-l>', '<cmd>+tabmove<cr>', opts)
vim.api.nvim_set_keymap('n', '<S-M-h>', '<cmd>-tabmove<cr>', opts)

vim.api.nvim_set_keymap('t', '<M-h>', '<cmd>tabprev<cr>', opts)
vim.api.nvim_set_keymap('t', '<M-l>', '<cmd>tabnext<cr>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<esc>o', opts)

vim.api.nvim_set_keymap('n', '<M-h>', '<esc>hi', opts)
vim.api.nvim_set_keymap('n', '<M-j>', '<esc>ji', opts)
vim.api.nvim_set_keymap('n', '<M-k>', '<esc>ki', opts)
vim.api.nvim_set_keymap('n', '<M-l>', '<esc>li', opts)


local t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end





-- oneliner to iterate over colorschemes with f2, f3
local color_schemes = vim.fn.getcompletion('', 'color'); local current_index = 1; local function set_colorscheme(index) current_index = index; vim.cmd('colorscheme ' .. color_schemes[current_index]) end; local function next_colorscheme() local next_index = current_index + 1; if next_index > #color_schemes then next_index = 1 end; set_colorscheme(next_index) end; local function prev_colorscheme() local prev_index = current_index - 1; if prev_index < 1 then prev_index = #color_schemes end; set_colorscheme(prev_index) end; _G.next_colorscheme = next_colorscheme; _G.prev_colorscheme = prev_colorscheme; vim.api.nvim_set_keymap('n', '<F2>', '<Cmd>lua prev_colorscheme()<CR>', { noremap = true }); vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua next_colorscheme()<CR>', { noremap = true })
