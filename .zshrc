if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Plugins
zi snippet OMZ::lib/history.zsh

zi wait lucid for \
  OMZP::nvm \
  OMZP::ssh-agent \
  OMZP::rbenv

zi light z-shell/F-Sy-H
zi light z-shell/H-S-MW
zi light zsh-users/zsh-autosuggestions

zi ice pick"async.zsh" src"pure.zsh"
zi light sindresorhus/pure

# Key Bindings
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Fix comments
setopt interactivecomments

# Aliases
alias cls=clear
alias gap="git add . && git commit --amend --no-edit && git push --force"
alias dockerclean="docker system prune -a"
alias k="kubectl"
alias t="transmission-cli -u 0 -w ~/downloads"

if [ -f ~/token.sh ]; then
  source ~/token.sh
fi

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

export GOPROXY="https://nobody:$GITHUB_TOKEN@goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB='github.com/github/*'

export PATH=$HOME/.istioctl/bin:$PATH
