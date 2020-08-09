# dotfiles
person dotfiles

### .vimrc
mkdir -p ~/.vim/bundle

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

### tmux configuration
cd tmux_configs

sh install_tmux_configs.sh
