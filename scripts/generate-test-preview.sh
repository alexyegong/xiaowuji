#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📸 生成页面截图和静态文件"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd /workspace/projects/workspace/health-data-platform/frontend

# 创建输出目录
mkdir -p /workspace/test-screenshots
mkdir -p /workspace/test-static

echo "📸 正在生成页面截图..."
echo ""

# 使用 Playwright 生成截图
cat > /tmp/generate-screenshots.ts << 'EOF'
import { chromium } from 'playwright';

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();

  const pages = [
    { url: '/', name: '首页' },
    { url: '/upload', name: '上传' },
    { url: '/cases', name: '案例' },
    { url: '/search', name: '搜索' }
  ];

  for (const pageInfo of pages) {
    console.log(`正在截图：${pageInfo.name}`);
    await page.goto(`http://localhost:80${pageInfo.url}`);
    await page.waitForTimeout(2000);
    await page.screenshot({
      path: `/workspace/test-screenshots/${pageInfo.name}.png`,
      fullPage: true
    });
    console.log(`✅ ${pageInfo.name} 截图完成`);
  }

  await browser.close();
  console.log('\n所有截图生成完成！');
})();
EOF

# 运行截图生成脚本
npx ts-node /tmp/generate-screenshots.ts

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📦 打包静态文件"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 构建静态文件
echo "正在构建静态文件..."
npm run build > /tmp/build.log 2>&1

if [ $? -eq 0 ]; then
    echo "✅ 静态文件构建完成"
    
    # 复制到测试目录
    cp -r dist/* /workspace/test-static/
    echo "✅ 静态文件已复制到 /workspace/test-static/"
else
    echo "❌ 静态文件构建失败"
    echo "查看错误日志：cat /tmp/build.log"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📊 生成结果"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📸 截图位置："
ls -lh /workspace/test-screenshots/*.png 2>/dev/null || echo "  （没有生成截图）"

echo ""
echo "📦 静态文件位置："
echo "  /workspace/test-static/"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  💡 如何使用"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "方式 1：查看截图"
echo "  查看截图文件：ls /workspace/test-screenshots/"
echo ""

echo "方式 2：下载静态文件"
echo "  压缩包路径：/workspace/test-static/"
echo "  你可以下载后，在本地浏览器打开 index.html"
echo ""

echo "方式 3：在服务器浏览器中查看"
echo "  如果你有服务器桌面访问，打开浏览器访问："
echo "  http://localhost:80/"
echo ""

echo "方式 4：开放云服务商端口（推荐）"
echo "  1. 登录阿里云控制台"
echo "  2. 找到安全组配置"
echo "  3. 开放 80 端口（HTTP）或 22 端口（SSH）"
echo "  4. 然后就可以通过公网访问了"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
