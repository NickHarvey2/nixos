local zk = require("zk")
local commands = require("zk.commands")

zk.setup({
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

vim.api.nvim_create_user_command('ZkNewFromTitle', function(opts)
  generate_zk_new({cmd='ZkNew {title="' .. opts.args .. '", '})
end, { desc = "Supply title, path, and template for a new zk note", nargs = 1 })

local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

vim.keymap.set('n', '<leader>zb', ":ZkBacklinks<CR>", { desc = '[Z]k [B]acklinks' })
vim.keymap.set('n', '<leader>zl', ":ZkLinks<CR>", { desc = '[Z]k [L]inks' })
vim.keymap.set('n', '<leader>zo', ":ZkOrphans<CR>", { desc = '[Z]k List [O]rphaned Notes' })
vim.keymap.set('n', '<leader>zn', ":ZkNotes<CR>", { desc = '[Z]k List [N]otes' })
vim.keymap.set('v', '<leader>zn', ":'<,'>ZkMatch<CR>", { desc = '[Z]k List [N]otes matching selection' })
vim.keymap.set('n', '<leader>zc', ":ZkNewFromTitle ", { desc = '[Z]k [C]reate' })
vim.keymap.set('v', '<leader>zc', generate_zk_new({cmd="'<,'>ZkNewFromTitleSelection {"}), { desc = '[Z]k [C]reate with selection as title' })

