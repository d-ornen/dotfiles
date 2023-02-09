vim.cmd "set path=$PWD/**" -- required for recursive search
vim.cmd "set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp" -- omit this during search
vim.cmd "command! Wq wq"
vim.cmd "set tabstop=2"
vim.cmd "set shiftwidth=2"
vim.cmd "set mouse="
vim.cmd "inoremap <M-p> <esc>:r!python -c 'print()'<left><left>"
vim.cmd "au FocusLost * silent! wa"
-- WRONG CONF vim.cmd [[set stl=%r%m|%n:%t%=l/c:%l/%c|%y"]]


