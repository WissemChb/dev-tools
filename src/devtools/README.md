
# devtools (devtools)

Preinstall devcontainer and setup dev prerequisites for cloud native and SRE environments

## Example Usage

```json
"features": {
    "ghcr.io/WissemChb/dev-tools/devtools:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| zsh_plugins | The ZSH plugins used to enhance commands running | string | - |
| kubectl_plugins | The kubectl plugins used to enhance operations on the cluster | string | - |
| kubectl_version | The kubectl version | string | latest |
| gloo_version | The Gloo CTL version | string | - |
| p10k | Enable p10k installation | boolean | true |
| cn | The installation of Cloud Native plugin | boolean | true |
| aws | The installation of AWS Cloud | boolean | false |
| aws_version | AWS CLI version | string | - |

## Customizations

### VS Code Extensions

- `mads-hartmann.bash-ide-vscode`
- `docsmsft.docs-yaml`
- `eamodio.gitlens`
- `donjayamanne.githistory`
- `GitHub.vscode-pull-request-github`
- `codezombiech.gitignore`
- `bierner.github-markdown-preview`
- `github.vscode-github-actions`
- `GitHub.remotehub`
- `TeamHub.teamhub`
- `ms-kubernetes-tools.vscode-kubernetes-tools`
- `sourcegraph.sourcegraph`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/WissemChb/dev-tools/blob/main/src/devtools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
