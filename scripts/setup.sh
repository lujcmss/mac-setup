#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Mac iTerm2 Setup"
echo ""

# 1. Ensure Homebrew is available
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

# 5. Symlink git config
echo "==> Linking git config..."
ln -sf "$REPO_DIR/git/.gitconfig" "$HOME/.gitconfig"

# 6. Symlink zsh configs
echo "==> Linking zsh configs..."
ln -sf "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# 7. Symlink vim config
echo "==> Linking vim config..."
ln -sf "$REPO_DIR/vim/.vimrc" "$HOME/.vimrc"

# 8. Symlink tmux config
echo "==> Linking tmux config..."
ln -sf "$REPO_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# 9. Install Claude Code (native installer; auto-upgrades in background)
if ! command -v claude &>/dev/null && [ ! -x "$HOME/.local/bin/claude" ]; then
  echo "==> Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "==> Claude Code already installed"
fi

# 10. Symlink Claude Code config (settings, statusline, slash commands)
echo "==> Linking Claude Code config..."
mkdir -p "$HOME/.claude"
# Back up any pre-existing real files (not symlinks) before replacing with symlinks
for f in settings.json settings.local.json statusline-command.sh; do
  if [ -f "$HOME/.claude/$f" ] && [ ! -L "$HOME/.claude/$f" ]; then
    mv "$HOME/.claude/$f" "$HOME/.claude/$f.pre-mac-setup.bak"
    echo "    Backed up existing $f to $f.pre-mac-setup.bak"
  fi
done
ln -sf "$REPO_DIR/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$REPO_DIR/claude/settings.local.json" "$HOME/.claude/settings.local.json"
ln -sf "$REPO_DIR/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

# 11. Import iTerm2 preferences
echo "==> Importing iTerm2 preferences..."
cp "$REPO_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# 12. Authenticate GitHub CLI if needed
if ! gh auth status &>/dev/null; then
  echo ""
  echo "==> GitHub CLI not authenticated. Run: gh auth login"
else
  echo "==> GitHub CLI already authenticated"
fi

echo ""
echo "==> Setup complete! Restart iTerm2 for changes to take effect."
