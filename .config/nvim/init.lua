require("config")

-- print("welcome back goose 🪿")
-- print("------------------------------------------")

-- make the colorscheme transparent
require("rose-pine").setup({
  variant = "auto",                 -- Choose between 'main', 'moon', or 'dawn'
  dark_variant = "main",
  disable_background = true,        -- Makes the background transparent
  disable_float_background = false, -- Makes floating windows transparent
  bold_vert_split = false,
  dim_nc_background = true,         -- Do not dim non-current window backgrounds
  disable_italics = false,
})

vim.opt.backspace = { "indent", "eol", "start" }

vim.cmd.colorscheme "rose-pine"
vim.g.netrw_bufsettings = 'noma nomod nobl nowrap ro'
-- vim.o.cursorline = true
vim.o.termguicolors = true
vim.g.netrw_banner = 0
