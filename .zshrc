### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# Plugins
zinit ice silent pick"history.zsh"
zinit snippet OMZ::lib/history.zsh

zinit ice silent pick"completion.zsh"
zinit snippet OMZ::lib/completion.zsh

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice blockf
zinit light greymd/docker-zsh-completion

zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word
zinit light hcgraf/zsh-sudo
zinit light bric3/nice-exit-code
zinit light knu/z

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice from"gh-r" as"program"
zinit load derailed/k9s

# Key Bindings
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Aliases
alias cls=clear
alias src="cd ~/enterprise2"
alias r="src; chroot-stop.sh; chroot-reset.sh; sudo ./chroot-cluster-stop.sh; chroot-cluster-reset.sh test/cluster.conf; chroot-cluster-reset.sh test/cluster-ha.conf; chroot-cluster-reset.sh test/cluster-dr.conf; chroot-cluster-reset.sh test/cluster-dr-lite.conf;"
alias b="src; r; chroot-build.sh"
alias d="src; env -u GITHUB_HOSTNAME chroot-start.sh && chroot-configure.sh"
alias bd="b && d"
alias dc="src; env -u GITHUB_HOSTNAME chroot-cluster-start.sh test/cluster.conf"
alias bdc="b && dc"
alias dha="src; env -u GITHUB_HOSTNAME chroot-cluster-start.sh test/cluster-ha.conf"
alias bdha="b && dha"
alias dhaa="src; env -u GITHUB_HOSTNAME chroot-cluster-start.sh test/cluster-ha-active.conf"
alias bdhaa="b && dhaa"
alias dcdr="src; env -u GITHUB_HOSTNAME chroot-cluster-start.sh test/cluster-dr.conf"
alias bdcdr="b && dcdr"
alias dcdrl="src; env -u GITHUB_HOSTNAME chroot-cluster-start.sh test/cluster-dr-lite.conf"
alias bdcdrl="b && dcdrl"
alias gap="git add . && git commit --amend --no-edit && git push --force"
alias cip="chroot-cluster-ip.sh; chroot-ip.sh"
alias sshc="chroot-ssh.sh"
alias sshp="chroot-cluster-ssh.sh build-ha-primary"
alias sshdrp="chroot-cluster-ssh.sh build-dr-primary-main"
alias sshdrs="chroot-cluster-ssh.sh build-dr-secondary-main"
alias sshr="chroot-cluster-ssh.sh build-ha-replica"
alias sshr2="chroot-cluster-ssh.sh build-ha-replica2"
alias sshd="chroot-cluster-ssh.sh build-cluster-data"
alias ssha="chroot-cluster-ssh.sh build-cluster-app"
alias dockerclean="docker system prune -a"
alias sw="git update-index --skip-worktree pkg_files/github/db/schema.production.json.gz; git update-index --skip-worktree pkg_files/github/seed.sql"
alias nsw="git update-index --no-skip-worktree pkg_files/github/db/schema.production.json.gz; git update-index --no-skip-worktree pkg_files/github/seed.sql"

# enterprise2
export PATH=~/enterprise2:$PATH
export PATH=~/go/bin:$PATH
eval "$(rbenv init -)"
export GITHUB_HOSTNAME=$(hostname)
export DEV_MODE=1
export OVERLAY_VM_FILES=no

fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

src;

cd ~/ghae-kube

alias k="kubectl"
alias gp="k get pod"
alias dp="k describe pod"
alias a="script/apply"
alias dr="k delete -R -f rendered"
alias dpvc="k delete pvc --all"
alias dpv="k delete pv --all"
alias ddb="az mysql db delete -g ryansim -s azure-mysql-server-ryansim -n github_enterprise -y"
