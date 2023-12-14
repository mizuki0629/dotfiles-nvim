# dotfiles nvim
dotfiles for nvim

## install
The installation can be done in several ways.

### 1. copy
copy dotfiles to your home dirctory
```sh
copy -r /path/to/repository/.config/nvim .config/nvim
```

### 2. rrcm
[rrcm](https://github.com/mizuki0629/rrcm) is cross platform dotfiles management and deploy tool.

edit your .config/rrcm/config.yaml
```yaml
---
dotfiles:
  windows: "%USERPROFILE%\\dotfiles"
  mac: "${HOME}/.dotfiles"
  linux: "${HOME}/.dotfiles"
repos:
# add config for this repository
  - name: graphical
    url: 'https://github.com/mizuki0629/dotfiles-nvim.git'
    deploy:
      .config:
        windows: "%FOLDERID_LocalAppData%"
        mac: "${XDG_CONFIG_HOME}"
        linux: "${XDG_CONFIG_HOME}"
```

clone and deploy
```sh
rrcm update
```

## Plugins
see [plugins.lua](https://github.com/mizuki0629/dotfiles-nvim/blob/main/.config/nvim/lua/plugin.lua)
