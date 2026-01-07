return {
    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", 
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            local cmp_mappings = {
                ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>']     = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }

            -- disable Tab / S-Tab completion like before
            cmp_mappings['<Tab>']   = nil
            cmp_mappings['<S-Tab>'] = nil

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp_mappings,
                sources = cmp.config.sources({
                    { name = 'copilot', group_index = 2 },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'cmdline' },
                }),
            })
        end,
    },

    -- LSP Core
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "j-hui/fidget.nvim",
        },
        config = function()
            -- ================================
            -- Diagnostic sign icons (like lsp.set_preferences)
            -- ================================
            local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- ================================
            -- LSP capabilities + on_attach
            -- ================================
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                -- keep your eslint special-case
                if client.name == "eslint" then
                    vim.cmd.LspStop('eslint')
                    return
                end

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end

            -- ================================
            -- Global LSP defaults
            -- ================================
            vim.lsp.config('*', {
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- ================================
            -- Server-specific config (lua_ls)
            -- ================================
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })

            -- ================================
            -- Diagnostics behavior
            -- ================================
            vim.diagnostic.config({
                virtual_text = true,
            })
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("fidget").setup({})
            require('mason').setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'ts_ls',
                    'lua_ls',
                    'rust_analyzer',
                },
                automatic_enable = true,
            })
        end,
    },
}
