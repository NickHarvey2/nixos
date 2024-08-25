require("gitsigns").setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    if string.match(vim.api.nvim_buf_get_name(bufnr),"secrets/secrets.yaml") ~= nil or string.match(vim.api.nvim_buf_get_name(bufnr),"secrets/secrets.json") ~= nil or string.match(vim.api.nvim_buf_get_name(bufnr),"secrets/secrets.ini") ~= nil or string.match(vim.api.nvim_buf_get_name(bufnr),"secrets/secrets.env") ~= nil then
      return false -- do not attach
    end
    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
      { buffer = bufnr, desc = 'Preview git hunk' })
    vim.keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk,
      { buffer = bufnr, desc = 'Stage git hunk' })
    vim.keymap.set('n', '<leader>hr', require('gitsigns').reset_hunk,
      { buffer = bufnr, desc = 'Reset git hunk' })
    vim.keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk,
      { buffer = bufnr, desc = 'Undo stage git hunk' })

    vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer,
      { buffer = bufnr, desc = 'Stage git buffer' })
    vim.keymap.set('n', '<leader>hR', require('gitsigns').reset_buffer,
      { buffer = bufnr, desc = 'Reset git buffer' })

    vim.keymap.set('n', '<leader>hd', require('gitsigns').toggle_deleted,
      { buffer = bufnr, desc = 'Toggle deleted lines' })
    vim.keymap.set('n', '<leader>hq', function()
      require('gitsigns').setqflist('all')
    end, { buffer = bufnr, desc = 'List hunks in quick fix' })

    -- don't override the built-in and fugitive keymaps
    local gs = package.loaded.gitsigns

    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk in current buffer' })

    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk in current buffer' })

  end,
})
