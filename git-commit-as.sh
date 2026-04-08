#!/bin/bash
#
# git-commit-as.sh - AI Agent Community 团队提交脚本
#
# 用法: ./git-commit-as.sh <Agent名称> <提交信息>
# 示例: ./git-commit-as.sh "小无疾" "feat: 添加新功能"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Agent 信息映射
declare -A AGENT_AUTHORS=(
    ["叶颂公"]="叶颂公 <yesonggong@noreply.coze.cn>"
    ["小叶子"]="小叶子 <xiaoyezi@noreply.coze.cn>"
    ["Kimi Claw"]="Kimi Claw <kimi-claw@noreply.coze.cn>"
    ["Coze OpenClaw"]="Coze OpenClaw <coze-openclaw@noreply.coze.cn>"
    ["OpenClaw"]="OpenClaw <openclaw@noreply.coze.cn>"
    ["小无疾"]="小无疾 <xiaowuji@noreply.coze.cn>"
)

# 显示使用帮助
show_help() {
    echo "用法: $0 <Agent名称> <提交信息>"
    echo ""
    echo "可用的 Agent 名称："
    for agent in "${!AGENT_AUTHORS[@]}"; do
        echo "  - $agent"
    done
    echo ""
    echo "示例："
    echo "  $0 \"小无疾\" \"feat: 添加多模态支持\""
    echo "  $0 \"小叶子\" \"fix: 修复任务调度bug\""
    echo "  $0 \"Kimi Claw\" \"refactor: 优化推理引擎\""
}

# 检查参数
if [ $# -lt 2 ]; then
    echo -e "${RED}错误: 缺少参数${NC}"
    show_help
    exit 1
fi

AGENT_NAME="$1"
COMMIT_MESSAGE="$2"

# 检查 Agent 是否存在
if [[ ! -v AGENT_AUTHORS["$AGENT_NAME"] ]]; then
    echo -e "${RED}错误: 未知的 Agent 名称 '$AGENT_NAME'${NC}"
    echo ""
    echo -e "${YELLOW}可用的 Agent 名称：${NC}"
    for agent in "${!AGENT_AUTHORS[@]}"; do
        echo "  - $agent"
    done
    exit 1
fi

# 获取 Author 信息
AUTHOR="${AGENT_AUTHORS[$AGENT_NAME]}"

# 显示提交信息
echo -e "${GREEN}准备提交...${NC}"
echo -e "Agent: ${YELLOW}$AGENT_NAME${NC}"
echo -e "Author: $AUTHOR"
echo -e "Message: $COMMIT_MESSAGE"
echo ""

# 执行提交
if git commit --author="$AUTHOR" -m "$COMMIT_MESSAGE"; then
    echo ""
    echo -e "${GREEN}✅ 提交成功！${NC}"

    # 显示提交信息
    echo ""
    echo -e "${YELLOW}最新提交：${NC}"
    git log -1 --pretty=format:"%h %an %s"

    # 显示提交历史
    echo ""
    echo -e "${YELLOW}最近的提交：${NC}"
    git log --pretty=format:"%h %an %s" --graph -5
else
    echo ""
    echo -e "${RED}❌ 提交失败！${NC}"
    exit 1
fi
