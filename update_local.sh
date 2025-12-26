#!/bin/bash

# update_local.sh - Copy configs from dotfiles repo to home directory
# This script installs/refreshes your local configuration from the repository

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create backup
create_backup() {
    local file="$1"
    if [[ -e "$file" ]] && [[ ! -L "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backing up existing $file to $backup"
        mv "$file" "$backup"
        return 0
    elif [[ -L "$file" ]]; then
        print_warning "Removing existing symlink: $file"
        rm "$file"
        return 0
    fi
    return 1
}

# Function to copy configuration
copy_config() {
    local source="$1"
    local target="$2"
    local description="$3"

    print_status "Copying $description..."

    # Check if source exists
    if [[ ! -e "$source" ]]; then
        print_error "Source does not exist: $source"
        return 1
    fi

    # Backup existing target
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        create_backup "$target"
    fi

    # Create parent directory if needed
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        print_status "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Copy the configuration
    if [[ -d "$source" ]]; then
        if cp -r "$source" "$target"; then
            print_success "$description copied successfully"
            return 0
        fi
    else
        if cp "$source" "$target"; then
            print_success "$description copied successfully"
            return 0
        fi
    fi

    print_error "Failed to copy $description"
    return 1
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."

    local missing_tools=()

    # Check for required tools
    command -v git >/dev/null 2>&1 || missing_tools+=("git")
    command -v zsh >/dev/null 2>&1 || missing_tools+=("zsh")

    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_error "Please install them first using the instructions in README.md"
        return 1
    fi

    print_success "Prerequisites check passed"
    return 0
}

# Function to setup tmux plugins
setup_tmux() {
    print_status "Setting up Tmux Plugin Manager..."

    local tpm_dir="$HOME/.config/tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
        print_status "Installing TPM (Tmux Plugin Manager)..."
        if git clone https://github.com/tmux-plugins/tpm "$tpm_dir"; then
            print_success "TPM installed successfully"
        else
            print_error "Failed to install TPM"
            return 1
        fi
    else
        print_success "TPM already installed"
    fi

    # Check if tmux is available and install plugins
    if command -v tmux >/dev/null 2>&1; then
        print_status "Installing tmux plugins..."
        tmux new-session -d -s install_plugins 2>/dev/null || true
        tmux send-keys -t install_plugins 'C-a I' Enter 2>/dev/null || true
        sleep 2
        tmux kill-session -t install_plugins 2>/dev/null || true
        print_success "Tmux plugins installation initiated"
    else
        print_warning "tmux not found, skipping plugin installation"
    fi
}

# Main function
main() {
    echo "========================================"
    echo "  Update Local - Install Configs"
    echo "  (dotfiles repo -> home directory)"
    echo "========================================"
    echo

    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    print_status "Source: $SCRIPT_DIR"
    print_status "Target: $HOME"
    echo

    # Check prerequisites
    if ! check_prerequisites; then
        exit 1
    fi
    echo

    # Copy configurations
    print_status "Copying configurations..."
    echo

    local failed=0

    # Neovim configuration
    if ! copy_config "$SCRIPT_DIR/.config/nvim" "$HOME/.config/nvim" "Neovim configuration"; then
        ((failed++))
    fi

    # Tmux configuration
    if ! copy_config "$SCRIPT_DIR/.config/tmux" "$HOME/.config/tmux" "Tmux configuration"; then
        ((failed++))
    fi

    # WezTerm configuration
    if ! copy_config "$SCRIPT_DIR/.wezterm.lua" "$HOME/.wezterm.lua" "WezTerm configuration"; then
        ((failed++))
    fi

    # Zsh configuration
    if ! copy_config "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc" "Zsh configuration"; then
        ((failed++))
    fi

    echo

    # Setup tmux if copy was successful
    if [[ -d "$HOME/.config/tmux" ]]; then
        setup_tmux
        echo
    fi

    # Summary
    if [[ $failed -eq 0 ]]; then
        print_success "All configurations copied successfully!"
        echo
        print_status "Next steps:"
        echo "  1. Restart your terminal or run: source ~/.zshrc"
        echo "  2. Open Neovim to auto-install plugins: nvim"
        echo "  3. Configure Powerlevel10k: p10k configure"
        echo "  4. Install tmux plugins: Press Ctrl+a then I in tmux"
        echo
        print_success "Setup complete!"
    else
        print_error "$failed configuration(s) failed to copy"
        echo
        print_status "Please check the errors above and try again"
        exit 1
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
