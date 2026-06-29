# =============================================================================
# platforms/windows.zsh — Windows 平台差量 (Git Bash / WSL)
# =============================================================================
、
# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Editor (Windows 特有: VS Code)
z4h load   ohmyzsh/ohmyzsh/plugins/vscode 2>/dev/null || true
export EDITOR='code --wait'
e() {
  code --wait "$@"
}

# 路径转换
alias pwdw='cygpath -w $(pwd)'                       # 当前目录转 Windows 路径
alias w2u='cygpath -u'                               # Windows 路径转 Unix
alias u2w='cygpath -w'                               # Unix 路径转 Windows

# 资源管理器
alias o='explorer'
alias oo='explorer .'

# 常用 Windows 工具
alias npp='notepad++'

# 进程
alias pkill='taskkill //F //IM' 2>/dev/null

# WSL 互操作 (如果在 WSL 中)
if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
    alias winhome='cd /mnt/c/Users/$(whoami)'
    alias code='code.exe'
    alias explorer='explorer.exe'
fi
