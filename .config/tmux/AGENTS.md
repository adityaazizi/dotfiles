# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal tmux configuration managed with [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm). The single config file is `tmux.conf`; plugins live under `plugins/` and are git submodules managed by TPM.

## Applying changes

After editing `tmux.conf`, reload inside a running tmux session:
```
prefix + r   # (prefix is C-a)
```

Or from the shell:
```sh
tmux source-file ~/.config/tmux/tmux.conf
```

To install new plugins after adding them to `tmux.conf`:
```
prefix + I   # capital I — installs missing plugins
```

To update plugins:
```
prefix + U
```

## Key customizations

- **Prefix**: `C-a` (replaces default `C-b`)
- **Splits**: `|` for horizontal, `-` for vertical
- **Pane resize**: `h/j/k/l` (vim-style, no prefix needed after initial bind)
- **Pane zoom**: `prefix + m`
- **Change session CWD**: `prefix + M-c` (attaches session rooted at current pane path)
- **Copy mode**: vi keys; `v` to begin selection, `y` to copy; mouse drag does not exit copy mode
- **escape-time**: set to 10ms to avoid Neovim ESC delay
- **Window/pane numbering**: starts at 1; windows renumber automatically on close
- **Status bar**: forced to `bottom` after the TPM `run` line — `tmux-tokyo-night` overrides it to `top` by default

## macOS note

`tmux-tokyo-night` (PowerKit) requires Bash 5.0+. macOS ships with Bash 3.2, so Homebrew bash must be installed (`brew install bash`) and made available via `set-environment -g PATH` at the top of `tmux.conf`. Plugin scripts use `#!/usr/bin/env bash`, so they pick up `/opt/homebrew/bin/bash` automatically once PATH is set. The overrides for `status-position` and `base-index` are placed **after** the TPM `run` line so they win over plugin defaults.

## Installed plugins

| Plugin | Purpose |
|---|---|
| `tpm` | Plugin manager — must remain last `run` line |
| `vim-tmux-navigator` | Seamless pane/split navigation with Neovim (`C-h/j/k/l`) |
| `tmux-tokyo-night` | Status bar theme — configured with `@powerkit_theme "tokyo-night"` + `@powerkit_theme_variant "night"`; without these the plugin picks a different default |
| `tmux-resurrect` | Manually save/restore sessions (`prefix + C-s` / `prefix + C-r`) |
| `tmux-continuum` | Auto-saves sessions every 15 min; auto-restores on tmux start |

Session persistence: `tmux-resurrect` captures pane contents (`@resurrect-capture-pane-contents on`) and `tmux-continuum` restores automatically (`@continuum-restore on`).
