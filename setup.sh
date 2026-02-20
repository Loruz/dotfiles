#!/bin/bash
set -e

echo "Setting up your Mac..."

# ── 1. Homebrew ────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update

# ── 2. Clone dotfiles ──────────────────────────────────────────────────────────
DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/Loruz/dotfiles.git "$DOTFILES_DIR"
fi

# ── 3. Brew bundle ─────────────────────────────────────────────────────────────
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/brewfile"

# ── 4. Oh-My-Zsh ──────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# per-directory-history plugin (not bundled with oh-my-zsh)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/per-directory-history" ]]; then
  git clone https://github.com/jimhester/per-directory-history \
    "$ZSH_CUSTOM/plugins/per-directory-history"
fi

# ── 5. Shell config symlinks ───────────────────────────────────────────────────
echo "Creating shell symlinks..."
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"

# ── 6. VS Code symlinks ────────────────────────────────────────────────────────
echo "Creating VS Code symlinks..."
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_DIR"
ln -sf "$DOTFILES_DIR/VisualStudio/settings.json" "$VSCODE_DIR/settings.json"
ln -sf "$DOTFILES_DIR/VisualStudio/keybindings.json" "$VSCODE_DIR/keybindings.json"

# ── 7. Cursor symlinks ─────────────────────────────────────────────────────────
echo "Creating Cursor symlinks..."
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_DIR"
ln -sf "$DOTFILES_DIR/VisualStudio/settings.json" "$CURSOR_DIR/settings.json"
ln -sf "$DOTFILES_DIR/VisualStudio/keybindings.json" "$CURSOR_DIR/keybindings.json"

# ── 8. Node LTS via NVM ───────────────────────────────────────────────────────
echo "Installing Node.js LTS via nvm..."
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"
nvm install --lts
nvm use --lts
nvm alias default "lts/*"

# ── 9. Rust via rustup ────────────────────────────────────────────────────────
if ! command -v rustup &>/dev/null; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

# ── 10. Claude Code ────────────────────────────────────────────────────────────
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# ── 11. Default shell ─────────────────────────────────────────────────────────
ZSH_PATH="$(which zsh)"
if ! grep -qF "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$ZSH_PATH"

echo ""
echo "Done! Open a new terminal to start using your setup."
