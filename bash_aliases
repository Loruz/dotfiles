alias gs="git status"
alias push="git push"
alias gc="git checkout"
alias dev="gc dev"
alias master="gc master"
alias pull="git pull"
alias add="git add ."
alias fpull="dev && pull && master && pull"
alias rebuild="npm install && npm run dev"
alias f="git flow feature start"
alias h="git flow hotfix start"
alias ff="git flow feature finish"
alias hf="git flow hotfix finish -n"
alias aliases="vim ~/.bash_aliases"
alias sr="source ~/.zshrc"
alias aa="aliases && sr"
alias gcom="git commit -m "
alias add="git add ."
alias tag="git fetch --tags && git tag -l --sort=-creatordate | head -1"
alias php71="phpv php@7.1"
alias php72="phpv php@7.2"
alias php73="phpv php"
alias ptags="git push --tags"
alias a="php artisan"
alias fetch="git fetch"
alias rstart="git flow release start"
alias rfinish="git flow release finish -n"

