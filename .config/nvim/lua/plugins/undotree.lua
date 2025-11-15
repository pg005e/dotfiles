vim.g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
vim.g.undotree_CustomDiffpanelCmd = 'botright 10 new'

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
