# =============================================================================
# profiles/server-linode.zsh — 公网 VPS 差量
# 继承 base + platform。追加: 防火墙 / fail2ban / SSH 审计 / systemd
# 关键策略: 公网暴露,零 GUI,资源敏感
# =============================================================================

# --- 防火墙 (debian ufw / fedora firewalld 都覆盖) ---
if command -v ufw &>/dev/null; then
    alias fw='sudo ufw status verbose'
    alias fw-allow='sudo ufw allow'
    alias fw-deny='sudo ufw deny'
    alias fw-reload='sudo ufw reload'
elif command -v firewall-cmd &>/dev/null; then
    alias fw='sudo firewall-cmd --list-all'
    alias fw-allow='sudo firewall-cmd --permanent --add-service'
    alias fw-remove='sudo firewall-cmd --permanent --remove-service'
    alias fw-reload='sudo firewall-cmd --reload'
fi

# --- fail2ban ---
if command -v fail2ban-client &>/dev/null; then
    alias banned='sudo fail2ban-client status'
    alias banned-sshd='sudo fail2ban-client status sshd'
    alias banned-unban='sudo fail2ban-client set sshd unbanip'
fi

# --- SSH 审计 (VPS 最敏感) ---
if [[ -r /var/log/auth.log ]]; then
    alias authlog='sudo tail -f /var/log/auth.log'
    alias authfail='sudo grep "Failed password" /var/log/auth.log | tail -20'
    alias authok='sudo grep "Accepted" /var/log/auth.log | tail -20'
elif [[ -r /var/log/secure ]]; then
    alias authlog='sudo tail -f /var/log/secure'
    alias authfail='sudo grep "Failed password" /var/log/secure | tail -20'
    alias authok='sudo grep "Accepted" /var/log/secure | tail -20'
fi

# --- 资源监控 (VPS 资源敏感) ---
alias cpu='top -bn1 | head -20'
alias io='iostat -xz 1 5 2>/dev/null || vmstat 1 5'
alias connections='sudo ss -tnp state established'

# --- 邮件 (VPS 通常跑 postfix) ---
if command -v postqueue &>/dev/null; then
    alias mailq='sudo postqueue -p'
    alias mailq-flush='sudo postqueue -f'
fi

# --- 故意不引入 Docker (用 systemd 跑服务更可控) ---
# --- 故意不引入 coolercontrol (无硬件控制) ---
