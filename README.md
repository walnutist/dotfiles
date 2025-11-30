```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:walnutist/dotfiles.git
#sh -c "$(curl -fsLS get.chezmoi.io/lb)"
#~/.local/bin/chezmoi init --promptChoice securityLevel=$SECURITY_LEVEL
#~/.local/bin/chezmoi apply
```
