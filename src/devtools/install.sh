#!/usr/bin/env bash

# Install packages
# install_pkg(){
# 	if command -v apt > /dev/null 2>&1
# 	then
# 		apt update -y
# 		apt install -y $@
# 	elif command -v yum > /dev/null 2>&1
# 	then
# 		yum update -y
# 		yum install -y $@
# 	elif  command -v apk > /dev/null 2>&1 
# 	then
# 		apk add $@
# 	else
# 		echo "Linux distribution not supported"
# 	fi
# }

# install_pkg curl git

# Configure ZSH shell history
cat << EOF >> "$_REMOTE_USER_HOME/.zshrc"
export HISTFILE=/dc/shellhistory/.zsh_history
export PROMPT_COMMAND='history -a'
sudo chown -R $_REMOTE_USER /dc/shellhistory
EOF
chown -R "$_REMOTE_USER" "$_REMOTE_USER_HOME"/.zshrc

# Install FZF
if [ ! -d $_REMOTE_USER_HOME/.fzf ]
then
    su "$_REMOTE_USER" -c "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all"
fi

if [ ! -f ${ZSH_CUSTOM:-"$_REMOTE_USER_HOME"/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-"$_REMOTE_USER_HOME"/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

ALL_ZSH_PLUGINS="encode64 extract urltools zsh-interactive-cd zsh-autosuggestions command-not-found $(echo $ZSH_PLUGINS | tr '[,;|]' ' ' | tr -s " " )"
sed -i -re "s/(plugins=\(git)(\))/\1 $ALL_ZSH_PLUGINS\2/" "$_REMOTE_USER_HOME"/.zshrc
