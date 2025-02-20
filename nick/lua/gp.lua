vim.keymap.set('n', '<C-g><C-g>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-n>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })

local gp_is_setup = false
local chat_dir = vim.fn.getcwd() .. "/Chats"

local function load_gp()
  local n = Spinner.start('Loading', vim.log.levels.INFO, { title = 'gp.nvim' })
  local cmd = "sops -d $FLAKE_DIR/secrets/secrets.yaml | yq -r '.OPENAI_APIKEY'"
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      if gp_is_setup then return end
      if data[1] == '' then
        Spinner.stop(n, 'No API key found, plugin not loaded', vim.log.levels.WARN, {
          icon = Spinner.cancelled_icon,
        })
        return
      end
      gp_is_setup = true
      require("gp").setup({
        openai_api_key = data[1],
        chat_dir = chat_dir,
      })
      vim.keymap.set('n', '<C-g><C-g>', ':GpChatRespond<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-g><C-n>', ':GpChatNew<CR>', { noremap = true, silent = true })
      Spinner.stop(n, 'Loaded', vim.log.levels.INFO, {})
    end
  })
end

vim.defer_fn(function ()
  if vim.fn.system("ls -d " .. chat_dir):gsub("%s+", "") == chat_dir then
    load_gp()
  end
end, 0)
