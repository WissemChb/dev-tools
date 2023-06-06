#!/usr/bin/env bash

set -e

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

install_pkg curl git jq python3 openssl tar


# Install pip
curl -OL https://bootstrap.pypa.io/get-pip.py --output-dir /tmp
command -v python3 > /dev/null 2>&1 &&  ln -s $(command -v python3) /usr/local/bin/python
python /tmp/get-pip.py

#############################################################################################################################################
##################################################### Global configuration ##################################################################
#############################################################################################################################################

[ -d ${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-completions ] || git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-completions

[ -d ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions ] || mkdir ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions

# echo "complete -C '/usr/local/bin/aws_completer' aws" >> $HOME/.zshrc

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
    su "$_REMOTE_USER" -c "git clone --depth 1 https://github.com/junegunn/fzf.git $_REMOTE_USER_HOME/.fzf && $_REMOTE_USER_HOME/.fzf/install --all"
fi

if [ ! -f ${ZSH_CUSTOM:-"$_REMOTE_USER_HOME"/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-"$_REMOTE_USER_HOME"/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

ALL_ZSH_PLUGINS="encode64 extract urltools zsh-interactive-cd zsh-autosuggestions command-not-found $(echo $ZSH_PLUGINS | tr '[,;|]' ' ' | tr -s " " )"
sed -i -re "s/(plugins=\(git)(\))/\1 $ALL_ZSH_PLUGINS\2/" "$_REMOTE_USER_HOME"/.zshrc

#############################################################################################################################################
##################################################### Custom configuration ##################################################################
#############################################################################################################################################

# Install Powerlevel10k zsh theme
if [ ! -z $P10K ]
then
  bash p10k.sh
fi

# Install Cloud Native tools
if [ ! -z $CN ]
then
  bash setup_cntools.sh
fi

# Install AWS CLI
bash install_cloudcli.sh
