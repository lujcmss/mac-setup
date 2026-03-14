#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Mac iTerm2 Setup"
echo ""

# 1. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
fi

# 2. Install packages from Brewfile
echo "==> Installing brew packages..."
brew bundle --file="$REPO_DIR/Brewfile"

# 3. Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "==> Oh My Zsh already installed"
fi

# 4. Install Powerlevel10k if missing
if [ ! -d "$HOME/powerlevel10k" ]; then
  echo "==> Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
else
  echo "==> Powerlevel10k already installed"
fi

# 5. Symlink zsh configs
echo "==> Linking zsh configs..."
ln -sf "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# 6. Symlink git config
echo "==> Linking git config..."
ln -sf "$REPO_DIR/git/.gitconfig" "$HOME/.gitconfig"

# 7. Import iTerm2 preferences
echo "==> Importing iTerm2 preferences..."
cp "$REPO_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# 8. Set up SSH key if missing
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "==> No SSH key found. Generate one with:"
  echo "    ssh-keygen -t ed25519 -C \"your.email@example.com\""
  echo "    Then add it to GitHub: https://github.com/settings/keys"
else
  echo "==> SSH key already exists"
fi

# 9. Authenticate GitHub CLI if needed
if ! gh auth status &>/dev/null; then
  echo "==> GitHub CLI not authenticated. Run: gh auth login"
else
  echo "==> GitHub CLI already authenticated"
fi

echo ""
echo "==> Setup complete! Restart iTerm2 for changes to take effect."
