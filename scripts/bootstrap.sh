#!/usr/bin/env bash
set -euo pipefail

echo "==> Mac Bootstrap"
echo ""

# 1. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed"
fi

# 2. Install git (via Xcode CLT) if missing
if ! command -v git &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools (includes git)..."
  xcode-select --install
  echo "    Waiting for install to complete... Re-run this script when done."
  exit 1
else
  echo "==> Git already installed ($(git --version))"
fi

# 3. Set up SSH key if missing
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "==> Generating SSH key..."
  mkdir -p "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "lujcmss@gmail.com" -f "$HOME/.ssh/id_ed25519" -N ""
  eval "$(ssh-agent -s)"
  ssh-add "$HOME/.ssh/id_ed25519"
  pbcopy < "$HOME/.ssh/id_ed25519.pub"
  echo ""
  echo "==> SSH public key copied to clipboard!"
  echo "    Add it to GitHub: https://github.com/settings/keys"
  echo "    Then re-run this script to continue."
  exit 0
else
  echo "==> SSH key already exists"
fi

# 4. Test GitHub connection
echo "==> Testing GitHub SSH connection..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
  echo "==> GitHub SSH connection OK"
else
  echo "==> GitHub SSH not working. Add your key at: https://github.com/settings/keys"
  echo "    Then re-run this script."
  exit 1
fi

# 5. Clone the repo if missing
if [ ! -d "$HOME/mac-iterm2-setup" ]; then
  echo "==> Cloning config repo..."
  git clone git@github.com:lujcmss/mac-iterm2-setup.git "$HOME/mac-iterm2-setup"
else
  echo "==> Config repo already cloned, pulling latest..."
  cd "$HOME/mac-iterm2-setup" && git pull
fi

# 6. Hand off to setup script
echo ""
exec "$HOME/mac-iterm2-setup/scripts/setup.sh"
