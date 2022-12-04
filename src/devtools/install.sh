#!/usr/bin/env bash

# Install packages
install_pkg(){
	if command -v apt > /dev/null 2>&1
	then
		apt update -y
		apt install -y $@
	elif command -v yum > /dev/null 2>&1
	then
		yum update -y
		yum install -y $@
	elif  command -v apk > /dev/null 2>&1 
	then
		apk add $@
	else
		echo "Linux distribution not supported"
	fi
}

install_pkg curl git

# Install FZF
if [ ! -d $_REMOTE_USER_HOME/.fzf ]
then
	echo "Install FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git $_REMOTE_USER_HOME/.fzf && $_REMOTE_USER_HOME/.fzf/install --all
fi

# Install and setup zsh and powerlevel10k
if [ ! -d $_REMOTE_USER_HOME/.oh-my-zsh ]
then
	echo "Install OH MY ZSH"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d $_REMOTE_USER_HOME/powerlevel10k ]
then
	echo "Install P10K"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $_REMOTE_USER_HOME/powerlevel10k
	echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> $_REMOTE_USER_HOME/.zshrc
	cp ./.p10k.zsh $_REMOTE_USER_HOME/.p10k.zsh
fi
