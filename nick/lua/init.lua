-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.scrolloff = 10

vim.wo.number = true
vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamed,unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.cmd('highlight CursorLine guibg=#30343c')
vim.opt.cursorline = true

-- Set highlight on search
vim.o.hlsearch = true

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.keymap.set('n', '<TAB>', '<S-v>><esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-TAB>', '<S-v><<esc>', { noremap = true, silent = true })
vim.keymap.set('v', '<TAB>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-TAB>', '<gv', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-W>|', ':vsplit<CR><C-W>l', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-W>-', ':split<CR>', { noremap = true })
vim.keymap.set('n', '<C-PageUp>', ':bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-PageDown>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-i>', ':b#<CR>', { noremap = true, silent = true })

-- keymap for getting back to normal mode in a terminal buffer
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-N>', { noremap = true, silent = true })

-- keymaps for wrapping selected text in various things
vim.keymap.set('v', '(', '<esc>`>a)<esc>`<i(<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '[', '<esc>`>a]<esc>`<i[<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '{', '<esc>`>a}<esc>`<i{<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '<', '<esc>`>a><esc>`<i<<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '"', '<esc>`>a"<esc>`<i"<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '_', '<esc>`>a_<esc>`<i_<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '*', '<esc>`>a*<esc>`<i*<esc>lv`>l', { noremap = true, silent = true })
-- `=` the reindent behavior is more important than wrapping
-- vim.keymap.set('v', '=', '<esc>`>a=<esc>`<i=<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '\'', '<esc>`>a\'<esc>`<i\'<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '~', '<esc>`>a~<esc>`<i~<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '`', '<esc>`>a`<esc>`<i`<esc>lv`>l', { noremap = true, silent = true })
vim.keymap.set('v', '<C-k>', '<esc>`<i[<esc>`>la]()<esc>h', { noremap = true, silent = true })

vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true, silent = true })
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakat = ' '
    vim.g.table_mode_syntax = 0
  end,
})
vim.api.nvim_set_hl(0, 'SpellBad', {bg='#550000', underline=true})

Sops = {
  -- Function to decrypt SOPS files
  decrypt = function()
    local format = vim.fn.expand('%:e')
    vim.cmd('silent %!sops -d --input-type ' .. format .. ' --output-type ' .. format .. ' /dev/stdin')
  end,

  -- Function to encrypt SOPS files
  encrypt = function()
    local format = vim.fn.expand('%:e')
    vim.cmd('silent %!sops -e --input-type ' .. format .. ' --output-type ' .. format .. ' /dev/stdin')
  end,
}

vim.api.nvim_create_augroup('sops_files', { clear = true })

vim.api.nvim_create_autocmd({'BufReadPost', 'BufWritePost'}, {
  group = 'sops_files',
  pattern = {'*/secrets/secrets.yaml', '*/secrets/secrets.json', '*/secrets/secrets.env', '*/secrets/secrets.ini'},
  callback = function() Sops.decrypt() end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'sops_files',
  pattern = {'*/secrets/secrets.yaml', '*/secrets/secrets.json', '*/secrets/secrets.env', '*/secrets/secrets.ini'},
  callback = function() Sops.encrypt() end,
})

vim.api.nvim_create_user_command('SetIndent', function(opts)
  local newIndent = tonumber(opts.args)
  if not newIndent then
    vim.notify("Could not parse argument '" .. opts.args .. "' as number", vim.log.levels.ERROR)
  else
    vim.o.sw = 0
    vim.o.ts = newIndent
    vim.o.et = true
    local indentStr = string.format("%" .. opts.args .. "s", "")
    pcall(vim.cmd, "%s/\t/" .. indentStr .. "/g")
    vim.notify("Indent set to " .. opts.args .. " (ts=" .. opts.args .. ",sw=0,et)")
  end
end, { desc = "", nargs = 1 })
