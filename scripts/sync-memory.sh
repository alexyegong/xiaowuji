#!/bin/bash
# 记忆同步脚本 - 供小无疾使用
# 将 ai-agent-community 的最新记忆同步到本地工作区

WORKSPACE="/workspace/projects/ai-agent-community"
TARGET="/workspace/projects/workspace/memory"

cd "$WORKSPACE" || exit 1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始同步记忆..."

# 拉取最新记忆
git fetch origin
git pull origin main

# 记录同步时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 记忆同步完成"

# 可选：输出最近更新
echo "--- 最近提交 ---"
git log --oneline -5
