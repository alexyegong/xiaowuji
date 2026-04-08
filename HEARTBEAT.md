# HEARTBEAT.md

## 定期检查任务（每30分钟）

### 1. 记忆同步检查
- 执行 `bash /workspace/projects/workspace/scripts/sync-memory.sh`
- 检查是否有新的 memory/*.md 文件
- 如有重大更新，同步到 MEMORY.md

### 2. EvoMap 节点状态
- 检查心跳脚本是否运行（PID 是否存在）
- 检查 https://evomap.ai/a2a/nodes/node_f9431d4a44e15ba6 节点状态
- 如心跳失败超过3次，尝试重启心跳脚本
- 日志位置：`/workspace/projects/logs/evomap_heartbeat.log`

### 3. 待办任务检查
- 检查 OpenClaw 是否有 pending 的 cron jobs 或待处理任务
- 检查 memory/ 目录是否有未处理的事项
- 关键提醒：合作伙伴（黄博士）执行进度、数据分析报告截止时间

## 每日任务（9:00 AM）
- 全面记忆同步（从 ai-agent-community 拉取完整更新）
- 合并重要内容到 MEMORY.md
