return {
    -- change trouble config
    {
        "folke/trouble.nvim",
        -- opts will be merged with the parent spec
        opts = { use_diagnostic_signs = true },
    },

    -- add gruvbox theme
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            local gb = require('gruvbox')
            gb.setup({
              terminal_colors = true,    -- add neovim terminal colors
              undercurl = true,
              underline = true,
              bold = false,
              italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
              },
              strikethrough = true,
              invert_selection = false,
              invert_signs = false,
              invert_tabline = false,
              invert_intend_guides = false,
              inverse = true,            -- invert background for search, diffs, statuslines and errors
              contrast = "",             -- can be "hard", "soft" or empty string
              palette_overrides = {},
              overrides = {},
              dim_inactive = false,
              transparent_mode = false,
            })
            
            -- Set background mode
            vim.o.background = "dark"  -- or "light" for light mode
            -- Apply the colorscheme
            vim.cmd("colorscheme gruvbox")
        end,
    },    

    -- telescope: fuzzy file finds
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        -- Use 'keys' for the best performance (lazy loading)
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
            { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Search String under cursor" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        },
        config = function()
            local ts = require("telescope")
            local actions = require("telescope.actions")
            local layout = require("telescope.actions.layout")

            ts.setup({
                defaults = {
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_selected_to_qflist + require("telescope.actions").open_qflist,
                            ["<M-l>"] = layout.cycle_layout_next, -- Press Alt + L to swap layouts
                        },
                    },
                },
            })

            -- Load the fzf extension
            ts.load_extension("fzf")
        end,
    },

    -- Neo-tree.nvim (the feature rich tree)
    -- <CR> (Enter)	Open file in the current window (Buffer).
    -- Ctrl-t	Open file in a new Neovim Tab.
    -- Ctrl-v	Open file in a Vertical Split.
    -- Ctrl-x	Open file in a Horizontal Split.
    -- <Tab>	Open file in Preview mode (opens buffer but keeps focus in the tree).
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        keys = {
            -- Set a keymap to toggle the tree
            { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
        }, 
        config = function()
            local nt = require("nvim-tree")
            nt.setup({
                view = {
                    width = 30,
                    side = "left",
                },
            })
        end,
    },
    
    -- add none-ls is an active community fork of null-ls
    {
		"nvimtools/none-ls.nvim", 
		opts = function(_, opts)
			local nls = require('null-ls')
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
			})
			return opts
		end,
	},
   
    -- add LSPs - gopls
    {
        'neovim/nvim-lspconfig',
        dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
        vim.lsp.config('go', {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gosum" },
            root_markers = { "go.mod", ".git" }, -- root dir detection
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                  gofumpt = true,
                  codelenses = {
                      gc_details = false,
                      generate = true,
                      regenerate_cgo = true,
                      run_govulncheck = true,
                      test = true,
                      tidy = true,
                      upgrade_dependency = true,
                      vendor = true,
                  },
                  hints = {
                      assignVariableTypes = true,
                      compositeLiteralFields = true,
                      compositeLiteralTypes = true,
                      constantValues = true,
                      functionTypeParameters = true,
                      parameterNames = true,
                      rangeVariableTypes = true,
                  },
                  analyses = {
                      nilness = true,
                      unusedparams = true,
                      unusedwrite = true,
                      useany = true,
                      unreachable = true,
                  },
                  usePlaceholders = true,
                  completeUnimported = true,
                  staticcheck = true,
                  directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                  semanticTokens = true,
                },
            },
            on_attach = function(client, bufnr)
                -- diagnostic config
                vim.diagnostic.config({ virtual_text = true })

                -- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
                vim.opt.completeopt = { "menuone", "noselect", "popup", "preview"}
                vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true, })
                vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = "Trigger autocompletion" })

                local opts = { noremap=true, silent=true }
                -- Keybindings for LSP functions
                vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                -- Go back to return to your caller using the tag stack
                vim.api.nvim_set_keymap('n', 'gb', '<cmd>tag<CR>', opts)

                vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

                -- Rename symbol
                vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                -- Code actions (Quick fixes)
                vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
                vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
                vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)

                -- Keybinding to clear highlights manually
                vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>noh<CR>', opts)
            end,
        }),

        vim.lsp.enable('go')
    },

    -- Add more treesitter parsers (Lazy.nvim format)
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',  -- Fix: Lazy uses 'build', Packer uses 'run'
        config = function()
            -- Fix: Use modern top-level setup for Neovim 0.12
            require('nvim-treesitter').setup {
                ensure_installed = {
                  "go",
                  "python",
                  "lua",
                  "vim",
                  "vimdoc",
                  "query",
                },
                 indent = {
                    enable = true,
                 },
             }

            -- nvim-treesitter (main) no longer ships a highlight module, so treesitter
            -- parsing works but highlighting never starts -> buffers fall back to the
            -- legacy go.vim syntax. Start it explicitly per filetype.
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
         end,
    },

    {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufNewFile" }, -- Forces it to load when you open a file
      config = function()
        require("illuminate").configure({
          delay = 100, -- delay in milliseconds before highlighting
          providers = {
              "lsp",
              "treesitter",
              "regex",
          },
        })

        local hl_opts = { bg = "NONE", underline = true, bold = true }
        vim.api.nvim_set_hl(0, "IlluminatedWordText", hl_opts)
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", hl_opts)
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", hl_opts)
        
      end,
    },

    -- or you can return new options to override all the defaults
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require('lualine').setup {
                options = {
                    section_separators = { '|' },
                    component_separators = { '|' },
                }, 
            }
         end,
    },

    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "flake8",
            "goimports",
            "gofumpt",
            "gomodifytags",
            "impl",
            "delve",
          },
        },
    },

    -- add mason managed lspconfig
    { "mason-org/mason-lspconfig.nvim", config = function() end },

    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },


}

