#!/bin/sh

fish_path=$(which fish)
echo $fish_path | sudo tee -a /etc/shells
chsh -s $fish_path
fish
curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
