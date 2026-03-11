{
  inputs,
  pkgs,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
  leadrConfig = {
    leadr_key = "<C-g>";
    redraw_prompt_line = true;
    panel.enabled = true;
    panel.delay_ms = 500;
    panel.fail_silently = true;
    panel.theme_name = "catppuccin-frappe";
    panel.layout.border_type = "Rounded";
    panel.layout.height = 10;
    panel.layout.padding = 2;
    panel.layout.columns.width = 40;
    panel.layout.columns.spacing = 5;
    panel.layout.columns.centred = false;
    panel.layout.symbols.append = "󰌒";
    panel.layout.symbols.arrow = "→";
    panel.layout.symbols.evaluate = "󰊕";
    panel.layout.symbols.execute = "󰌑";
    panel.layout.symbols.insert = "";
    panel.layout.symbols.prepend = "⇤";
    panel.layout.symbols.replace = " ";
    panel.layout.symbols.sequence_begin = "󰄾";
    panel.layout.symbols.surround = "󰅪";
  };
  leadrMappings = {
    id = {
      command = "date +%Y%m%d";
      description = "Insert current date in YYYYMMDD format";
      insert_type = "Insert";
      evaluate = true;
    };

    sb = {
      command = "'#CURSOR`#COMMAND`'";
      description = "Surround with backticks";
      insert_type = "Surround";
    };

    sq = {
      command = "\"#COMMAND\"";
      description = "Surround with quotes";
      insert_type = "Surround";
    };

    sl = {
      command = "IFS=$'\\n' read -rd '' -A #CURSOR <<< $(#COMMAND)";
      description = "read in command as a newline delimited list";
      insert_type = "Surround";
    };

    ay = {
      command = " | wl-copy";
      description = "Append copy to clipboard";
      insert_type = "Append";
    };

    yx = {
      command = "echo -n '' | wl-copy";
      description = "Clear the clipboard";
      execute = true;
    };

    yy = {
      command = "wl-copy '#COMMAND'";
      description = "Copy the current command to clipboard";
      insert_type = "Surround";
      execute = true;
    };

    y1y = {
      command = "fc -ln -1 | wl-copy";
      description = "Copy the previous command to clipboard";
      execute = true;
    };

    y2y = {
      command = "fc -ln -2 | wl-copy";
      description = "Copy the previous two commands to clipboard";
      execute = true;
    };

    y3y = {
      command = "fc -ln -3 | wl-copy";
      description = "Copy the previous three commands to clipboard";
      execute = true;
    };

    y4y = {
      command = "fc -ln -4 | wl-copy";
      description = "Copy the previous four commands to clipboard";
      execute = true;
    };

    y5y = {
      command = "fc -ln -5 | wl-copy";
      description = "Copy the previous five commands to clipboard";
      execute = true;
    };

    y6y = {
      command = "fc -ln -6 | wl-copy";
      description = "Copy the previous six commands to clipboard";
      execute = true;
    };

    y7y = {
      command = "fc -ln -7 | wl-copy";
      description = "Copy the previous seven commands to clipboard";
      execute = true;
    };

    y8y = {
      command = "fc -ln -8 | wl-copy";
      description = "Copy the previous eight commands to clipboard";
      execute = true;
    };

    y9y = {
      command = "fc -ln -9 | wl-copy";
      description = "Copy the previous nine commands to clipboard";
      execute = true;
    };

    y0y = {
      command = "fc -ln -10 | wl-copy";
      description = "Copy the previous ten commands to clipboard";
      execute = true;
    };

    gc = {
      command = "git commit -m '#CURSOR'";
      description = "Start a Git commit";
    };

    gs = {
      command = "git status";
      description = "Git status";
      execute = true;
    };

    gd = {
      command = "git diff";
      description = "Git diff";
      execute = true;
    };

    gD = {
      command = "git diff --staged";
      description = "Git diff staged";
      execute = true;
    };

    gaa = {
      command = "git add .";
      description = "Git add all";
      execute = true;
    };

    gap = {
      command = "git add . --patch";
      description = "Git add patch -- interactively stage chunks";
      execute = true;
    };

    gpu = {
      command = "git push #CURSOR";
      description = "Start a git push";
    };

    gpb = {
      command = "git push --set-upstream origin $(git branch --show-current)";
      description = "Start a git push of a new current local branch to remote";
    };

    gl = {
      command = "git l";
      description = "Compact view of git history";
      execute = true;
    };

    gpl = {
      command = "git pull";
      description = "Git pull";
      execute = true;
    };

    gg = {
      command = "echo UPDATESTARTUPTTY | gpg-connect-agent";
      description = "kick gpg agent";
      execute = true;
    };

    ps = {
      command = "sudo ";
      description = "Prepend sudo";
      insert_type = "Prepend";
    };

    nu = {
      command = "netbird up";
      description = "connnect to netbird";
      execute = true;
    };

    nd = {
      command = "netbird down";
      description = "disconnnect from netbird";
      execute = true;
    };
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      leadr = prev.rustPlatform.buildRustPackage {
        pname = "leadr";
        version = "2.6.0";
        cargoLock.lockFile = inputs.leadr + "/Cargo.lock";
        src = inputs.leadr;
        meta = with pkgs.lib; {
          description = "A customizable CLI command manager inspired by the leader key concept in (Neo)Vim";
          license = licenses.mit;
          homepage = "https://github.com/ll-nick/leadr";
        };
      };
    })
  ];

  home.packages = with pkgs; [
    leadr
  ];

  home = {
    file.leadrConfig = {
      target = ".config/leadr/config.toml";
      source = tomlFormat.generate "config.toml" leadrConfig;
    };
    file.leadrMappings = {
      target = ".config/leadr/mappings.toml";
      source = tomlFormat.generate "mappings.toml" leadrMappings;
    };
  };
}
