# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# z-shell/zi
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

# Homebrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Prompt
zi ice depth=1; zi light romkatv/powerlevel10k

# Lib Snippets
zi for \
  OMZL::clipboard.zsh \
  OMZL::history.zsh

# Plugin Snippets
zi wait silent for \
  OMZP::copybuffer \
  OMZP::copyfile \
  OMZP::copypath \
  OMZP::dirhistory \
  OMZP::nvm \
  OMZP::rbenv \
  OMZP::ssh-agent

# Completions
zi wait lucid light-mode for \
  id-as"kubectl" has"kubectl" as"completion" \
    atclone="kubectl completion zsh > _kubectl" \
    atpull"%atclone" nocompile blockf z-shell/null

# Plugins
zi wait lucid depth=1 light-mode for \
  ael-code/zsh-colored-man-pages \
  z-shell/H-S-MW

zi wait lucid depth=1 light-mode for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Fix comments
setopt interactivecomments

# Key Bindings
bindkey "${key[Up]}" up-line-or-search
bindkey "${key[Down]}" down-line-or-search
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'

alias cls=clear
alias gap="git add . && git commit --amend --no-edit && git push --force"
alias dockerclean="docker system prune -a"
alias k="kubectl"
alias t="transmission-cli -u 0 -w ~/downloads"

# Exports
if [ -f ~/token.sh ]; then
  source ~/token.sh
fi

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

export GOPROXY="https://nobody:$GITHUB_TOKEN@goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB='github.com/github/*'

export PATH=$HOME/.istioctl/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
