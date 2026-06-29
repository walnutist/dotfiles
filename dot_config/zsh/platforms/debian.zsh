# =============================================================================
# platforms/debian.zsh — Debian / Ubuntu 平台差量
# 继承 base + master。Debian 特定:fd/bat 重命名 + apt + systemd。
# =============================================================================

# Debian 把 fd 装为 fdfind,bat 装为 batcat
if command -v fdfind &>/dev/null; then
    alias fd='fdfind'
fi
if command -v batcat &>/dev/null; then
    alias bat='batcat'
fi

# apt (master 没有,补)
if command -v apt-get &>/dev/null; then
    alias apt='sudo apt'
    alias apti='sudo apt install'
    alias apts='apt search'
    alias aptu='sudo apt update && sudo apt upgrade'
    alias aptrm='sudo apt remove'
    alias aptar='sudo apt autoremove'
fi

# systemd (Debian 10+ 默认 init)
alias svc='sudo systemctl status'
alias svc-start='sudo systemctl start'
alias svc-stop='sudo systemctl stop'
alias svc-restart='sudo systemctl restart'
alias svc-logs='sudo journalctl -u'
alias svc-list='systemctl list-units --type=service --state=running'

# nala 替代
if command -v nala &>/dev/null; then
    alias apt='sudo nala'
fi
