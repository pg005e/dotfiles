local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    markdown = { "prettier" },
  },
})

vim.keymap.set('n', '<leader>f', function()
  conform.format({
    lsp_fallback = true,
    async = false,
  })
end, { desc = "Format with conform" })
