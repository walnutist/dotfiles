# =============================================================================
# profiles/server-homelab.zsh — 物理 HomeLab 服务器差量
# 继承 base + platform。追加: Docker / 硬件监控 / 风扇 / NAS
# =============================================================================

# --- Docker ---
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker compose'
    alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
    alias dstats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
    alias dlog='docker logs -f --tail=100'
    alias dstop='docker stop $(docker ps -q)'
    alias dclean='docker system prune -af'
    alias upd-all='docker compose pull && docker compose up -d'
    alias logs-all='docker compose logs -f --tail=100'
fi

# --- 硬件监控 (lm-sensors / smartmontools) ---
if command -v sensors &>/dev/null; then
    alias temp='sensors'
    alias temp-watch='watch -n 5 sensors'
fi
if command -v smartctl &>/dev/null; then
    alias smart='sudo smartctl -a /dev/sda'
    alias smart-test='sudo smartctl -t short /dev/sda'
fi

# --- coolercontrol (机箱风扇) ---
if command -v coolercontrol &>/dev/null; then
    alias fan='coolercontrol'
    alias fan-status='coolercontrol status'
fi

# --- NAS / SMB 客户端 ---
if command -v mount.cifs &>/dev/null; then
    alias mnt-nas='sudo mount -t cifs //nas.local/share ~/nas -o credentials=~/.smbcred,uid=$(id -u),gid=$(id -g)'
    alias umnt-nas='sudo umount ~/nas'
fi
