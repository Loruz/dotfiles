# dotfiles

Personal macOS development environment. One command to go from a fresh Mac to a fully configured setup.

---

## Fresh Mac Setup

### Step 1 — Sign in to iCloud & App Store

Before running anything, sign in to the App Store. Some Mac apps (like Xcode tools) require it.

### Step 2 — Install Xcode Command Line Tools

macOS doesn't ship with git or compilers. Open Terminal and run:

```bash
xcode-select --install
```

A dialog will appear. Click **Install** and wait for it to finish (~5 min). This is required before Homebrew can install anything.

### Step 3 — Clone and run setup

```bash
git clone https://github.com/Loruz/dotfiles.git ~/dotfiles
bash ~/dotfiles/setup.sh
```

That's it. The script is interactive only for:
- **Homebrew** — may ask for your Mac password (sudo) to install
- **rustup** — type `1` when prompted (default installation)
- **chsh** — may ask for your password to change the default shell

### Step 4 — Restart Terminal

Close and reopen Terminal (or open a new tab). You should see the agnoster zsh prompt.

---

## What `setup.sh` Does

In order:

| Step | What happens |
|------|-------------|
| 1 | Installs Homebrew (if not present), handles both Apple Silicon `/opt/homebrew` and Intel `/usr/local` |
| 2 | Clones this repo to `~/dotfiles` (skipped if already there) |
| 3 | Runs `brew bundle` to install all packages from `brewfile` |
| 4 | Installs oh-my-zsh + the `per-directory-history` custom plugin |
| 5 | Symlinks `~/.zshrc` and `~/.bash_aliases` to this repo |
| 6 | Symlinks VS Code settings and keybindings from this repo |
| 7 | Symlinks Cursor settings and keybindings from this repo |
| 8 | Installs Node.js LTS via nvm, sets it as default |
| 9 | Installs Rust via rustup |
| 10 | Installs Claude Code globally (`npm install -g @anthropic-ai/claude-code`) |
| 11 | Sets zsh as the default shell |

---

## What Gets Installed

### Homebrew packages (`brewfile`)

| Package | Purpose |
|---------|---------|
| `git` | Version control |
| `git-flow` | Git flow branching model |
| `go` | Go language |
| `pyenv` | Python version manager |
| `nvm` | Node.js version manager |
| `pnpm` | Fast Node package manager |
| `bun` | All-in-one JS runtime & package manager |
| `gh` | GitHub CLI |
| `fzf` | Fuzzy finder (history search, file search) |
| `ripgrep` | Fast grep (used by editors and Claude Code) |

### Installed by setup.sh directly

| Tool | How |
|------|-----|
| Node.js LTS | `nvm install --lts` |
| Rust + Cargo | `rustup` curl script |
| Claude Code | `npm install -g @anthropic-ai/claude-code` |
| oh-my-zsh | curl installer |

---

## After Setup: Manual Steps

Some things can't be automated and need to be done by hand.

### Install apps

The setup doesn't install GUI apps. Install these manually:

- **Cursor** — [cursor.com](https://cursor.com) (AI code editor)
- **VS Code** — [code.visualstudio.com](https://code.visualstudio.com) (optional if using Cursor)
- **1Password** — App Store or [1password.com](https://1password.com)
- **Raycast** or Spotlight replacement of your choice

### Set up SSH keys

```bash
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub | pbcopy
```

Then add the key to [GitHub SSH settings](https://github.com/settings/keys).

### Set up Git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### Authenticate GitHub CLI

```bash
gh auth login
```

Follow the prompts — choose GitHub.com, HTTPS, and authenticate via browser.

### Install Python version

```bash
pyenv install 3.13   # or whatever current stable is
pyenv global 3.13
```

Check available versions: `pyenv install --list | grep "^  3\."`.

### Set up Claude Code

```bash
claude login
```

This opens a browser to authenticate with your Anthropic account.

### Install Cursor extensions

Open Cursor and install extensions from the Extensions panel. Key ones:
- Prettier (esbenp.prettier-vscode)
- ESLint
- Tailwind CSS IntelliSense
- Astro
- Vue - Official (Volar)
- Prisma
- GitLens or Git Graph

### Install the Ayu Mirage Bordered theme

The settings.json references `Ayu Mirage Bordered`. Install it via Extensions → search "Ayu".

---

## Repository Structure

```
dotfiles/
├── setup.sh              # Run this once on a new Mac
├── brewfile              # Homebrew packages
├── zshrc                 # Zsh config (symlinked to ~/.zshrc)
├── bash_aliases          # Shell aliases (symlinked to ~/.bash_aliases)
├── VisualStudio/
│   ├── settings.json     # Shared by VS Code and Cursor
│   └── keybindings.json  # Shared by VS Code and Cursor
└── README.md
```

Symlinks created by `setup.sh`:
- `~/.zshrc` → `~/dotfiles/zshrc`
- `~/.bash_aliases` → `~/dotfiles/bash_aliases`
- `~/Library/Application Support/Code/User/settings.json` → `~/dotfiles/VisualStudio/settings.json`
- `~/Library/Application Support/Code/User/keybindings.json` → `~/dotfiles/VisualStudio/keybindings.json`
- `~/Library/Application Support/Cursor/User/settings.json` → `~/dotfiles/VisualStudio/settings.json`
- `~/Library/Application Support/Cursor/User/keybindings.json` → `~/dotfiles/VisualStudio/keybindings.json`

Because these are symlinks, editing any file in this repo immediately takes effect in the shell and editors — no copy step needed.

---

## Shell Aliases

### Git

| Alias | Command |
|-------|---------|
| `gs` / `status` | `git status` |
| `push` | `git push` |
| `pull` | `git pull` |
| `fetch` | `git fetch` |
| `add` | `git add .` |
| `gc` | `git checkout` |
| `gcom 'msg'` | `git commit -m 'msg'` |
| `glog` | Pretty graph log |

### Branches

| Alias | Command |
|-------|---------|
| `dev` | `git checkout dev` |
| `master` | `git checkout master` |
| `main` | `git checkout main` |
| `fpull` | Pull dev and master |

### Git Flow

| Alias | Command |
|-------|---------|
| `f <name>` | `git flow feature start <name>` |
| `ff <name>` | `git flow feature finish <name>` |
| `h <name>` | `git flow hotfix start <name>` |
| `hf <name>` | `git flow hotfix finish -n <name>` |

### Package managers

| Alias | Command |
|-------|---------|
| `p` | `pnpm` |
| `b` | `bun` |
| `rebuild` | `npm install && npm run dev` |

### Config

| Alias | What it does |
|-------|-------------|
| `sr` | Reload zshrc (`source ~/.zshrc`) |
| `aliases` | Open bash_aliases in vim |
| `aa` | Open aliases in vim, then reload zshrc |

---

## Keybindings (Cursor / VS Code)

| Key | Action |
|-----|--------|
| `Cmd+D` | Delete line |
| `Cmd+E` | Next find match / add to multi-select |
| `Shift+Cmd+D` | Duplicate line down |
| `Shift+Cmd+Up` | Move line up |
| `Shift+Cmd+Down` | Move line down |
| `Shift+Cmd+N` | Quick open file (`Cmd+P` equivalent) |
| `Shift+Cmd+=` | Command palette (`Cmd+Shift+P` equivalent) |
| `Shift+Cmd+T` | Toggle terminal |
| `Cmd+I` | Open Cursor composer (agent mode) |

---

## Keeping Dotfiles Updated

To sync a change from your machine back to the repo:

```bash
cd ~/dotfiles
git add -A
git commit -m "your message"
git push
```

To pull updates onto another machine:

```bash
cd ~/dotfiles
git pull
# No extra steps needed — symlinks mean files are already live
```

To add a new Homebrew package permanently:

```bash
# Edit brewfile, then:
brew bundle --file=~/dotfiles/brewfile
```

To add a new alias:

```bash
aa   # opens bash_aliases in vim and reloads on save+exit
```
