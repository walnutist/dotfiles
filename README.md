# dotfiles — Chezmoi-managed, profile-based

基于 [chezmoi](https://www.chezmoi.io/) + [zsh4humans](https://github.com/romkatv/zsh4humans) 的统一 dotfiles 管理。

**2 维矩阵**：

- **Profile 维度**（5 选 1，chezmoi init 时用户选）：机器的角色
- **OS 维度**（chezmoi 自动检测）：平台适配

## 设计原则

- **不维护 profiles/*.toml / features/*.toml**——所有逻辑直接写在 `.tmpl` 条件里
- **不维护 bootstrap 脚本**——`chezmoi init --apply <repo>` 一行命令启动
- **base + 5 个 profile 差量**——基类+继承（5 份独立完整配置 vs 1 份 base + 5 差量）
- **OS 维度**自动通过 `.chezmoi.os` / `.chezmoi.osRelease.id` 检测

## 快速开始

```bash
# 一行启动 (clone + apply + 第一次问 profile)
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply https://github.com/walnutist/dotfiles.git
# 或 (如果已装 chezmoi)
chezmoi init --apply https://github.com/walnutist/dotfiles.git

# 第一次会问 4 个问题:
#   - profile        (5 选 1)
#   - github_user
#   - email
#   - securityLevel  (dircolors 配色)
# 答案写入 ~/.config/chezmoi/chezmoi.toml,后续不重复问。

# 安装 zsh4humans
sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"

# 重启 shell
exec zsh
```

## Profile 列表

| Profile | 形态 | 关键工具 | 关键策略 |
|---------|------|---------|---------|
| `server-homelab` | 物理服务器 (Linux) | docker、coolercontrol、sensors、smartmontools | 内网服务、完整监控 |
| `server-linode`  | 公网 VPS (Linux) | ufw/firewalld、fail2ban、systemd | 公网加固、SSH 审计 |
| `vm-homelab`     | VM (任意 OS) | kubectl、docker compose、kind | K8s/Docker 实验 |
| `lxc-homelab`    | LXC 容器 (Linux) | 极简 alias、journalctl | 启动开销敏感 |
| `desktop`        | 个人电脑 (任意 OS) | lsd/eza/bat/fd/rg、IDE、GUI 工具 | 完整桌面体验 |

## 目录结构

```
dotfiles/
├── .chezmoi.toml.tmpl              # 配置模板(4 个 prompt: profile + user data + dircolors)
├── .chezmoiignore                  # OS + profile 过滤
├── README.md
│
├── dot_zshenv                      # XDG 路径 + 加载 zshenv4h
├── dot_cache/zsh/.keep             # zsh 缓存占位
│
├── dot_config/zsh/
│   ├── dot_zshrc.tmpl              # ★ 完整 z4h 配置 (193 行,master 原版) + 末尾追加 base+platform+profile
│   ├── dot_p10k.zsh                # ★ p10k lean 配置 (1719 行,master 原版)
│   ├── dot_p10k-ascii-8color.zsh   # ★ p10k 8-color fallback (1719 行,master 原版)
│   ├── zshenv4h.tmpl               # z4h 自定义 .zshenv
│   │
│   ├── base.zsh                    # ★ 5 profile 共享基类
│   │
│   ├── platforms/                  # OS 维度 (4 选 1,chezmoi 自动)
│   │   ├── darwin.zsh
│   │   ├── debian.zsh
│   │   ├── fedora.zsh
│   │   └── windows.zsh
│   │
│   └── profiles/                   # Profile 维度 (5 选 1,用户选)
│       ├── server-homelab.zsh
│       ├── server-linode.zsh
│       ├── vm-homelab.zsh
│       ├── lxc-homelab.zsh
│       └── desktop.zsh
│
├── platform/                       # 原 master:OS 特定的非 zsh 配置
│   ├── darwin/
│   │   ├── chezmoidata.toml
│   │   ├── dot.docker/config.json  # docker desktop 配置
│   │   └── dot_config/folders.zh_CN.strings  # Finder 中文目录
│   └── linux-debian/
│       └── chezmoidata.toml        # fd=fdfind, bat=bat 映射
│
└── dot_chezmoiscripts/
    └── run_onchange_before_10-install-packages.sh.tmpl
```

## 加载链（zsh 启动时）

```
~/.zshenv  (master 原版)
   ↓ source
$ZSH_CONFIG_DIR/zshenv4h
   ↓
~/.config/zsh/dot_zshrc (chezmoi 渲染后的 dot_zshrc.tmpl)
   │
   ├─ z4h init + zstyle + bindkey + setopt + history     (master 原版)
   ├─ 编辑器 / Homebrew / Mise 初始化                    (master 原版)
   ├─ aliases (du=duf, cat=bat, grep=rg, ...)           (master 原版)
   ├─ mirror env (Homebrew/Rust/UV/Pip/Go/HF)           (master 原版)
   ├─ LS_COLORS / dircolors 加载                        (master 原版)
   │
   ├─ ★ source base.zsh          (5 profile 共享)
   ├─ ★ source platforms/*.zsh   (OS 维度)
   ├─ ★ source profiles/*.zsh    (Profile 维度)
   │
   └─ source ~/.zshrc (用户覆盖)
```

## 容器 / CI 场景（无交互）

```bash
chezmoi init --apply --source=. \
    --promptString "profile=lxc-homelab" \
    --promptString "github_user=walnutist" \
    --promptString "email=ci@home.org" \
    --promptString "securityLevel=sandbox" \
    walnutist
```

## 修改 profile

```bash
# 编辑本机配置
$EDITOR ~/.config/chezmoi/chezmoi.toml
# 修改 profile = "xxx",保存。

# 重新渲染
chezmoi apply
```

## 维护指南

| 想做的事 | 改哪 |
|---------|------|
| 给所有机器加 alias | `dot_config/zsh/base.zsh` |
| 给 server-homelab 加 docker alias | `dot_config/zsh/profiles/server-homelab.zsh` |
| 给 Debian 加 apt alias | `dot_config/zsh/platforms/debian.zsh` |
| 改 zsh 主体配置 / dircolors | `dot_config/zsh/dot_zshrc.tmpl`（master 原版） |
| 改 p10k 提示符 | `dot_config/zsh/dot_p10k.zsh`（master 原版） |
| 加新 profile | (1) `.chezmoi.toml.tmpl` 加 promptChoice (2) `profiles/new.zsh` (3) `.chezmoiignore` 加 ignore (4) `dot_zshrc.tmpl` 加 if (5) `run_onchange_*.sh.tmpl` 加装包 |

## 调试

```bash
# 查看 chezmoi 注入的所有 data
chezmoi data

# 模拟某一台机器的渲染结果
chezmoi execute-template < dot_zshrc.tmpl

# 看哪些文件被忽略
chezmoi ignored

# diff 当前 home 与 source 仓库
chezmoi diff
```
