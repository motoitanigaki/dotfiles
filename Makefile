SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: brew bash git npm ruby packages link

packages: brew-packages cask-apps node-packages

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | sudo bash

bash: BASH=/usr/local/bin/bash
bash: SHELLS=/private/etc/shells
bash: brew
	brew install bash bash-completion@2 pcre && \
	sudo append $(BASH) $(SHELLS) && \
	chsh -s $(BASH); \

git: brew
	brew install git git-extras

npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

ruby: brew
	brew install ruby

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
	xattr -d -r com.apple.quarantine ~/Library/QuickLook

node-packages: npm
	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)

test:
	. $(NVM_DIR)/nvm.sh; bats test