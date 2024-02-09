#!/usr/bin/env bash

set -xe

# Prepare k8s version

if [ $KUBECTL_VERSION != "" ] && [ $KUBECTL_VERSION != "latest" ]
then
  kubectl_version=$KUBECTL_VERSION
else
  kubectl_version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
fi

# Install Kubectl
curl -LO "https://dl.k8s.io/release/${kubectl_version}/bin/linux/${ARCH}/kubectl" --output-dir /usr/local/bin/
chmod +x /usr/local/bin/kubectl
kubectl completion zsh > ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions/_kubectl

# # Install Krew
/bin/su -c "$(pwd)/install_krew.sh ${KUBECTL_PLUGINS}" - $_REMOTE_USER

echo 'alias k=kubectl' | tee -a $_REMOTE_USER_HOME/.zshrc $_REMOTE_USER_HOME/.bashrc 
echo 'complete -o default -F __start_kubectl k' | tee -a $_REMOTE_USER_HOME/.zshrc $_REMOTE_USER_HOME/.bashrc

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm completion zsh > ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions/_helm

# Install Flux
curl -s https://fluxcd.io/install.sh | sudo bash 
flux completion zsh > ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions/_flux

# Install Cilium
(
  CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
  curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${ARCH}.tar.gz{,.sha256sum}
  sha256sum --check cilium-linux-${ARCH}.tar.gz.sha256sum
  sudo tar xzvfC cilium-linux-${ARCH}.tar.gz /usr/local/bin
  rm cilium-linux-${ARCH}.tar.gz{,.sha256sum}
)
cilium completion zsh > ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions/_cilium
 

# Setup Gloo
if [ -n "$GLOO_VERSION"  ]
then 
  if [ "$GLOO_VERSION" == "latest" ]
  then
    gloo_version=$(curl -sH"Accept: application/vnd.github.v3+json" https://api.github.com/repos/solo-io/gloo/releases/latest | jq -r '.tag_name')
  else
    gloo_version=$GLOO_VERSION
  fi

  curl -LO https://github.com/solo-io/gloo/releases/download/${gloo_version}/glooctl-${OS}-${ARCH} --output-dir /usr/local/bin/
  mv /usr/local/bin/glooctl-${OS}-${ARCH} /usr/local/bin/glooctl
  chmod +x /usr/local/bin/glooctl
  sudo apt clean
  sudo apt install -y file
  file /usr/local/bin/glooctl
  glooctl completion zsh > ${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/completions/_glooctl
fi