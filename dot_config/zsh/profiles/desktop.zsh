# =============================================================================
# profiles/desktop.zsh — 个人电脑差量
# 继承 base + platform。追加: 现代 CLI 替代 / IDE / GUI 工具
# 关键策略: 完整桌面体验,美化,开发效率
# (master 已经有 bat/fd/rg/delta/lazygit alias,这里只补缺)
# =============================================================================

# --- 现代 CLI 替代 (覆盖 master 的简单 alias) ---
if command -v lsd &>/dev/null; then
    alias l='lsd -l'
    alias lt='lsd --tree'
    alias lta='lsd --tree --all'
fi
if command -v eza &>/dev/null; then
    alias lt='eza --tree --icons'
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# --- IDE / 编辑器快捷方式 ---
if command -v nvim &>/dev/null; then
    alias vim='nvim'
    alias v='nvim'
    alias svim='sudo -E nvim'
fi
if command -v code &>/dev/null; then
    alias c.='code .'
fi
if command -v subl &>/dev/null; then
    alias s='subl'
fi

# --- GUI 打开命令 (按 OS 区分) ---
{{- if eq .chezmoi.os "darwin" }}
alias o='open'
alias oo='open .'
{{- else if eq .chezmoi.os "windows" }}
alias o='explorer'
alias oo='explorer .'
{{- else }}
alias o='xdg-open'
alias oo='xdg-open .'
{{- end }}

# --- Docker (开发用) ---
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker compose'
    alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
    alias dlog='docker logs -f --tail=100'
    alias dstop='docker stop $(docker ps -q)'
    alias dclean='docker system prune -af'
fi

# --- 开发工作流常用 ---
alias serve='python3 -m http.server 8000' 2>/dev/null
alias json='python3 -m json.tool'
alias urlencode='python3 -c "import sys,urllib.parse;print(urllib.parse.quote(sys.stdin.read().strip()))"'
alias urldecode='python3 -c "import sys,urllib.parse;print(urllib.parse.unquote(sys.stdin.read().strip()))"'
