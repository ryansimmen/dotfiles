git config --global user.name "Ryan Simmen"
git config --global user.email "ryansimmen@github.com"
git config --global pager.branch false
git config --global push.default current

mkdir -p ~/.vim/colors
cp ~/dotfiles/.vim/colors/molokai.vim ~/.vim/colors/
ln -s ~/dotfiles/.zshrc ~/
ln -s ~/dotfiles/.vimrc ~/

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qall

# zsh 
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    sudo apt install -y zsh
    zsh
fi;
