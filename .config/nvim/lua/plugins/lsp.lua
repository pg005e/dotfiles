-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- add cmp_nvim_lsp capabilities settings to lspconfig
-- this should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- this is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('lspattach', {
  desc = 'lsp actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gh', '<cmd>split | lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<f3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<f4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "bashls",
    "clangd",
    "marksman",
    "ts_ls",
    "yamlls",
    -- "eslint",
    "docker_compose_language_service",
    "dockerls",
    "gopls"
  },
  automatic_installation = false,
})

-- languge servers
require('lspconfig').lua_ls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').ts_ls.setup({})
-- require('lspconfig').eslint.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').marksman.setup({})
require('lspconfig').docker_compose_language_service.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').yamlls.setup({})

require("lspconfig").rust_analyzer.setup({
  -- cmd = { "rust_analyzer" },  -- use light (from mason)
  cmd = { "/usr/bin/rust-analyzer" }, -- use pacman-installed binary (install in rust toolchain)
  on_attach = function(client, bufnr)
    print("rust-analyzer attached")
  end,
})

require("lspconfig").gopls.setup({})


local pid = vim.fn.getpid()
require("lspconfig").omnisharp.setup({
  cmd = {
    vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp", -- capital O
    "--languageserver",
    "--hostPID",
    tostring(pid),
  },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  on_attach = function(client, bufnr)
    print("omnisharp attached to buffer " .. bufnr)
  end,
})

local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      require('luasnip').lsp_expand(args.body)
      -- vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
})
