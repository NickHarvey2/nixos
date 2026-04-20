local haunt = require("haunt.api")
local haunt_picker = require("haunt.picker")
local haunt_sk = require("haunt.sidekick")

vim.keymap.set('n', '<leader>aa', haunt.annotate, { buffer = bufnr, desc = 'Haunt [A]nnotation [A]dd/edit' })
vim.keymap.set('n', '<leader>ac', haunt.clear, { buffer = bufnr, desc = 'Haunt [A]nnotation [C]lear in buffer' })
vim.keymap.set('n', '<leader>aC', haunt.clear_all, { buffer = bufnr, desc = 'Haunt [A]nnotation [C]lear all' })
vim.keymap.set('n', '<leader>as', haunt_picker.show, { buffer = bufnr, desc = 'Haunt [A]nnotation [S]earch' })
vim.keymap.set('n', '<leader>aq', haunt.to_quickfix, { buffer = bufnr, desc = 'Haunt [A]nnotation send to [Q]uickfix' })
