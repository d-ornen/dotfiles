vim.api.nvim_set_keymap('n', '<M-l>', '<cmd>bn<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>bp<cr>', {noremap=true})
vim.api.nvim_set_keymap('t', '<M-h>', '<C-\\><C-n><cmd>bp<cr>', {noremap=true})
vim.api.nvim_set_keymap('t', '<M-l>', '<C-\\><C-n><cmd>bn<cr>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<F1>', '<cmd>!cmake ../ -B . -DCMAKE_EXPORT_COMPILE_COMMANDS=1<cr>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<F3>', '<cmd>mak<cr>', {noremap=true})


