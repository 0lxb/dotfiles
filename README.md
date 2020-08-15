# dotfiles
person dotfiles
```
git clone https://github.com/0lxb/dotfiles.git
cd dotfiles
git submodule update --init --recursive
```

### .vimrc
```
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### tmux configuration
[tmux source code](https://fossies.org/linux/misc/tmux-3.1b.tar.gz)
```
cd tmux_configs
sh install_tmux_configs.sh
```
