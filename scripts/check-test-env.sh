#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🧪 人工测试环境检查"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查服务状态
echo "📊 服务状态："
if netstat -tlnp | grep -q ":80 "; then
    echo "  ✅ 开发服务器运行中（端口 80）"
    netstat -tlnp | grep ":80 " | awk '{print "  📍 监听地址: " $4}'
else
    echo "  ❌ 开发服务器未运行"
    echo ""
    echo "  💡 启动命令："
    echo "     cd /workspace/projects/workspace/health-data-platform/frontend && npm run dev:80"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🌐 访问地址"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📍 内网地址："
echo "  http://9.130.90.132/"
echo ""

echo "📍 公网地址（需要配置防火墙）："
echo "  http://101.126.128.57/"
echo "  ⚠️  当前状态：不可访问（防火墙阻止）"
echo ""

echo "📍 SSH 隧道（推荐）："
echo "  1. 在本地电脑运行："
echo "     ssh -L 8080:9.130.90.132:80 your_username@101.126.128.57"
echo ""
echo "  2. 在浏览器访问："
echo "     http://localhost:8080/"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📋 测试页面"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "  首页：      http://9.130.90.132/"
echo "  上传：      http://9.130.90.132/upload"
echo "  案例：      http://9.130.90.132/cases"
echo "  语音：      http://9.130.90.132/voice"
echo "  搜索：      http://9.130.90.132/search"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🧪 自动化测试状态"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -f "/workspace/projects/workspace/health-data-platform/frontend/test-output.log" ]; then
    echo "  最近测试结果："
    tail -20 /workspace/projects/workspace/health-data-platform/frontend/test-output.log | grep -E "(✓|✘|passed|failed)" | head -5
else
    echo "  📝 暂无测试结果"
    echo "  💡 运行测试：cd /workspace/projects/workspace/health-data-platform/frontend && npm run test:e2e"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📚 更多信息"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "  📖 测试指南："
echo "     cat /workspace/projects/workspace/health-data-platform/frontend/TESTING_ACCESS.md"
echo ""
echo "  📊 测试报告："
echo "     cat /workspace/projects/workspace/health-data-platform/frontend/TEST_RESULTS_SUMMARY.md"
echo ""
echo "  🔧 重启服务："
echo "     告诉小无疾，我会帮你重启"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✨ 环境已就绪，开始测试吧！"
echo ""
