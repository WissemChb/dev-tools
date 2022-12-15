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
chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.zshrc

# Fix zsh shellhistory
if [ -f /dc/shellhistory/.zsh_history ]
then
    mv /dc/shellhistory/.zsh_history /dc/shellhistory/.zsh_history_bad
    strings -eS /dc/shellhistory/.zsh_history_bad > /dc/shellhistory/.zsh_history
    fc -r /dc/shellhistory/.zsh_history
    rm -f /dc/shellhistory/.zsh_history_bad
fi

# Install FZF
if [[ ! -d $_REMOTE_USER_HOME/.fzf ]]
then
    su $_REMOTE_USER -c "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all"
fi