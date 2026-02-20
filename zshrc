export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  git-flow
  npm
  history
  per-directory-history
  colored-man-pages
  colorize
  extract
  brew
  node
)

source $ZSH/oh-my-zsh.sh

# ── NVM ───────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# ── pyenv ─────────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi

# ── Go ────────────────────────────────────────────────────────────────────────
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# ── Rust / Cargo ──────────────────────────────────────────────────────────────
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ── pnpm ──────────────────────────────────────────────────────────────────────
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ── bun ───────────────────────────────────────────────────────────────────────
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ── Personal bin ──────────────────────────────────────────────────────────────
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# ── Agnoster: suppress username in local sessions ─────────────────────────────
DEFAULT_USER=$(whoami)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# ── Aliases ───────────────────────────────────────────────────────────────────
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
