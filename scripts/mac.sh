#!/bin/sh

sudo nvram SystemAudioVolume=0
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.finder AppleShowAllFiles TRUE
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 28
killall Dock