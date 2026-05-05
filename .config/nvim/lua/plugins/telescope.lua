-- all the 'plugins' in the /lua/plugins/ directory is a configuration of plugins
-- the installation is done in the /lua/config/lazy.lua

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>pc', builtin.colorscheme, { desc = 'Telescope colorscheme' })
vim.keymap.set('n', '<C-g>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Grep search with live preview' })

vim.keymap.set('n', '<leader>pt', function()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  local tabs = vim.api.nvim_list_tabpages()
  local tab_names = {}

  for _, tab in ipairs(tabs) do
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    table.insert(tab_names, name ~= "" and name or "[No Name]")
  end

  pickers.new({}, {
    prompt_title = "Tabs",
    finder = finders.new_table {
      results = tab_names,
    },
    sorter = conf.generic_sorter({}),
  }):find()
end, { desc = 'Telescope tabs' })
