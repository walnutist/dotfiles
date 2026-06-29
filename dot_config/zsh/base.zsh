# =============================================================================
# base.zsh — 所有 profile 共享的最小 alias/环境集合
# 这是 5 个 profile 的"基类",由 dot_zshrc.tmpl 末尾 source。
# profile 文件用 unalias / 覆盖来增删,不要在这里塞 profile 特有的内容。
# =============================================================================

# --- 网络诊断 (master 已设 myip 不在这里,只补缺) ---
alias ports='ss -tulnp 2>/dev/null || netstat -tulnp'
alias ping='ping -c 5'

# --- 进程 ---
alias ps='ps auxf'

# --- 危险操作提示 (master 已有 rm/cp/mv -i,补 chown/chmod) ---
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias ln='ln -i'

# --- 时间 / PATH ---
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias timestamp='date +%s'

# --- 系统信息快查 ---
alias distro='cat /etc/os-release 2>/dev/null || sw_vers 2>/dev/null || ver 2>/dev/null'
alias kernel='uname -a'
alias cpuinfo='lscpu | head -20'
alias meminfo='free -h 2>/dev/null || vm_stat'

# --- 杂项 ---
alias reload-zsh='exec zsh'
alias zshrc='$EDITOR ~/.zshrc'
