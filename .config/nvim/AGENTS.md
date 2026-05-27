# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using Lua and [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. The config namespace is `adityaazizi`.

## Architecture

```
init.lua                        # Entry point: loads core + lazy
lua/adityaazizi/
  core/
    init.lua                    # Requires options + keymaps
    options.lua                 # Vim options (tabs, search, UI)
    keymaps.lua                 # Non-plugin keymaps, leader = <Space>
  lazy.lua                      # Bootstraps lazy.nvim, imports plugins
  plugins/
    *.lua                       # One file per plugin
    lsp/
      mason.lua                 # Mason: installs LSPs, formatters, linters
      lspconfig.lua             # LSP attach logic and keymaps
```

**Plugin loading:** `lazy.lua` scans `adityaazizi.plugins` and `adityaazizi.plugins.lsp` — each file returns a lazy.nvim plugin spec. Adding a new plugin means creating a new file in `lua/adityaazizi/plugins/`.

## Key Plugin Files

| File | Purpose |
|------|---------|
| `plugins/lsp/mason.lua` | Declares which LSP servers, formatters, and linters Mason installs |
| `plugins/lsp/lspconfig.lua` | Per-server LSP setup, capabilities, and on_attach keymaps |
| `plugins/formatting.lua` | conform.nvim — maps filetypes to formatters |
| `plugins/linting.lua` | nvim-lint — maps filetypes to linters |
| `plugins/treesitter.lua` | Treesitter parsers and modules (autotag, indent, etc.) |
| `plugins/nvim-cmp.lua` | Completion sources and UI |
| `plugins/colorscheme.lua` | Tokyo Night theme with custom highlight overrides |
| `plugins/telescope.lua` | Fuzzy finder keymaps and config |

## Adding / Modifying Things

**New LSP server:** Add the server name to the `ensure_installed` table in `mason.lua`, then add its setup call in `lspconfig.lua`.

**New formatter:** Add the tool to `mason.lua`'s `ensure_installed`, then wire it into `formatting.lua`'s `formatters_by_ft` table.

**New plugin:** Create `lua/adityaazizi/plugins/<name>.lua` returning a valid lazy.nvim spec — lazy picks it up automatically on next launch.

## Installed Language Servers

Web: `ts_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `emmet_ls`, `graphql`, `prismals`, `eslint`  
General: `pyright`, `clangd`, `cmake`, `dockerls`, `jsonls`, `yamlls`, `lua_ls`, `marksman`

Formatters: prettier (web), stylua (Lua), black + isort (Python)  
Linters: eslint_d (JS/TS), pylint (Python)

## Core Keybindings Reference

Leader key: `<Space>`

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>ff/fr/fs/fc/ft` | Telescope: files / recent / grep / word / TODOs |
| `<leader>ee/ef/ec/er` | Nvim-tree: toggle / find file / collapse / refresh |
| `<leader>mp` | Format buffer (conform.nvim) |
| `<leader>l` | Run linter |
| `<leader>lg` | Open lazygit |
| `gd/gD/gR/gi/gt` | LSP: definition / declaration / references / impl / type |
| `<leader>ca` / `<leader>rn` | LSP: code action / rename |
| `K` | LSP hover |
| `[h/]h` | Git: prev/next hunk |
| `<leader>hs/hr` | Git: stage / reset hunk |
| `<leader>wr/ws` | Session: restore / save |
| `<leader>xw/xd` | Trouble: workspace / document diagnostics |
