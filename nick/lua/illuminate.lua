require('illuminate').configure({
  filetypes_denylist = {
    'dirbuf',
    'dirvish',
    'fugitive',
    'neo-tree',
    'git',
    'markdown',
    'yaml'
  },
})
