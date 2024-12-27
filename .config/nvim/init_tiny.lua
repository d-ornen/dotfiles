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
-- vim.cmd "colorscheme molokai"

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

-- oneliner to iterate over colorschemes with f2, f3
local color_schemes = vim.fn.getcompletion('', 'color'); local current_index = 1; local function set_colorscheme(index) current_index = index; vim.cmd('colorscheme ' .. color_schemes[current_index]) end; local function next_colorscheme() local next_index = current_index + 1; if next_index > #color_schemes then next_index = 1 end; set_colorscheme(next_index) end; local function prev_colorscheme() local prev_index = current_index - 1; if prev_index < 1 then prev_index = #color_schemes end; set_colorscheme(prev_index) end; _G.next_colorscheme = next_colorscheme; _G.prev_colorscheme = prev_colorscheme; vim.api.nvim_set_keymap('n', '<F2>', '<Cmd>lua prev_colorscheme()<CR>', { noremap = true }); vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua next_colorscheme()<CR>', { noremap = true })
