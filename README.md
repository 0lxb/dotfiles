# dotfiles
person dotfiles
```
git clone https://github.com/0lxb/dotfiles.git
cd dotfiles
git submodule update --init --recursive
```
### .vimrc

```
mkdir ~/.vim
mkdir ~/.vim/autoload/

cp -rf vim/.vimrc ~/
cp -rf vim/plug.vim ~/.vim/autoload/
```
### nvim

* dependency
```
lazygit
ripgrep
```
```
git clone https://github.com/0lxb/nvimdots.git ${HOME}/.config/nvim
```
### tmux configuration
[tmux source code](https://fossies.org/linux/misc/tmux-3.1b.tar.gz)
```
cd tmux_configs
sh install_tmux_configs.sh
```
### git
```
cp .gitconfig ~/
```
