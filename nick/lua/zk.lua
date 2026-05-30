require("zk").setup({
  picker = "telescope"
})

local picker_opts = require('telescope.themes').get_dropdown {
  winblend = 10,
  previewer = false,
}

local format_dirs_to_entries = function(str)
  local lines = {}
  for line in str:gmatch("[^\n]+") do
    line = line:gsub('^.*' .. vim.fn.getcwd(), '.')
    table.insert(lines, line)
  end
  return lines
end

local format_templates_to_entries = function(str)
  local lines = {}
  for line in str:gmatch("[^\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local generate_template_selection_handler = function(args)
  return function(template)
    vim.cmd(args.cmd .. 'template="' .. template[1] .. '", dir="' .. args.selected_dir .. '"}')
  end
end

local generate_template_list_handler = function(args)
  return function(obj)
    vim.defer_fn(function()
      Pick_From({
        prompt = 'Select a template',
        entries = format_templates_to_entries(obj.stdout),
        callback = generate_template_selection_handler({selected_dir=args.selected_dir, cmd=args.cmd})
      }, picker_opts)
    end, 0)
  end
end

local generate_dir_selection_handler = function(args)
  return function(dir)
    vim.system(
      { 'exa', './.zk/templates', '-1f', '--no-quotes' },
      { text = true },
      generate_template_list_handler({selected_dir=dir[1], cmd=args.cmd}))
  end
end

local generate_dir_list_handler = function(args)
  return function(obj)
    vim.defer_fn(function()
      local dirs = format_dirs_to_entries(obj.stdout)
      Pick_From({
        prompt = 'Select a directory',
        entries = dirs,
        callback = generate_dir_selection_handler({cmd=args.cmd})
      }, picker_opts)
    end, 0)
  end
end

local generate_zk_new = function(args)
  return function()
    vim.system(
      { 'exa', '.', '-DT', '--absolute', '--no-quotes' },
      { text = true },
      generate_dir_list_handler({cmd=args.cmd})
    )
  end
end

vim.keymap.set('n', '<leader>zn', ':ZkNewFromTitle ', { desc = '[Z]k [N]ew' })
vim.keymap.set('v', '<leader>zn', generate_zk_new({cmd="'<,'>ZkNewFromTitleSelection {"}), { desc = '[Z]k [N]ew with selection as title' })

vim.api.nvim_create_user_command('ZkNewFromTitle', function(opts)
  generate_zk_new({cmd='ZkNew {title="' .. opts.args .. '", '})
end, { desc = "Supply title, path, and template for a new zk note", nargs = 1 })
