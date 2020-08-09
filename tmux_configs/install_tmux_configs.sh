#!/bin/sh

# delete old tmux configs
rm -rf ~/.tmux*
cp -rf .tmux ~/
ln -s -f .tmux/.tmux.conf  ~/.tmux.conf
cp -rf .tmux.conf.local ~/

cp -rf plugins ~/.tmux/

tmux source ~/.tmux.conf
