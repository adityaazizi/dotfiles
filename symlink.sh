#!/bin/bash

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
    fi
    return 1
}

# Function to remove existing symlink
remove_symlink() {
    local file="$1"
    if [[ -L "$file" ]]; then
        print_warning "Removing existing symlink: $file"
        rm "$file"
        return 0
    fi
    return 1
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"

    print_status "Creating symlink for $description..."
    
    # Check if source exists
    if [[ ! -e "$source" ]]; then
        print_error "Source does not exist: $source"
        return 1
    fi

    # Handle existing target
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        if [[ -L "$target" ]]; then
            # It's a symlink, check if it points to the right place
            if [[ "$(readlink "$target")" == "$source" ]]; then
                print_success "$description already correctly symlinked"
                return 0
            else
                remove_symlink "$target"
            fi
        else
            # It's a regular file/directory, backup it
            create_backup "$target"
        fi
    fi

    # Create parent directory if needed
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        print_status "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Create the symlink
    if ln -sf "$source" "$target"; then
        print_success "$description symlinked successfully"
        return 0
    else
        print_error "Failed to create symlink for $description"
        return 1
    fi
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
    echo "=================================="
    echo "  Dotfiles Symlink Setup Script  "
    echo "=================================="
    echo

    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_status "Script directory: $SCRIPT_DIR"
    print_status "Home directory: $HOME"
    echo

    # Check prerequisites
    if ! check_prerequisites; then
        exit 1
    fi
    echo

    # Create symlinks
    print_status "Creating symlinks..."
    echo

    local failed=0

    # Neovim configuration
    if ! create_symlink "$SCRIPT_DIR/.config/nvim" "$HOME/.config/nvim" "Neovim configuration"; then
        ((failed++))
    fi

    # Tmux configuration
    if ! create_symlink "$SCRIPT_DIR/.config/tmux" "$HOME/.config/tmux" "Tmux configuration"; then
        ((failed++))
    fi

    # WezTerm configuration
    if ! create_symlink "$SCRIPT_DIR/.wezterm.lua" "$HOME/.wezterm.lua" "WezTerm configuration"; then
        ((failed++))
    fi

    # Zsh configuration
    if ! create_symlink "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc" "Zsh configuration"; then
        ((failed++))
    fi

    echo

    # Setup tmux if symlink was successful
    if [[ -L "$HOME/.config/tmux" ]]; then
        setup_tmux
        echo
    fi

    # Summary
    if [[ $failed -eq 0 ]]; then
        print_success "All symlinks created successfully!"
        echo
        print_status "Next steps:"
        echo "  1. Restart your terminal or run: source ~/.zshrc"
        echo "  2. Open Neovim to auto-install plugins: nvim"
        echo "  3. Configure Powerlevel10k: p10k configure"
        echo
        print_success "Setup complete! Enjoy your new dotfiles! ✨"
    else
        print_error "$failed symlink(s) failed to create"
        echo
        print_status "Please check the errors above and try again"
        exit 1
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi