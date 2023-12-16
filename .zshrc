### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
zinit ice silent pick"history.zsh"
zinit snippet OMZ::lib/history.zsh

zinit ice silent pick"completion.zsh"
zinit snippet OMZ::lib/completion.zsh

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice blockf
zinit light greymd/docker-zsh-completion

zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

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

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/ryansimmen/go/bin
eval "$(rbenv init -)"

# service docker status || sudo service docker start
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

source ~/token.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPROXY="https://nobody:$GITHUB_TOKEN@goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB='github.com/github/*'

export PATH=$HOME/.istioctl/bin:$PATH
