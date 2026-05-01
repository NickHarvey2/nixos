vim.keymap.set('n', '<C-g><C-g>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-n>',
  ":lua vim.notify('Plugin not loaded, use :LoadGp to load it', vim.log.levels.ERROR, { title = 'gp.nvim' })<CR>",
  { noremap = true, silent = true })

local chat_dir = vim.fn.getcwd() .. "/Chats"

local system_prompt = 
"You are a general AI assistant.\n\n" ..
"The user provided the additional info about how they would like you to respond:\n\n" ..
"- If you're unsure don't guess and say you don't know instead.\n" ..
"- Ask question if you need clarification to provide better answer.\n" ..
"- Think deeply and carefully from first principles step by step.\n" ..
"- Avoid repeating yourself, and try to keep answers concise, without eliding important details.\n" ..
"- Zoom out first to see the big picture and then zoom in to details.\n" ..
"- Don't elide any code from your output if the answer requires coding.\n" ..
"- Take a deep breath; You've got this!"

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
      system_prompt = system_prompt,
    },
    {
      provider = "openai_vu",
      name = "ChatGPT5.2 - VU",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-5.2", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - Qwen3-Coder-Next",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "Qwen3-Coder-Next", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - gpt-oss-20b",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-oss-20b", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - Qwen3.5-35B-A3B",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "Qwen3.5-35B-A3B", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - DeepSeek-R1-Distill-Llama-70B",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "DeepSeek-R1-Distill-Llama-70B", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = system_prompt,
    },
    {
      provider = "llama_cpp",
      name = "llama.cpp - gemma-4-31B-it",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gemma-4-31B-it", temperature = 1.0, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
  }
})
vim.keymap.set('n', '<C-g><C-g>', ':GpChatRespond<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-n>', ':GpChatNew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g><C-a>', ':GpNextAgent<CR>', { noremap = true, silent = true })
