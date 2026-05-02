Set up a fresh Mac with my dev environment using my config repo.

## Quick start (one command)

```bash
curl -fsSL https://raw.githubusercontent.com/lujcmss/mac-setup/main/scripts/bootstrap.sh | bash
```

This handles everything in order:

1. Install Homebrew
2. Ensure git is available (Xcode CLT)
3. Generate SSH key + copy to clipboard (pauses to add to GitHub if needed)
4. Test GitHub SSH connection
5. Clone the config repo to ~/mac-setup
6. Install brew packages from Brewfile (iTerm2, Nerd Font, gh, tmux, node, python, go)
7. Install Oh My Zsh + Powerlevel10k
8. Symlink dotfiles (.gitconfig, .zshrc, .p10k.zsh, .vimrc, .tmux.conf, Claude statusline)
9. Import iTerm2 preferences (gruvbox theme, profiles, keybindings)
10. Prompt for `gh auth login` if needed

The script is re-runnable — if it exits for SSH setup, just re-run after adding the key to GitHub.

> **Claude Code statusline activation:** the script gets symlinked to `~/.claude/statusline-command.sh`.
> To activate, ensure `~/.claude/settings.json` contains:
> ```json
> "statusLine": { "type": "command", "command": "sh ~/.claude/statusline-command.sh" }
> ```

## Updating configs

When the user wants to save updated configs back to the repo:
- iTerm2 plist: `plutil -convert xml1 -o ~/mac-setup/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist`
- zshrc: `cp ~/.zshrc ~/mac-setup/zsh/.zshrc`
- p10k: `cp ~/.p10k.zsh ~/mac-setup/zsh/.p10k.zsh`
- gitconfig: `cp ~/.gitconfig ~/mac-setup/git/.gitconfig`
- vimrc: `cp ~/.vimrc ~/mac-setup/vim/.vimrc`
- tmux: `cp ~/.tmux.conf ~/mac-setup/tmux/.tmux.conf`
- Claude statusline: `cp ~/.claude/statusline-command.sh ~/mac-setup/claude/statusline-command.sh`
- Commit and push.
