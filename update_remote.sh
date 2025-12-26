#!/bin/bash

# update_remote.sh - Copy configs from home directory to dotfiles repo
# This script captures your local configuration changes for version control

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

# Function to copy configuration to repo
copy_to_repo() {
    local source="$1"
    local target="$2"
    local description="$3"
    local exclude_pattern="$4"

    print_status "Copying $description..."

    # Check if source exists
    if [[ ! -e "$source" ]]; then
        print_warning "Source does not exist: $source (skipping)"
        return 0
    fi

    # Create parent directory if needed
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        print_status "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi

    # Remove existing target to ensure clean copy
    if [[ -e "$target" ]]; then
        rm -rf "$target"
    fi

    # Copy the configuration
    if [[ -d "$source" ]]; then
        if [[ -n "$exclude_pattern" ]]; then
            # Use rsync for exclusion support
            if command -v rsync >/dev/null 2>&1; then
                if rsync -a --exclude="$exclude_pattern" "$source/" "$target/"; then
                    print_success "$description copied successfully (excluded: $exclude_pattern)"
                    return 0
                fi
            else
                # Fallback: copy then remove excluded
                if cp -r "$source" "$target"; then
                    rm -rf "$target/$exclude_pattern" 2>/dev/null || true
                    print_success "$description copied successfully (excluded: $exclude_pattern)"
                    return 0
                fi
            fi
        else
            if cp -r "$source" "$target"; then
                print_success "$description copied successfully"
                return 0
            fi
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

# Main function
main() {
    echo "========================================"
    echo "  Update Remote - Sync to Repo"
    echo "  (home directory -> dotfiles repo)"
    echo "========================================"
    echo

    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    print_status "Source: $HOME"
    print_status "Target: $SCRIPT_DIR"
    echo

    # Copy configurations
    print_status "Copying configurations to repository..."
    echo

    local failed=0

    # Neovim configuration
    if ! copy_to_repo "$HOME/.config/nvim" "$SCRIPT_DIR/.config/nvim" "Neovim configuration"; then
        ((failed++))
    fi

    # Tmux configuration (exclude plugins directory)
    if ! copy_to_repo "$HOME/.config/tmux" "$SCRIPT_DIR/.config/tmux" "Tmux configuration" "plugins"; then
        ((failed++))
    fi

    # WezTerm configuration
    if ! copy_to_repo "$HOME/.wezterm.lua" "$SCRIPT_DIR/.wezterm.lua" "WezTerm configuration"; then
        ((failed++))
    fi

    # Zsh configuration
    if ! copy_to_repo "$HOME/.zshrc" "$SCRIPT_DIR/.zshrc" "Zsh configuration"; then
        ((failed++))
    fi

    echo

    # Summary
    if [[ $failed -eq 0 ]]; then
        print_success "All configurations synced to repository!"
        echo
        print_status "Next steps:"
        echo "  1. Review changes: git status"
        echo "  2. Stage changes: git add -A"
        echo "  3. Commit changes: git commit -m \"Update configurations\""
        echo "  4. Push to remote: git push"
        echo
        print_success "Sync complete!"
    else
        print_error "$failed configuration(s) failed to sync"
        echo
        print_status "Please check the errors above and try again"
        exit 1
    fi
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
