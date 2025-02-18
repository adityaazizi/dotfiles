# Dotfiles

This repository contains my personal development environment configurations. These dotfiles are kept minimal and straightforward for easy adoption and customization.

## What's Inside?

- **Neovim**: A highly extensible text editor with various coding plugins
- **Tmux**: Terminal multiplexer for managing terminal sessions
- **WezTerm**: A GPU-accelerated cross-platform terminal emulator
- **Zsh**: Feature-rich shell with additional functionality

## Installation

1. Clone this repository:

```bash
git clone https://github.com/username/dotfiles.git ~/.dotfiles
```

2. Navigate to the dotfiles directory:

```bash
cd ~/.dotfiles
```

3. Create symlinks in your home directory:

```bash
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```

## Prerequisites

Make sure you have these tools installed:

- Neovim
- Tmux
- Git
- WezTerm
- Zsh

## Customization

All configurations can be tailored to your needs:

- Neovim: Edit files in `~/.config/nvim/`
- Tmux: Edit `.tmux.conf`
- Git: Edit `.gitconfig`
- WezTerm: Edit `.wezterm.lua`

