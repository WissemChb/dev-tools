#!/usr/bin/env bash

set -xe


if [ $AWS == "true" ]
then
	# Install AWS cli
	if [ ! -z $AWS_VERSION ]
	then
		VERSION=-$AWS_VERSION
	fi
	curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m)$VERSION.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install

	echo "export AWS_CLI_AUTO_PROMPT=on-partial"  | tee -a $_REMOTE_USER_HOME/.zshrc $_REMOTE_USER_HOME/.bashrc
	echo "complete -C '/usr/local/bin/aws_completer' aws" | tee -a $_REMOTE_USER_HOME/.zshrc $_REMOTE_USER_HOME/.bashrc

	# Install AWS-shell
	pip install aws-shell

fi