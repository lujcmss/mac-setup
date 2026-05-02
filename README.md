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
| `claude/settings.json` | Global settings (statusLine, effortLevel, theme, dangerous-mode prompt skip) |
| `claude/settings.local.json` | Per-machine bash permission allowlist |
| `claude/statusline-command.sh` | Status line script (dir + git, model + effort, ctx %, rate limits, cost) |
| `claude/commands/*.md` | Custom slash commands (e.g. `/mac-setup`) |

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
10. Symlink Claude config: `settings.json`, `settings.local.json`, `statusline-command.sh`, and any slash commands in `claude/commands/`. Existing real files are backed up as `*.pre-mac-setup.bak` before the symlinks are created.
11. Import iTerm2 preferences
12. Verify GitHub CLI authentication

## Updating configs

Most files in this repo are symlinked to their `$HOME` location, so edits made via your editor (or `/config` for Claude Code) flow directly into the repo. To publish changes:

```bash
cd ~/mac-setup
git add -A && git commit -m "Update configs" && git push
```

The one exception is the iTerm2 plist, which iTerm2 writes to `~/Library/Preferences/` directly (not via symlink). Sync it back manually when you've changed iTerm2 preferences:

```bash
plutil -convert xml1 -o ~/mac-setup/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```
