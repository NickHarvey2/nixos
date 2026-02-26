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
    id.command = "date +%Y%m%d";
    id.description = "Insert current date in YYYYMMDD format";
    id.insert_type = "Insert";
    id.evaluate = true;

    sb.command = "'#CURSOR`#COMMAND`'";
    sb.description = "Surround with backticks";
    sb.insert_type = "Surround";

    sq.command = "\"#COMMAND\"";
    sq.description = "Surround with quotes";
    sq.insert_type = "Surround";

    sl.command = "IFS=$'\\n' read -rd '' -A #CURSOR <<< $(#COMMAND)";
    sl.description = "read in command as a newline delimited list";
    sl.insert_type = "Surround";

    ay.command = " | wl-copy";
    ay.description = "Append copy to clipboard";
    ay.insert_type = "Append";

    yx.command = "echo -n '' | wl-copy";
    yx.description = "Clear the clipboard";
    yx.execute = true;

    yy.command = "wl-copy '#COMMAND'";
    yy.description = "Copy the current command to clipboard";
    yy.insert_type = "Surround";
    yy.execute = true;

    y1y.command = "fc -ln -1 | wl-copy";
    y1y.description = "Copy the previous command to clipboard";
    y1y.execute = true;

    y2y.command = "fc -ln -2 | wl-copy";
    y2y.description = "Copy the previous two commands to clipboard";
    y2y.execute = true;

    y3y.command = "fc -ln -3 | wl-copy";
    y3y.description = "Copy the previous three commands to clipboard";
    y3y.execute = true;

    y4y.command = "fc -ln -4 | wl-copy";
    y4y.description = "Copy the previous four commands to clipboard";
    y4y.execute = true;

    y5y.command = "fc -ln -5 | wl-copy";
    y5y.description = "Copy the previous five commands to clipboard";
    y5y.execute = true;

    y6y.command = "fc -ln -6 | wl-copy";
    y6y.description = "Copy the previous six commands to clipboard";
    y6y.execute = true;

    y7y.command = "fc -ln -7 | wl-copy";
    y7y.description = "Copy the previous seven commands to clipboard";
    y7y.execute = true;

    y8y.command = "fc -ln -8 | wl-copy";
    y8y.description = "Copy the previous eight commands to clipboard";
    y8y.execute = true;

    y9y.command = "fc -ln -9 | wl-copy";
    y9y.description = "Copy the previous nine commands to clipboard";
    y9y.execute = true;

    y0y.command = "fc -ln -10 | wl-copy";
    y0y.description = "Copy the previous ten commands to clipboard";
    y0y.execute = true;

    gc.command = "git commit -m '#CURSOR'";
    gc.description = "Start a Git commit";

    gs.command = "git status";
    gs.description = "Git status";
    gs.execute = true;

    gd.command = "git diff";
    gd.description = "Git diff";
    gd.execute = true;

    gD.command = "git diff --staged";
    gD.description = "Git diff staged";
    gD.execute = true;

    gaa.command = "git add .";
    gaa.description = "Git add all";
    gaa.execute = true;

    gap.command = "git add . --patch";
    gap.description = "Git add patch -- interactively stage chunks";
    gap.execute = true;

    gp.command = "git push #CURSOR";
    gp.description = "Start a git push";

    gl.command = "git pull";
    gl.description = "Git pull";
    gl.execute = true;

    gg.command = "echo UPDATESTARTUPTTY | gpg-connect-agent";
    gg.description = "kick gpg agent";
    gg.execute = true;

    ps.command = "sudo ";
    ps.description = "Prepend sudo";
    ps.insert_type = "Prepend";
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
