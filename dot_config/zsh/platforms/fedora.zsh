# =============================================================================
# platforms/fedora.zsh — Fedora / RHEL 平台差量
# =============================================================================

# Fedora 把 fd-find 装为 fd-find
if command -v fd-find &>/dev/null && ! command -v fd &>/dev/null; then
    alias fd='fd-find'
fi

# dnf
if command -v dnf &>/dev/null; then
    alias dnfi='sudo dnf install'
    alias dnfs='dnf search'
    alias dnfup='sudo dnf upgrade'
    alias dnfrm='sudo dnf remove'
    alias dnfgr='sudo dnf group install'
    alias dnfl='dnf list installed'
fi

# systemd (Fedora 一贯)
alias svc='sudo systemctl status'
alias svc-start='sudo systemctl start'
alias svc-stop='sudo systemctl stop'
alias svc-restart='sudo systemctl restart'
alias svc-logs='sudo journalctl -u'
alias svc-list='systemctl list-units --type=service --state=running'

# firewall-cmd (Fedora 默认 firewalld,不是 ufw)
if command -v firewall-cmd &>/dev/null; then
    alias fw='sudo firewall-cmd --list-all'
    alias fw-allow='sudo firewall-cmd --permanent --add-service'
    alias fw-remove='sudo firewall-cmd --permanent --remove-service'
    alias fw-reload='sudo firewall-cmd --reload'
fi

# SELinux (Fedora 默认开启)
if command -v getenforce &>/dev/null; then
    alias selinux='getenforce'
    alias selinux-set='sudo setenforce'
fi
