vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function (args)
    vim.wo.cursorline = false
  end
})

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 69

vim.opt.wrap = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

-- wayland system clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = true,
}

-- xclip system clipboard
-- vim.g.clipboard = {
--   name = "xclip",
--   copy = {
--     ["+"] = "xclip -selection clipboard",
--     ["*"] = "xclip -selection clipboard",
--   },
--   paste = {
--     ["+"] = "xclip -selection clipboard -o",
--     ["*"] = "xclip -selection primary -o",
--   },
--   cache_enabled = true,
-- }
-- }

