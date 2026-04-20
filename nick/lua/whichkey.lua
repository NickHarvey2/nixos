require("which-key").setup()

require('which-key').add {
  {'<leader>f', group = 'Quick [F]ix'},
  {'<leader>c', group = '[C]ode'},
  {'<leader>d', group = '[D]ocument'},
  {'<leader>g', group = '[G]it'},
  {'<leader>h', group = 'More git'},
  {'<leader>r', group = '[R]ename'},
  {'<leader>s', group = '[S]earch'},
  {'<leader>w', group = '[W]orkspace'},
  {'<leader>b', group = '[B]uffer'},
  {'<leader>t', group = '[T]able'},
  {'<leader>a', group = 'Haunt [A]nnotation'},
}
