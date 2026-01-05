-- ================================
-- Diagnostic sign icons (like lsp.set_preferences)
-- ================================
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ================================
-- nvim-cmp setup (same mappings)
-- ================================
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
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
  },
})

-- ================================
-- LSP capabilities + on_attach (same logic as lsp.on_attach)
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
-- This applies to *all* servers, and can be overridden per-server.
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
        globals = { 'vim' }, -- same as your lsp.configure("lua_ls", ...)
      },
    },
  },
})

-- If you ever want per-server tweaks for others:
-- vim.lsp.config('ts_ls', { settings = { ... } })
-- vim.lsp.config('rust_analyzer', { settings = { ... } })
-- vim.lsp.config('eslint', { settings = { ... } })

-- ================================
-- Mason + mason-lspconfig
-- ================================
require('mason').setup()

require('mason-lspconfig').setup({
  -- install the same servers you used with lsp.setup_servers
  ensure_installed = {
    'ts_ls',
    'eslint',
    'lua_ls',
    'rust_analyzer',
  },

  -- v2 of mason-lspconfig can automatically call vim.lsp.enable()
  -- for installed servers, so you usually don't need to manually
  -- call vim.lsp.enable() yourself.
  automatic_enable = true,
})

-- ================================
-- Diagnostics behavior
-- ================================
vim.diagnostic.config({
  virtual_text = true,
})
