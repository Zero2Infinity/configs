-- VIM Global settings

vim.g.deprecation_warnings = true       -- hide deprecation warnings
vim.g.trouble_lualine = true            -- show the current documen symbols location from Trouble in lualine

-- vim.g.markdown_recommended_style = 0 -- fix MD indentation settings

-- VIM Options
local opt = vim.opt

opt.autowrite = true                    -- Enable auto-write

opt.number = true                       -- enable line number
opt.relativenumber = true               -- enable relative line number

opt.colorcolumn = "80"                  -- set an 80 column border for good coding style
opt.tabstop = 4                         -- number of columns occupied by a tab
opt.shiftwidth = 4                      -- width of autoindents
opt.softtabstop = 4                     -- see multiple spaces as tabstops so <BS> does the right thing
opt.expandtab = true                    -- convert tabs to spaces
opt.smartindent = true                  -- Automatically indent new lines

opt.wrap = false                        -- disable line wrapping
opt.cursorline = true                   -- highlight the current line

opt.mouse = "r"                         -- help with copying + pasting text more easily
-- opt.mouse = "a"                      -- enable mouse mode (right-click)

opt.smartcase = true                    -- don't ignore case with capitals
opt.hlsearch = true                     -- highlight search
opt.incsearch = true                    -- incremental seach as user type

opt.syntax = "on"                       -- enable syntax highlighting

-- sync with system clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

opt.spelllang = { "en" }                -- enable spell check

opt.termguicolors = true                -- true color support

opt.undofile = true                     -- undo file even after reboot
opt.undolevels = 10000                  -- how many changes you can undo during a session
opt.updatetime = 200                    -- save swap file and trigger CursorHold

opt.wildmode = "longest:full,full"      -- command-line completion mode

opt.swapfile = false                    -- disable creating swap file

opt.backup = false                      -- enable backup before overwriting
opt.writebackup = true                  -- enable backup before writing a file    
opt.backupdir = "~/.config/nvim/backup" -- directory to store backup files
opt.backupext = ".bak"                  -- set the extension for backup files

