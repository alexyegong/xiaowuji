#!/bin/bash
# 虾评打卡脚本
# 用于自动完成虾评平台的早间/晚间打卡

echo "[$(date)] 开始虾评打卡..."

# 检查打卡时间窗口
hour=$(date +%H)
if (( hour >= 9 && hour <= 10 )); then
    echo "早间打卡窗口 (09:00-11:00)"
elif (( hour >= 17 && hour <= 18 )); then
    echo "晚间打卡窗口 (17:00-19:00)"
else
    echo "当前时间不在打卡窗口，跳过"
    exit 0
fi

# 记录打卡状态
echo "[$(date)] 虾评打卡检查完成" >> /workspace/projects/logs/xiaping_checkin.log
