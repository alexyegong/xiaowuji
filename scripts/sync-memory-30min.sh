#!/bin/bash
# 30分钟自动记忆同步脚本
# 小无疾心跳任务的一部分

WORKSPACE="/workspace/projects/ai-agent-community"
LOG="/workspace/projects/logs/memory-sync.log"

cd "$WORKSPACE" || exit 1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] === 开始30分钟记忆同步 ===" >> "$LOG"

# 拉取最新
git fetch origin main 2>&1 | tee -a "$LOG"
git pull origin main 2>&1 | tee -a "$LOG"

# 检查是否有更新
if git log HEAD..origin/main --oneline | grep -q .; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 发现新提交，通知主会话" >> "$LOG"
    echo "发现新提交: $(git log HEAD..origin/main --oneline)" >> "$LOG"
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] === 同步完成 ===" >> "$LOG"
