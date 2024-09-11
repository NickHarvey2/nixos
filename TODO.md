# TODO

## Figure out clipboard issues

| Copy method                   | Paste destination + method      | Result   |
|-------------------------------|---------------------------------|----------|
| Yanked from neovim            | into Kitty using ctrl+shift+V   | OK       |
| Yanked from neovim            | into Kitty using shift+insert   | OK       |
| Yanked from neovim            | into Firefox using ctrl+V       | OK       |
| Yanked from neovim            | into Firefox using shift+insert | OK       |
| Yanked from neovim            | output of wl-paste              | OK       |
| From kitty with ctrl+shift+C  | into Kitty using ctrl+shift+V   | OK       |
| From kitty with ctrl+shift+C  | into Kitty using shift+insert   | OK       |
| From kitty with ctrl+shift+C  | into Firefox using ctrl+V       | OK       |
| From kitty with ctrl+shift+C  | into Firefox using shift+insert | OK       |
| From kitty with ctrl+shift+C  | output of wl-paste              | OK       |
| Copy from Firefox with ctrl+C | into Kitty using ctrl+shift+V   | OK       |
| Copy from Firefox with ctrl+C | into Kitty using shift+insert   | OK       |
| Copy from Firefox with ctrl+C | into Firefox using ctrl+V       | OK       |
| Copy from Firefox with ctrl+C | into Firefox using shift+insert | OK       |
| Copy from Firefox with ctrl+C | output of wl-paste              | OK       |
| Piped to wl-copy              | into Kitty using ctrl+shift+V   | OK       |
| Piped to wl-copy              | into Kitty using shift+insert   | NO WORKY |
| Piped to wl-copy              | into Firefox using ctrl+V       | OK       |
| Piped to wl-copy              | into Firefox using shift+insert | OK       |
| Piped to wl-copy              | output of wl-paste              | OK       |
| Yanked from tmux              | into Kitty using ctrl+shift+V   | OK       |
| Yanked from tmux              | into Kitty using shift+insert   | NO WORKY |
| Yanked from tmux              | into Firefox using ctrl+V       | OK       |
| Yanked from tmux              | into Firefox using shift+insert | OK       |
| Yanked from tmux              | output of wl-paste              | OK       |
