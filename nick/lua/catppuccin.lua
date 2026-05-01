require("catppuccin").setup({
  flavour = "frappe",             -- latte, frappe, macchiato, mocha
  transparent_background = true,
  integrations = {
    lualine = true,
  }
})
vim.cmd.colorscheme("catppuccin-frappe")
vim.api.nvim_set_hl(0, 'Visual', { bg = '#56b6c2', fg = '#000000' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a5adce' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#a5adce' })
