require("config")

-- print("---------------------")
-- print("welcome back goose")
-- print("let's get started with this programming sesh")
-- print("---------------------------------------------")

-- make the colorscheme transparent
require("rose-pine").setup({
  variant = "auto", -- Choose between 'main', 'moon', or 'dawn'
  dark_variant = "main",
  disable_background = true, -- Makes the background transparent
  disable_float_background = false, -- Makes floating windows transparent
  bold_vert_split = false,
  dim_nc_background = true, -- Do not dim non-current window backgrounds
  disable_italics = false,
})

vim.cmd.colorscheme "rose-pine-moon"
vim.g.netrw_bufsettings = 'noma nomod nobl nowrap ro'
vim.o.cursorline = true


