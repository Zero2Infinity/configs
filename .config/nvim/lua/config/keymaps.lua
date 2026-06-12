local map = vim.keymap.set

map('i', 'jj', '<Esc>')

map('n', '<leader>w', ':w<CR>', {noremap = true, silent = true}) 
map('n', '<leader>ww', ':wa<CR>', {noremap = true, silent = true})
map('n', '<leader>q', ':q<CR>', {noremap = true, silent = true}) 
map('n', '<leader>qq', ':qa!<CR>', {noremap = true, silent = true})

-- Move between windows using Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- Move to next/prev tab with Alt+j/k
-- gT = Go Tab (Previous)
-- gt = Go Tab (Next)
vim.keymap.set("n", "<A-j>", "gT", { desc = "Prev tab" })
vim.keymap.set("n", "<A-k>", "gt", { desc = "Next tab" })

-- Map Alt + 1-9 to go to tab 1-9
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt', { desc = 'Goto tab ' .. i })
end

