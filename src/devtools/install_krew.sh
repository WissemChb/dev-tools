
(
set -x; cd "$(mktemp -d)" &&
OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
KREW="krew-${OS}_${ARCH}" &&
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
tar zxvf "${KREW}.tar.gz" &&
./"${KREW}" install krew
)
echo 'export PATH="$HOME/.krew/bin:$PATH"' | tee -a $HOME/.zshrc $HOME/.bashrc

export ALL_KUBECTL_PLUGINS="stern fuzzy iexec images ktop $(echo $1 | tr '[,;|]' ' ' | tr -s ' ' )" && \

. $HOME/.zshrc $HOME/.bashrc

/usr/local/bin/kubectl krew update
/usr/local/bin/kubectl krew install ${ALL_KUBECTL_PLUGINS}
