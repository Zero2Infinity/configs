local map = vim.keymap.set

map('i', 'jj', '<Esc>')

map('n', '<leader>w', ':w<CR>', {noremap = true, silent = true}) 
map('n', '<leader>q', ':q<CR>', {noremap = true, silent = true}) 
