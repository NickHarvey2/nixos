{pkgs}: {
  enable = true;
  defaultEditor = true;
  plugins = with pkgs.vimPlugins; [
    # Note when converting from lazy.nvim:
    # lazy automatically calls require("plugin").setup(opts)
    # passing in the value of the opts table -- unless more
    # in depth config is required, in which case you can
    # a `config` function that will be called instead of the
    # automated initialization, within which you can call
    # the plugin's `setup` function manually, along with
    # any additional necessary calls to neovim's lua API

    # :Git <command>
    vim-fugitive
    vim-rhubarb

    # Attempt to automatically detect correct indentation
    # settings based on file content
    vim-sleuth

    # Plugin to help with md tables
    vim-table-mode
    
    # _Blazingly Fast_ navigation within a buffer
    {
      plugin = leap-nvim;
      type = "lua";
      config = builtins.readFile ./lua/leap.lua;
    }

    # Multi-cursor support -- commented out for now, seemed to cause performance issues
    # vim-visual-multi

    # Icons using Nerd Fonts
    nvim-web-devicons

    # Common dependency of many plugins
    plenary-nvim

    # Highlight other instances of word under cursor
    {
      plugin = vim-illuminate;
      type = "lua";
      config = builtins.readFile ./lua/illuminate.lua;
    }

    # additional targets for vim motions
    targets-vim

    # Treesitter
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile ./lua/treesitter.lua;
    }

    # LSP
    neodev-nvim
    omnisharp-extended-lsp-nvim
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = builtins.readFile ./lua/lspconfig.lua;
    }

    # Autocomplete, dependencies
    # snippet engine & its associated nvim-cmp source
    luasnip
    cmp_luasnip

    # adds lsp completion capabilities
    cmp-nvim-lsp

    # adds a number of user-friendly snippets
    friendly-snippets
    {
      plugin = nvim-cmp;
      type = "lua";
      config = builtins.readFile ./lua/cmp.lua;
    }
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = builtins.readFile ./lua/autopairs.lua;
    }

    {
      plugin = nvim-notify;
      type = "lua";
      config = builtins.readFile ./lua/notify.lua;
    }

    nvim-lsp-notify

    # Telescope, dependencies
    telescope-fzf-native-nvim
    {
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile ./lua/telescope.lua;
    }

    # Neotree, dependencies
    nui-nvim
    {
      plugin = nvim-window-picker;
      type = "lua";
      config = builtins.readFile ./lua/windowpicker.lua;
    }
    {
      plugin = neo-tree-nvim;
      type = "lua";
      config = builtins.readFile ./lua/neotree.lua;
    }

    # Bbye improves behavior of windows when used with Neotree
    {
      plugin = vim-bbye;
      type = "lua";
      config = builtins.readFile ./lua/bbye.lua;
    }

    # Lualine
    {
      plugin = lualine-nvim;
      type = "lua";
      config = builtins.readFile ./lua/lualine.lua;
    }

    {
      # Useful plugin to show you pending keybinds.
      plugin = which-key-nvim;
      type = "lua";
      config = builtins.readFile ./lua/whichkey.lua;
    }

    {
      # "gc" to comment visual regions/line
      # "gcc" to comment current line in normal mode
      plugin = comment-nvim;
      type = "lua";
      config = "require('Comment').setup()";
    }

    {
      # theme inspired by the atom
      plugin = onedark-nvim;
      type = "lua";
      config = ''
        require("onedark").setup({
          transparent = true
        })
        vim.cmd.colorscheme("onedark")
      '';
    }

    # indentation guides on blank lines
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config = "require('ibl').setup()";
    }

    {
      plugin = gitsigns-nvim;
      type = "lua";
      # See `:help gitsigns.txt`
      config = builtins.readFile ./lua/gitsigns.lua;
    }

    {
      plugin = zk-nvim;
      type = "lua";
      config = ''
        require("zk").setup({
          picker = "telescope"
        })
      '';
    }

    {
      plugin = gp-nvim;
      type = "lua";
      config = builtins.readFile ./lua/gp.lua;
    }
  ];
  extraLuaConfig = builtins.readFile ./lua/init.lua;
}
