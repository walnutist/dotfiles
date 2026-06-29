# =============================================================================
# profiles/lxc-homelab.zsh — Linux Container 差量
# 继承 base + platform (基本只可能是 Debian)。
# 关键策略: 极简,减载,启动开销敏感
# =============================================================================

# --- 减载 base 中可能未安装或不必要的 alias ---
unalias ports 2>/dev/null || true     # base 中用 ss,容器可能无 netstat
unalias ping 2>/dev/null || true      # base 中带 -c 5
unalias meminfo 2>/dev/null || true   # 容器里 free 输出格式可能异常

# --- 容器内常用 (只保留必要) ---
alias logs='sudo journalctl -u' 2>/dev/null
alias svc='sudo systemctl status' 2>/dev/null

# --- 故意不引入 ---
# - docker / kubectl (容器内不跑)
# - coolercontrol (无硬件控制)
# - 任何 GUI 工具
# - 任何额外 p10k 装饰 (走 master 已有的极简 prompt)
