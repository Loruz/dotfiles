# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal macOS dotfiles for shell configuration, package management, and editor settings. Clone to `~/dotfiles` and run `setup.sh` once to get a full development environment.

## Fresh Machine Setup

```bash
git clone https://github.com/Loruz/dotfiles.git ~/dotfiles
bash ~/dotfiles/setup.sh
```

## Architecture

**Symlink System**: `setup.sh` creates symlinks for shell config and editor settings:
- `~/.zshrc` → `~/dotfiles/zshrc`
- `~/.bash_aliases` → `~/dotfiles/bash_aliases`
- `~/Library/Application Support/Code/User/settings.json` → `~/dotfiles/VisualStudio/settings.json`
- `~/Library/Application Support/Code/User/keybindings.json` → `~/dotfiles/VisualStudio/keybindings.json`
- `~/Library/Application Support/Cursor/User/settings.json` → `~/dotfiles/VisualStudio/settings.json`
- `~/Library/Application Support/Cursor/User/keybindings.json` → `~/dotfiles/VisualStudio/keybindings.json`

Changes to files in this repo automatically affect the active shell and both VS Code and Cursor.

**Configuration Chain**:
1. `zshrc` loads oh-my-zsh (agnoster theme)
2. `zshrc` configures NVM, pyenv, Go, Rust/cargo, pnpm, bun paths
3. `zshrc` sources `bash_aliases` for git and workflow shortcuts

## Making Configuration Changes

**To modify shell aliases**:
- Edit `bash_aliases` directly
- Run `sr` (source ~/.zshrc) or `aa` (edit aliases + reload) to apply

**To update installed packages**:
- Edit `brewfile`
- Run `brew bundle --file=~/dotfiles/brewfile`

**Editor settings** (VS Code and Cursor share the same source):
- Settings: `VisualStudio/settings.json`
- Keybindings: `VisualStudio/keybindings.json`

## Development Environment Stack

- **Python**: pyenv for version management
- **Node.js**: nvm (installed via brew)
- **Go**: installed via brew, GOPATH at ~/go
- **Rust**: rustup (installed via curl script during setup)
- **Package managers**: pnpm, bun, npm
- **CLI tools**: gh (GitHub CLI), fzf, ripgrep, git-flow
- **AI**: Claude Code (`claude` CLI, installed globally via npm)

## Common Aliases

```
gs / status      git status
push             git push
pull             git pull
add              git add .
gcom             git commit -m
gc               git checkout
glog             git log (graph)
dev/master/main  git checkout <branch>
fpull            pull both dev and master
f / ff           git flow feature start/finish
h / hf           git flow hotfix start/finish
p                pnpm
b                bun
rebuild          npm install && npm run dev
sr               source ~/.zshrc
aliases          open ~/.bash_aliases in vim
aa               open aliases + reload zshrc
```
