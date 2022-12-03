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
check "p10k folder exist" ls ~/powerlevel10k
check "enable p10k in zsh"  grep "source ~/powerlevel10k/powerlevel10k.zsh-theme" ~/.zshrc
check "check the .p10k.zsh exist"  ls ~/ | grep '.p10k.zsh'
# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
