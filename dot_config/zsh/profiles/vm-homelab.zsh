# =============================================================================
# profiles/vm-homelab.zsh — HomeLab VM 差量
# 继承 base + platform。追加: K8s / Docker 实验
# 关键策略: 隔离环境,玩 k8s / docker-in-docker 随便搞
# =============================================================================

# --- kubectl (如果装了 k8s 工具链) ---
if command -v kubectl &>/dev/null; then
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgn='kubectl get nodes'
    alias kga='kubectl get all'
    alias kaf='kubectl apply -f'
    alias kdel='kubectl delete -f'
    alias klogs='kubectl logs -f'
    alias ksh='kubectl exec -it'
    alias kctx='kubectl config use-context'
    alias kns='kubectl config set-context --current --namespace'

    # kubectx / kubens 增强
    command -v kubectx &>/dev/null && alias kctx='kubectx'
    command -v kubens &>/dev/null && alias kns='kubens'
fi

# --- helm ---
if command -v helm &>/dev/null; then
    alias h='helm'
    alias hi='helm install'
    alias hu='helm upgrade --install'
    alias hl='helm list'
    alias hrm='helm uninstall'
fi

# --- Docker / Compose (VM 玩实验) ---
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker compose'
    alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
    alias dlog='docker logs -f --tail=100'
    alias dstop='docker stop $(docker ps -q)'
    alias dclean='docker system prune -af'
fi

# --- 网络实验工具 ---
if command -v iperf3 &>/dev/null; then
    alias iperf-server='iperf3 -s'
    alias iperf-test='iperf3 -c'
fi

# --- kind / minikube ---
if command -v kind &>/dev/null; then
    alias kind-create='kind create cluster'
    alias kind-delete='kind delete cluster'
    alias kind-list='kind get clusters'
fi
