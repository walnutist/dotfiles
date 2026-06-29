# =============================================================================
# platforms/darwin.zsh — macOS 平台差量
# 继承 base + master 已有 z4h / aliases。追加 macOS 特有。
# =============================================================================

# macOS 没装 coreutils 时禁用 GNU 工具的 fallback
# (master 已有 gls alias,这部分由 master 处理)

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
