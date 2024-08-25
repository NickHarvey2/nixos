vim.keymap.set('n', '<C-\\>', ':Neotree last<CR>', { noremap = true, silent = true })

require('neo-tree').setup({
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = false } },
    }
  },
  source_selector = {
    winbar = true,
  },
  close_if_last_window = false,
  enable_git_status = true,
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.opt_local.relativenumber = true
      end,
    }
  },
  open_files_do_not_replace_types = { --[[ 'terminal', ]] 'trouble', 'qf' },
  sort_case_insensitive = true,
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = 'NeoTreeFileName',
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    window = {
      mappings = {
        ['<bs>'] = false,
      }
    }
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    window = {
      mappings = {
        ['<bs>'] = false,
      }
    }
  },
})
