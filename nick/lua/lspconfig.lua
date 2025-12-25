-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local on_attach = function(client, bufnr)
  -- function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  if client.config.name == 'omnisharp' then
    nmap('gd', require('omnisharp_extended').telescope_lsp_definition, '[G]oto [D]efinition')
    nmap('gr', require('omnisharp_extended').telescope_lsp_references, '[G]oto [R]eferences')
    nmap('gi', require('omnisharp_extended').telescope_lsp_implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', require('omnisharp_extended').telescope_lsp_type_definition, 'Type [D]efinition')
  else
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  end

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  if client.config.name == 'nixd' then
    -- Create a command `:Format` local to the LSP buffer, using Alejandra
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', ':%!alejandra -qq',
      { desc = 'Format current buffer with Alejandra' })
  else
    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup neovim lua configuration
-- TODO replace with [lazydev.nvim](https://github.com/folke/lazydev.nvim)
require('neodev').setup()

-- NOTE works, but not for neovim config until I do the above TODO
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TODO launches correctly, but doesn't actually provide any hints
vim.lsp.config('nixd', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('zk', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('omnisharp', {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TODO test
vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.enable({'lua_ls', 'nixd', 'gopls', 'zk', 'omnisharp', 'clangd'})
