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
        chat_topic_gen_model = "gpt-3.5-turbo-16k",
        chat_shortcut_respond = nil,
        chat_shortcut_delete = nil,
        chat_shortcut_new = nil,
        chat_conceal_model_params = false,
        agents = {
          {
            name = "ChatGPT4o",
            chat = true,
            command = false,
            model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
            system_prompt = "Task: You are an expert in providing precise and concise answers. For each question, ensure your response is direct and to the point. Avoid adding any unnecessary details or explanations. Here are some guidelines and examples to follow:\n\n"
              .. "Guidelines:\n"
              .. "- Be concise: Provide only the information necessary to answer the question, but do not elide necessary information.\n"
              .. "- Be clear: Make sure the answer is easy to understand and unambiguous.\n"
              .. "- Be relevant: Stick strictly to the question asked.\n"
              .. "- Understand the question: Ask questions if you need clarification to provide a more accurate answer.\n\n"
              .. "Examples of good and bad responses:\n"
              .. "Q: Who is the president of the United States currently in 2024?\n"
              .. "Good response: Joe Biden\n"
              .. "Bad response (is not concise): The current President, at the time of writing, is Joe Biden, who has been serving since January 20, 2021, following the 2020 election where he...\n\n"
              .. "Q: What is the capital of France?\n"
              .. "Good response: Paris\n"
              .. "Bad response (is not concise): The capital of France is Paris, a city known for its rich history, culture, and landmarks such as the Eiffel Tower and the Louvre Museum...\n\n"
              .. "Q: What is GPT?\n"
              .. "Good response: GPT is an acronym that can mean several things, for example: Generative Pre-trained Transformer, GUID Partition Table, Generalized Probabalistic Theory, Glutamate Pyruvate Transaminase. Please clarify which meaning you are referring to.\n"
              .. "Bad response (is not concise and does not ask appropriate clarifying questions): Generative pre-trained transformers (GPT) are a type of large language model (LLM) and a prominent framework for generative artificial intelligence. They are artificial neural networks that are used in natural language processing tasks. GPTs are based on the transformer architecture ...\n\n"
              .. "Negative instructions:\n"
              .. "- Do not make assumptions or answer without asking clarifying questions if you are unsure.\n"
              .. "- Do not have long prompt responses.\n"
              .. "- Avoid providing additional context or background information unless specifically requested.\n"
              .. "- Do not elaborate beyond the core answer unless specifically requested.\n"
          }
        }
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
