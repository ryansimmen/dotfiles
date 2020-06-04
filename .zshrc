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

# Key Bindings
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Aliases
alias cls=clear
alias src="cd ~/enterprise2;"
alias r="src; chroot-stop.sh; chroot-reset.sh; chroot-cluster-stop.sh; chroot-cluster-reset.sh test/cluster.conf; chroot-cluster-reset.sh test/cluster-ha.conf; chroot-cluster-reset.sh test/cluster-dr.conf;"
alias b="src; r; chroot-build.sh && chroot-start.sh && chroot-configure.sh"
alias bc="src; r; chroot-build.sh && chroot-cluster-start.sh test/cluster.conf"
alias gap="src; git add . && git commit --amend --no-edit && git push --force"
alias cip="chroot-cluster-ip.sh"
alias sshc="chroot-ssh.sh"
alias sshp="chroot-cluster-ssh.sh build-ha-primary"
alias sshr="chroot-cluster-ssh.sh build-ha-replica"
alias sshd="chroot-cluster-ssh.sh build-cluster-data"
alias ssha="chroot-cluster-ssh.sh build-cluster-app"

# enterprise2
export PATH=~/enterprise2:$PATH
export DEV_MODE=1
#export GHE_LXC_NAME=ghe-dev-$(id -un)
#export OVERLAY_VM_FILES=no

src;
