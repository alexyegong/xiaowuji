#!/usr/bin/env python3
"""
EvoMap Node Heartbeat Monitor (Enhanced with Coze Capabilities)
保持节点在线状态，每 15 分钟发送一次心跳
"""

import json
import time
import requests
import sys
import os
from datetime import datetime

# Node configuration
NODE_ID = "node_f9431d4a44e15ba6"
NODE_SECRET = "0d50ed4caf2a4d786633a1153104bc545ecb3c240a82236863624848a306927e"
HUB_URL = "https://evomap.ai"

# Coze Bot configuration (for enhanced capabilities)
COZE_BOT_ID = os.getenv("COZE_BOT_ID", "7607853735758381091")

# Worker domains with Coze capabilities
WORKER_DOMAINS = [
    "healthcare",           # 医疗健康数据处理
    "data_analysis",       # 数据分析与可视化
    "web_development",     # Web 开发
    "multimodal_ai",       # 多模态 AI 处理
    "voice_processing",    # 语音处理 (ASR/TTS)
    "image_generation",    # 图片生成
    "video_processing",    # 视频处理
    "web_search",          # 联网搜索
    "chinese_nlp",         # 中文自然语言处理
    "coze_integration"     # 扣子集成
]

def send_heartbeat():
    """发送心跳到 EvoMap Hub"""
    url = f"{HUB_URL}/a2a/heartbeat"
    headers = {
        "Authorization": f"Bearer {NODE_SECRET}",
        "Content-Type": "application/json"
    }
    payload = {
        "node_id": NODE_ID,
        "worker_enabled": True,
        "worker_domains": WORKER_DOMAINS,
        "max_load": 5,  # 增加并发任务数
        "capabilities": {
            "coze_bot_id": COZE_BOT_ID,
            "multimodal": True,
            "streaming": True,
            "reasoning": True
        }
    }

    try:
        response = requests.post(url, headers=headers, json=payload, timeout=30)
        response.raise_for_status()
        data = response.json()

        print(f"[{datetime.utcnow().isoformat()}] ✅ 心跳成功")
        print(f"  状态: {data.get('node_status')}")
        print(f"  积分: {data.get('credit_balance')}")
        print(f"  生存状态: {data.get('survival_status')}")

        available_work = data.get('available_work', [])
        if available_work:
            print(f"  📋 可用任务: {len(available_work)} 个")
            for i, task in enumerate(available_work[:3], 1):  # 只显示前 3 个
                print(f"    {i}. {task.get('title', 'Unknown')}")

        overdue_tasks = data.get('overdue_tasks', [])
        if overdue_tasks:
            print(f"  ⚠️  逾期任务: {len(overdue_tasks)} 个")
            for task in overdue_tasks:
                print(f"    - {task.get('task_id')}: {task.get('overdue_minutes')} 分钟逾期")

        if data.get('next_heartbeat_ms'):
            interval_min = data['next_heartbeat_ms'] / 60000
            print(f"  ⏱️  下次心跳间隔: {interval_min:.1f} 分钟")

        return data.get('next_heartbeat_ms', 900000)
    except requests.exceptions.HTTPError as e:
        print(f"[{datetime.utcnow().isoformat()}] ❌ 心跳失败 (HTTP {e.response.status_code})")
        if e.response.text:
            try:
                error_data = e.response.json()
                print(f"  错误: {error_data.get('error')}")
                if 'correction' in error_data:
                    correction = error_data['correction']
                    print(f"  修复建议: {correction.get('fix', 'N/A')}")
            except:
                print(f"  响应: {e.response.text[:200]}")
        return 900000
    except Exception as e:
        print(f"[{datetime.utcnow().isoformat()}] ❌ 心跳失败: {e}")
        return 900000  # 默认 15 分钟

def main():
    print("=" * 70)
    print("🚀 EvoMap 心跳监控启动 (Enhanced with Coze Capabilities)")
    print("=" * 70)
    print(f"📌 节点 ID: {NODE_ID}")
    print(f"📡 Hub URL: {HUB_URL}")
    print(f"🤖 扣子 Bot ID: {COZE_BOT_ID}")
    print(f"🎯 专注领域: {', '.join(WORKER_DOMAINS)}")
    print(f"⏱️  默认心跳间隔: 15 分钟")
    print(f"📊 最大并发任务: 5")
    print("=" * 70)

    # 立即发送第一次心跳
    print("\n发送第一次心跳...")
    interval_ms = send_heartbeat()

    # 循环发送心跳
    while True:
        try:
            interval_seconds = interval_ms / 1000
            print(f"\n💤 等待 {interval_seconds:.1f} 秒后发送下一次心跳...")
            print(f"   预计下次心跳: {(datetime.now() + timedelta(seconds=interval_seconds)).strftime('%H:%M:%S')}")
            time.sleep(interval_seconds)
            interval_ms = send_heartbeat()
        except KeyboardInterrupt:
            print("\n" + "=" * 70)
            print("⏹️  收到中断信号，停止心跳监控")
            print(f"👋 节点 {NODE_ID} 已停止心跳")
            print("=" * 70)
            sys.exit(0)

if __name__ == "__main__":
    from datetime import timedelta
    main()
