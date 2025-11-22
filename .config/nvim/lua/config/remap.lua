vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>b", function()
  print(vim.fn.bufnr('%'))
end, { desc = "Print current buffer number" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }
    keymap.set("n", "<C-L>", "<C-I>")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    keymap.set("n", "gd", "<C-w><C-]>", { buffer = true })
  end
})

keymap.set("n", "<leader>l", function()
  local currentLine = vim.api.nvim_get_current_line()
  local lineLength = vim.fn.strcharlen(currentLine)
  local lineNum = vim.fn.line(".")
  local colPos = vim.fn.virtcol(".")
  vim.fn.cursor(lineNum + 1, colPos)
  local command = string.format("normal! %di-", lineLength + 1)
  vim.fn.execute(command)
  vim.fn.execute("normal! i\r")
  vim.fn.execute("normal! el\"_d0")
end)

keymap.set("n", "<leader>c", ":lcd %:p:h", {
  desc = "change dir of current window to current active buffer directory"
})

keymap.set("i", "<C-BS>", "<C-w>")
keymap.set("c", "<C-BS>", "<C-w>")
keymap.set("i", "<C-H>", "<C-w>")
keymap.set("c", "<C-H>", "<C-w>")

keymap.set("n", "<leader>pw", vim.cmd.Ex)
keymap.set("n", "<leader>r", vim.cmd.registers)
keymap.set("n", "<leader>m", vim.cmd.marks)

keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "<C-w>e", "<C-w>|<C-w>_")
keymap.set("n", "<Tab>o", "<C-w>o")
keymap.set("n", "<Tab>=", "<C-w>=")
keymap.set("n", "<Tab>q", "<C-w>q")
keymap.set("n", "<Tab><Tab>", "<C-w><C-w>")
keymap.set("n", "<Tab>|", "<C-w>T")
keymap.set("n", "<Tab>H", "<C-w>H")
keymap.set("n", "<Tab>J", "<C-w>J")
keymap.set("n", "<Tab>K", "<C-w>K")
keymap.set("n", "<Tab>L", "<C-w>L")
keymap.set("n", "<Tab>h", "<C-w>h")
keymap.set("n", "<Tab>j", "<C-w>j")
keymap.set("n", "<Tab>k", "<C-w>k")
keymap.set("n", "<Tab>l", "<C-w>l")
keymap.set("n", "<Tab>\\", "<C-w>v")
keymap.set("n", "<Tab>-", "<C-w>s")

keymap.set("n", "<Tab>n", ":tabnew")
keymap.set("n", "<Tab>e", ":Texplore")
keymap.set("n", "<Tab>]", "gt")
keymap.set("n", "<Tab>[", "gT")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ1`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", "\"_dP")

keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

keymap.set("n", "<leader>d", "\"_d")
keymap.set("v", "<leader>d", "\"_d")
keymap.set("n", "<leader>D", "\"_D")
