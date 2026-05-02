# Mac iTerm2 Setup

Personal Mac terminal environment: iTerm2, Oh My Zsh, Powerlevel10k, and dotfiles.

## What's included

| Directory | Contents |
|-----------|----------|
| `iterm2/` | iTerm2 preferences (gruvbox theme, profiles, keybindings) |
| `zsh/` | `.zshrc` (Oh My Zsh + Powerlevel10k) and `.p10k.zsh` |
| `git/` | `.gitconfig` |
| `vim/` | `.vimrc` (syntax, indentation, search, UI, clipboard) |
| `tmux/` | `.tmux.conf` (mouse support) |
| `claude/` | Claude Code statusline script (model, ctx %, rate limits, cost) |
| `Brewfile` | Homebrew packages (iTerm2, Nerd Font, gh, tmux, node, python, go) |
| `scripts/` | `bootstrap.sh` (fresh Mac) and `setup.sh` (post-clone) |

## Quick start (fresh Mac)

```bash
curl -fsSL https://raw.githubusercontent.com/lujcmss/mac-iterm2-setup/main/scripts/bootstrap.sh | bash
```

This single command will:

1. Install Homebrew
2. Ensure git is available
3. Generate an SSH key and copy it to clipboard (pause to add to GitHub)
4. Clone this repo
5. Install all brew packages (iTerm2, gh, tmux, node, python, go)
6. Install Oh My Zsh + Powerlevel10k
7. Symlink dotfiles (.gitconfig, .zshrc, .p10k.zsh, .vimrc, .tmux.conf, Claude statusline)
8. Import iTerm2 preferences

> **Claude Code statusline:** the script gets symlinked to `~/.claude/statusline-command.sh`.
> To activate it, add this to `~/.claude/settings.json`:
> ```json
> "statusLine": { "type": "command", "command": "sh ~/.claude/statusline-command.sh" }
> ```

> **Note:** The script is re-runnable. If it pauses for SSH key setup, add the key to
> [GitHub SSH settings](https://github.com/settings/keys), then run the command again.

## Updating configs

After making changes to iTerm2, zsh, or git settings locally:

```bash
cd ~/mac-iterm2-setup
plutil -convert xml1 -o iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
cp ~/.zshrc zsh/.zshrc
cp ~/.p10k.zsh zsh/.p10k.zsh
cp ~/.gitconfig git/.gitconfig
cp ~/.vimrc vim/.vimrc
cp ~/.tmux.conf tmux/.tmux.conf
cp ~/.claude/statusline-command.sh claude/statusline-command.sh
git add -A && git commit -m "Update configs" && git push
```
