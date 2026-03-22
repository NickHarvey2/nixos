vim.keymap.set('n', '<C-g><C-g>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-n>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })

local chat_dir = vim.fn.getcwd() .. "/Chats"

require("gp").setup({
  chat_dir = chat_dir,
  providers = {
    openai = {
      disable = false,
      endpoint = "https://api.openai.com/v1/chat/completions",
      secret = {
        "bash",
        "-c",
        "sops -d $FLAKE_DIR/secrets/secrets.yaml | yq -r '.OPENAI_APIKEY'"
      }
    },
    openai_vu = {
      disable = false,
      endpoint = "https://us.api.openai.com/v1/chat/completions",
      secret = {
        "bash",
        "-c",
        "sops -d $FLAKE_DIR/secrets/secrets.yaml | yq -r '.VU_OPENAI_APIKEY'"
      }
    },
    llama_cpp = {
      disable = false,
      endpoint = "http://127.0.0.1:8080/v1/chat/completions",
      secret = '', -- gp.nvim doesn't like when this is set to nil, so make it an empty string
    },
  },
  agents = {
    {
      provider = "openai",
      name = "ChatGPT5.2",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-5.2", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
    {
      provider = "openai_vu",
      name = "ChatGPT5.2 - VU",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-5.2", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - Qwen3-Coder-Next",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "Qwen3-Coder-Next", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - gpt-oss-20b",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-oss-20b", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
  }
})
vim.keymap.set('n', '<C-g><C-g>', ':GpChatRespond<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-n>', ':GpChatNew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-a>', ':GpNextAgent<CR>', { noremap = true, silent = true })
