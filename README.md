# Helm Package action
GitHub action to run helm package for a chart or all charts in a given directory.

## Usage

```
action "Package stable charts" {
  uses = "flydiverny/helm-package-action@master"
  args = "./stable"
}
```
