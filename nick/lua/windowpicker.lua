require("window-picker").setup({
  filter_rules = {
    include_current_win = false,
    autoselect_one = true,
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal', 'quickfix' },
    },
  },
})
