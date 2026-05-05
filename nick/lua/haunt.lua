local haunt = require("haunt.api")
local haunt_picker = require("haunt.picker")
-- local haunt_sk = require("haunt.sidekick")

require('haunt').setup({
  sign = "",
  sign_hl = "DiagnosticInfo",
  virt_text_hl = "HauntAnnotation", -- links to DiagnosticVirtualTextHint
  annotation_prefix = " 󰆉 ",
  annotation_suffix = "",
  line_hl = nil,
  virt_text_pos = "eol",
  data_dir = nil,
  per_branch_bookmarks = true,
  picker = "auto", -- "auto", "snacks", "telescope", or "fzf"
  picker_keys = { -- picker agnostic, we got you covered
    delete = { key = "d", mode = { "n" } },
    edit_annotation = { key = "a", mode = { "n" } },
  },
})

vim.keymap.set('n', '<leader>aa', haunt.annotate, { buffer = bufnr, desc = 'Haunt [A]nnotation [A]dd/edit' })
vim.keymap.set('n', '<leader>ad', haunt.delete, { buffer = bufnr, desc = 'Haunt [A]nnotation [D]elete' })
vim.keymap.set('n', '<leader>ac', haunt.clear, { buffer = bufnr, desc = 'Haunt [A]nnotation [C]lear in buffer' })
vim.keymap.set('n', '<leader>aC', haunt.clear_all, { buffer = bufnr, desc = 'Haunt [A]nnotation [C]lear all' })
vim.keymap.set('n', '<leader>as', haunt_picker.show, { buffer = bufnr, desc = 'Haunt [A]nnotation [S]earch' })
vim.keymap.set('n', '<leader>aq', haunt.to_quickfix, { buffer = bufnr, desc = 'Haunt [A]nnotation send to [Q]uickfix' })
