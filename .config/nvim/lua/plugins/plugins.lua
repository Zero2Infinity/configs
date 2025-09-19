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
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- Basic keymap for finding files wiht telescope
            vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Fuzzy find files" })
        end
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
                      gc_details = ffalse,
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
                vim.opt.completeopt = { "menuone", "noselect", "popup", "preview", "noinsert", "longest" }
                vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true, })
                vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = "Trigger autocompletion" })

                local opts = { noremap=true, silent=true }
                -- Keybindings for LSP functions
                vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
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

    -- add more treesitter parsers
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',  -- Ensure parsers are updated
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "go", "python", "lua",  },  -- Ensure Go parser is installed
                highlight = {
                    enable = true,  -- Enable highlighting
                    additional_vim_regex_highlighting = false,  -- Disable Vim regex highlighting
                },
                indent = {
                   enable = true,  -- Enable indentation based on Treesitter
                },
                matchup = {
                   enable = true, -- Enable matching for brackets
                },
            }
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
    { "mason-org/mason-lspconfig.nvim", config = function() end }

}
