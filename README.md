# Dotfiles ✨

A minimal and cross-platform development environment setup for **macOS** and **Linux**. These dotfiles provide a modern, efficient workflow with Neovim, Tmux, WezTerm, and Zsh.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/adityaazizi/dotfiles.git ~/dotfiles

# Navigate to dotfiles directory
cd ~/dotfiles

# Run the automated setup
./symlink.sh
```

## 📦 What's Included

| Tool | Description | Key Features |
|------|-------------|--------------|
| **Neovim** | Modern text editor | LSP support, syntax highlighting, file explorer |
| **Tmux** | Terminal multiplexer | Session management, pane splitting, vim navigation |
| **WezTerm** | GPU-accelerated terminal | Custom colorscheme, font rendering, cross-platform |
| **Zsh** | Feature-rich shell | Oh My Zsh, Powerlevel10k, autosuggestions, syntax highlighting |

## 🛠️ Prerequisites

### macOS (using Homebrew)
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install prerequisites and fonts
brew install neovim tmux git wezterm zsh eza zsh-autosuggestions zsh-syntax-highlighting
brew install --cask font-meslo-lg-nerd-font

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Linux (Ubuntu/Debian)
```bash
# Update package list
sudo apt update

# Install prerequisites
sudo apt install neovim tmux git zsh curl wget

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh plugins
sudo apt install zsh-autosuggestions zsh-syntax-highlighting

# Install eza (optional, for better ls)
sudo apt install -y gpg
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# Install Nerd Font
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
unzip Meslo.zip -d ~/.local/share/fonts/
fc-cache -fv
rm Meslo.zip

# Install WezTerm (latest version)
curl -LO https://github.com/wez/wezterm/releases/latest/download/wezterm-nightly.Ubuntu22.04.deb
sudo dpkg -i wezterm-*.deb
sudo apt-get install -f  # Fix any missing dependencies
rm wezterm-*.deb
```

## 📋 Installation

### Method 1: Automated Setup (Recommended)

```bash
# Clone the repository
git clone https://github.com/adityaazizi/dotfiles.git ~/dotfiles

# Navigate to dotfiles directory
cd ~/dotfiles

# Run the automated setup script
./symlink.sh
```

The script will:
- ✅ Check prerequisites
- ✅ Backup existing configurations
- ✅ Create symlinks automatically
- ✅ Install Tmux Plugin Manager
- ✅ Setup tmux plugins

### Method 2: Manual Setup

If you prefer manual control:

```bash
# Clone repository
git clone https://github.com/adityaazizi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Create directories
mkdir -p ~/.config

# Create symlinks manually
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/tmux ~/.config/tmux
ln -sf ~/dotfiles/.wezterm.lua ~/.wezterm.lua
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## 🎯 Post-Installation

1. **Restart your terminal** or source the new shell configuration:
   ```bash
   source ~/.zshrc
   ```

2. **Install tmux plugins** (if not done automatically):
   ```bash
   # Start tmux and press Ctrl+a then I
   tmux
   # Press: Ctrl+a + I (capital i)
   ```

3. **Open Neovim** to auto-install plugins:
   ```bash
   nvim
   ```
   Plugins will install automatically via Lazy.nvim.

4. **Configure Powerlevel10k theme**:
   ```bash
   p10k configure
   ```
   Follow the interactive prompts to customize your prompt.

5. **Set Zsh as default shell** (if not already):
   ```bash
   chsh -s $(which zsh)
   ```

## ⚙️ Configuration Details

### Neovim Features
- **Plugin Manager**: Lazy.nvim for fast, lazy-loaded plugins
- **LSP Support**: Built-in language server protocol support
- **File Navigation**: nvim-tree for file exploration
- **Fuzzy Finding**: Telescope for file and text search
- **Git Integration**: Gitsigns for git status in editor
- **Autocompletion**: nvim-cmp with multiple sources
- **Syntax Highlighting**: Treesitter for accurate highlighting

### Tmux Configuration
- **Prefix Key**: `Ctrl+a` (instead of default `Ctrl+b`)
- **Split Panes**: `|` for vertical, `-` for horizontal splits
- **Vim Navigation**: Seamless navigation between vim and tmux panes
- **Mouse Support**: Enabled for easy pane management
- **Session Persistence**: Auto-save and restore sessions
- **Themes**: Tokyo Night theme with powerline status

### Zsh Features
- **Theme**: Powerlevel10k for beautiful, informative prompt
- **Plugins**: Autosuggestions and syntax highlighting
- **Cross-platform**: Automatic plugin loading based on OS
- **Better ls**: eza integration for colorized file listings
- **History**: Enhanced history management and sharing

### WezTerm Setup
- **Font**: MesloLGS Nerd Font Mono for icon support
- **Theme**: Custom coolnight colorscheme
- **Performance**: GPU acceleration enabled
- **Integration**: Works seamlessly with tmux and terminal tools

## 🛠️ Customization Guide

### Modifying Neovim
Edit files in `~/.config/nvim/lua/adityaazizi/`:
- `core/options.lua` - Editor options and settings
- `core/keymaps.lua` - Key bindings and shortcuts
- `plugins/` - Individual plugin configurations

### Customizing Tmux
Edit `~/.config/tmux/tmux.conf`:
- Change prefix key, bindings, or theme
- Add or remove plugins in the plugin section

### Personalizing Zsh
Edit `~/.zshrc`:
- Add custom aliases and functions
- Modify prompt with `p10k configure`
- Add additional Oh My Zsh plugins

### Tweaking WezTerm
Edit `~/.wezterm.lua`:
- Change font, size, or colorscheme
- Modify window behavior and appearance

## 🔧 Troubleshooting

### Common Issues

**Fonts not displaying correctly:**
- Ensure Nerd Font is installed and set in terminal
- Run `fc-cache -fv` on Linux after font installation

**Tmux plugins not working:**
- Install TPM: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`
- Press `Ctrl+a + I` in tmux to install plugins

**Zsh not loading plugins:**
- Check if Oh My Zsh is installed
- Verify plugin paths in shell with `echo $ZSH`

**Neovim plugins not installing:**
- Run `:Lazy sync` in Neovim
- Check internet connection and permissions

### Getting Help

For issues specific to this configuration:
1. Check the troubleshooting section above
2. Review configuration files for syntax errors
3. Ensure all prerequisites are installed

For tool-specific issues:
- [Neovim Documentation](https://neovim.io/doc/)
- [Tmux Manual](https://github.com/tmux/tmux/wiki)
- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs. If you have improvements or fixes, pull requests are welcome!

---

**Enjoy your new development environment! 🎉**