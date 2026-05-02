# Mac Setup

Personal Mac development environment — one command to set up a fresh machine with all my dotfiles, tools, and preferences.

## Quick start (fresh Mac)

```bash
curl -fsSL https://raw.githubusercontent.com/lujcmss/mac-setup/main/scripts/bootstrap.sh | bash
```

This single command installs Homebrew, generates an SSH key (pause to add to GitHub), clones this repo, and runs `setup.sh`. The script is re-runnable — if it pauses for SSH key setup, add the key to [GitHub SSH settings](https://github.com/settings/keys) and run it again.

## What's included

### Terminal & Shell
| Path | Contents |
|------|----------|
| `iterm2/com.googlecode.iterm2.plist` | iTerm2 preferences (gruvbox theme, profiles, keybindings) |
| `zsh/.zshrc` | Oh My Zsh + Powerlevel10k config |
| `zsh/.p10k.zsh` | Powerlevel10k theme settings |
| `tmux/.tmux.conf` | tmux config (mouse support enabled) |

### Editors
| Path | Contents |
|------|----------|
| `vim/.vimrc` | Vim config (syntax, indentation, search, UI, clipboard, mouse) |

### Version Control
| Path | Contents |
|------|----------|
| `git/.gitconfig` | Git user identity and aliases |
| `ssh/` | SSH config templates (key generation handled by bootstrap) |

### Claude Code
| Path | Contents |
|------|----------|
| `claude/statusline-command.sh` | Status line script (dir + git, model + effort, ctx %, rate limits, cost) |

### Package Management
| Path | Contents |
|------|----------|
| `Brewfile` | Homebrew packages: iTerm2, MesloLGS Nerd Font, gh, tmux, node@22, python@3.11, go |

### Setup Scripts
| Path | Contents |
|------|----------|
| `scripts/bootstrap.sh` | Fresh-Mac entry point (Homebrew → git → SSH → clone → setup) |
| `scripts/setup.sh` | Post-clone: brew bundle, Oh My Zsh, Powerlevel10k, symlink dotfiles |

## Setup steps (what `setup.sh` does)

1. Install Homebrew (if missing)
2. Install all brew packages from `Brewfile`
3. Install Oh My Zsh (if missing)
4. Install Powerlevel10k (if missing)
5. Symlink `.gitconfig`
6. Symlink `.zshrc` and `.p10k.zsh`
7. Symlink `.vimrc`
8. Symlink `.tmux.conf`
9. Install Claude Code (`curl -fsSL https://claude.ai/install.sh | bash`; auto-upgrades on re-runs)
10. Symlink Claude statusline to `~/.claude/statusline-command.sh` and create `~/.claude/settings.json` with the `statusLine` entry (only if the file doesn't exist; otherwise the existing settings are left alone)
11. Import iTerm2 preferences
12. Verify GitHub CLI authentication

## Updating configs

After tweaking settings locally, sync them back:

```bash
cd ~/mac-setup
plutil -convert xml1 -o iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
cp ~/.zshrc zsh/.zshrc
cp ~/.p10k.zsh zsh/.p10k.zsh
cp ~/.gitconfig git/.gitconfig
cp ~/.vimrc vim/.vimrc
cp ~/.tmux.conf tmux/.tmux.conf
cp ~/.claude/statusline-command.sh claude/statusline-command.sh
git add -A && git commit -m "Update configs" && git push
```
