local jdtls = require('jdtls')

local config = {
  cmd = { vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls') },
  root_dir = vim.fs.dirname(vim.fs.find({'.git', 'mvnw', 'gradlew'}, { upward = true })),
}

jdtls.start_or_attach(config)
