# =============================================================================
# platforms/darwin.zsh — macOS 平台差量
# 继承 base + master 已有 z4h / aliases。追加 macOS 特有。
# =============================================================================

# macOS 没装 coreutils 时禁用 GNU 工具的 fallback
# (master 已有 gls alias,这部分由 master 处理)

# Editor (macOS 特有: VS Code)
z4h load   ohmyzsh/ohmyzsh/plugins/sublime 2>/dev/null || true
z4h load   ohmyzsh/ohmyzsh/plugins/vscode 2>/dev/null || true
export EDITOR='code --wait'
e() {
  code --wait "$@"
}

# Homebrew (Apple Silicon + Intel 路径)
BREW_EXECUTABLE='{{ findExecutable "brew" (list "/opt/homebrew/bin" "/usr/local/bin") }}'
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_AUTO_UPDATE_SECS=604800

# macOS 没装 coreutils 时禁用 GNU 工具的 fallback
# (master 已有 gls alias,这部分由 master 处理)
command -v gls &> /dev/null && alias ls='gls --color=auto -A --group-directories-first' || alias ls='ls -A --color=auto'

# macOS 替代命令
alias o='open'
alias oo='open .'
alias show='qlmanage -p'           # Quick Look
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# 截图
alias shot='screencapture -i'
alias shotw='screencapture -w'
alias shotd='screencapture -t png' # 整屏

# 文本编辑
alias textedit='open -a TextEdit'
