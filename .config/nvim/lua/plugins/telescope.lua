-- all the 'plugins' in the /lua/plugins/ directory is a configuration of plugins
-- the installation is done in the /lua/config/lazy.lua

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<C-g>', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Grep search with live preview' })


