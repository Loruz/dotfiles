# ── Git ───────────────────────────────────────────────────────────────────────
alias gs="git status"
alias status="git status"
alias push="git push"
alias pull="git pull"
alias fetch="git fetch"
alias add="git add ."
alias glog="git log --all --oneline --decorate --graph"
alias gcom='git commit -m'
alias gc="git checkout"

# ── Git branches ──────────────────────────────────────────────────────────────
alias dev="git checkout dev"
alias master="git checkout master"
alias main="git checkout main"
alias fpull="git checkout dev && git pull && git checkout master && git pull && git checkout dev"

# ── Git flow ──────────────────────────────────────────────────────────────────
alias f="git flow feature start"
alias h="git flow hotfix start"
alias ff="git flow feature finish"
alias hf="git flow hotfix finish -n"

# ── Package managers ──────────────────────────────────────────────────────────
alias p="pnpm"
alias b="bun"
alias rebuild="npm install && npm run dev"

# ── Shell config ──────────────────────────────────────────────────────────────
alias aliases="vim ~/.bash_aliases"
alias sr="source ~/.zshrc"
alias aa="aliases && sr"
