#!/usr/bin/env bash

cat ~/.gitconfig |grep '\[safe\]' > /dev/null 2>&1 || printf '[safe]\n\tdirectory = /workspaces/dev-tools' >> ~/.gitconfig