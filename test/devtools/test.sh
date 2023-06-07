#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'hello' feature with no options.
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "hello": {}
#    }
# }
#
# Thus, the value of all options will fall back to the default value in
# the feature's 'devcontainer-feature.json'.
# For the 'hello' feature, that means the default favorite greeting is 'hey'.
#
# These scripts are run as 'root' by default. Although that can be changed
	# with the --remote-user flag.
	#
	# This test can be run with the following command (from the root of this repo)
	#    devcontainer features test --features devtools --base-image mcr.microsoft.com/devcontainers/base:ubuntu .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "fzf folder exist" ls ~/.fzf
check "oh my zsh folder exist" ls ~/.oh-my-zsh
check "zsh histroy exist" ls -ld /dc/shellhistory
check "zsh-autosggestion exist" ls -ld ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
check "zsh plugins are added" cat ~/.zshrc | grep "plugins=("
check "pk10 theme file exist" ls ~/.p10k.zsh ~/powerlevel10k
check "powerlevel10 enabled on zsh" cat ~/.zshrc | grep "source ~/powerlevel10k/powerlevel10k.zsh-theme"
check "kubectl is well installed" kubectl version --client
check "check krew PATH well added on shell"  cat ~/.zshrc | grep "/.krew"
check "kubectl krew plugin manager is well installed" . ~/.bashrc && kubectl krew version
check "kubectl stern plugin is well installed" . ~/.bashrc && kubectl stern -v
check "kubectl fuzzy plugin is well installed" . ~/.bashrc && kubectl fuzzy version
check "kubectl images plugin is well installed" . ~/.bashrc && kubectl images --version
check "kubectl iexec plugin is well installed" . ~/.bashrc && kubectl iexec --help

check "clium cli is well installed" command -v cilium
check "helm is well installed" command -v helm
check "flux cli is well installed" command -v flux

# check "AWS cli is well installed" command -v aws
# check "AWS shell is well installed" command -v aws-shell

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
