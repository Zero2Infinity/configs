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
-- {i}gt	Go to the tab number {i} (e.g., 2gt goes to the 2nd tab).
-- g<Tab>	Go to the last accessed tab (very useful for toggling).
-- CTRL-W T	Move current window to a new tab (Native Neovim).
-- CTRL-W c: Closes the current window. If it’s the last window in the tab, the tab closes.
-- CTRL-W o: "Only" – Closes all other windows in the current tab, but does not close other tabs.
vim.keymap.set("n", "<A-j>", "gT", { desc = "Prev tab" })
vim.keymap.set("n", "<A-k>", "gt", { desc = "Next tab" })
