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

local gp_models_json = '<GP_MODELS_JSON>'

local function load_gp_agents()
  local ok, models_data = pcall(vim.fn.json_decode, gp_models_json)
  if not ok then
    return {}
  end

  local agents = {}
  for _, m in ipairs(models_data) do
    table.insert(agents, {
      provider = "llama_cpp",
      name = m.name,
      chat = true,
      command = false,
      model = {
        model = m.model_id,
        temperature = m.temperature or 1.0,
        top_p = m.top_p or 1.0,
      },
      system_prompt = system_prompt,
    })
  end
  return agents
end

require("gp").setup({
  chat_dir = vim.fn.getcwd() .. "/Chats",
  providers = {
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
  agents = load_gp_agents(),
})

vim.keymap.set('n', '<C-g>n', function()
  vim.cmd('GpChatNew')
  vim.schedule(function()
    vim.cmd('normal! G')
    vim.wo.conceallevel = 0
  end)
end, { noremap = true, silent = true })

vim.keymap.set({'n', 'i'}, '<C-g><C-g>', ':GpChatRespond<CR>', { noremap = true, silent = true })
