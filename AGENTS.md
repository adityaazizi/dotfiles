# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles for macOS and Linux. Configurations for Neovim, Tmux, WezTerm, and Zsh are versioned here and synced to/from the home directory via two shell scripts.

## Sync Workflow

This repo uses **copy-based sync** (not symlinks). Edits in the repo must be explicitly pushed to `$HOME`, and edits in `$HOME` must be pulled back.

```bash
./update_local.sh   # repo → $HOME (installs/refreshes configs)
./update_remote.sh  # $HOME → repo (captures local changes)
```

After `update_remote.sh`, commit normally with `git add -A && git commit`.

`~/.config/tmux/plugins/` is intentionally excluded from sync (TPM manages it).

## Config Locations

| Tool | Repo path | Syncs to |
|------|-----------|----------|
| Neovim | `.config/nvim/` | `~/.config/nvim/` |
| Tmux | `.config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| WezTerm | `.wezterm.lua` | `~/.wezterm.lua` |
| Zsh | `.zshrc` | `~/.zshrc` |

## Neovim Structure

Entry point is `.config/nvim/init.lua`, which loads two modules:

- `lua/adityaazizi/core/` — `options.lua` (editor settings) and `keymaps.lua` (bindings)
- `lua/adityaazizi/lazy.lua` — bootstraps Lazy.nvim and loads all plugins
- `lua/adityaazizi/plugins/` — one file per plugin; `lsp/` subdirectory holds mason and lspconfig setup

Adding a plugin means creating a new file in `plugins/` returning a Lazy.nvim spec table. Lazy.nvim handles lazy-loading; the lock file is `lazy-lock.json`.

## Key Defaults

- **Tmux prefix**: `Ctrl+a` (not the default `Ctrl+b`)
- **Tmux splits**: `|` vertical, `-` horizontal
- **Zsh theme**: Powerlevel10k via Oh My Zsh
- **WezTerm colorscheme**: coolnight (custom, defined inline in `.wezterm.lua`)
- **Font**: MesloLGS Nerd Font Mono (required for icons in Neovim and Powerlevel10k)
