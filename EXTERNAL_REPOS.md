# 外部代码库位置

**更新日期**: 2026-03-22

---

## 📦 已克隆的外部仓库

### 1. ai-agent-community (主项目)

**仓库信息:**
- **GitHub**: https://github.com/alexyegong/ai-agent-community
- **本地路径**: `/workspace/projects/ai-agent-community/`
- **说明**: AI Agent Community 多智能体协作社区

**核心文件:**
- `agent_bus.py` - 消息总线核心
- `kimi_coordinator.py` - Kimi 协调器
- `opencode_adapter.py` - OpenCode 适配器
- `coze_adapter.py` - 扣子 OpenClaw 适配器
- `start_community.py` - 启动脚本
- `CONFIG.md` - 配置指南
- `README.md` - 项目说明

**节点架构:**
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   本地 OpenCode  │◄───►│  协作消息总线    │◄───►│  扣子 OpenClaw  │
│  (本地计算中枢)  │     │  (Message Hub)  │     │ (工作流自动化)  │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 ▼
                    ┌─────────────────────┐
                    │   Kimi Claw (协调器) │
                    │   (协调与决策中枢)    │
                    └─────────────────────┘
```

**团队角色:**
| 节点 | 平台 | 职责 |
|------|------|------|
| OpenCode | 本地 | 代码执行、文件操作 |
| OpenClaw | 扣子 | 工作流、外部API |
| Kimi Claw | Kimi | 任务协调、结果汇总 |
| **小无疾** | **EvoMap** | **医疗健康、多模态 AI** |

---

### 2. ai-agent-messages (消息总线)

**仓库信息:**
- **GitHub**: https://github.com/alexyegong/ai-agent-messages
- **本地路径**: `/workspace/projects/workspace/ai-agent-messages/`
- **说明**: AI Agent Community 消息总线

**用途:**
- 作为团队的消息传递中心
- GitHub Issues 作为通信协议
- 任务分配和进度追踪

**重要 Issues:**
- **#3** - 测试 Issue (https://github.com/alexyegong/ai-agent-messages/issues/3)
- **#4** - 小无疾邀请 Issue (https://github.com/alexyegong/ai-agent-messages/issues/4)

---

## 🔐 认证信息

### GitHub Token
- **已配置**: ✅
- **用途**: 克隆、推送代码
- **权限**: 读写访问

### Git 配置
- **User Name**: agent
- **Email**: 3959805172779786-agent@noreply.coze.cn

---

## 📝 Git 提交记录

1. **26ac688** - feat: 集成 EvoMap 多 Agent 网络和扣子 SDK
2. **2f40b7e** - feat: 接受 AI Agent Community 团队邀请
3. **d96677d** - feat: 完成 AI Agent Community 代码库克隆
4. **0ae4443** - chore: 2026-03-22 工作备份

---

## 🚀 使用方法

### 查看代码
```bash
# 主项目
cd /workspace/projects/ai-agent-community/

# 消息总线
cd /workspace/projects/workspace/ai-agent-messages/
```

### 拉取最新代码
```bash
# 主项目
cd /workspace/projects/ai-agent-community/
git pull

# 消息总线
cd /workspace/projects/workspace/ai-agent-messages/
git pull
```

### 查看项目结构
```bash
# 主项目
cd /workspace/projects/ai-agent-community/
ls -la

# 查看配置
cat CONFIG.md

# 查看说明
cat README.md
```

---

## 🤝 协作流程

### 通过 GitHub Issues
```
叶公 → 创建 Issue 分配任务
  ↓
我 → 通过当前对话接收任务
  ↓
我 → 完成任务
  ↓
叶公 → 在 Issue 上发布我的结果
```

### 通过 EvoMap 网络
```
我 → 向团队 Agent 发送 EvoMap DM
  ↓
团队 Agent → 通过 GitHub Issues 或 EvoMap 响应
  ↓
我 → 接收并处理
```

---

## 📊 项目状态

| 项目 | 状态 | 路径 |
|------|------|------|
| ai-agent-community | ✅ 已克隆 | /workspace/projects/ai-agent-community/ |
| ai-agent-messages | ✅ 已克隆 | /workspace/projects/workspace/ai-agent-messages/ |
| EvoMap 节点 | ✅ 已注册 | node_f9431d4a44e15ba6 |
| 心跳监控 | ✅ 运行中 | 每 15 分钟 |

---

## 🔗 快速链接

### 项目
- **主仓库**: https://github.com/alexyegong/ai-agent-community
- **消息总线**: https://github.com/alexyegong/ai-agent-messages

### EvoMap
- **Hub**: https://evomap.ai
- **我的节点**: node_f9431d4a44e15ba6
- **文档**: https://evomap.ai/skill.md

### 协作
- **Issue #3**: https://github.com/alexyegong/ai-agent-messages/issues/3
- **Issue #4**: https://github.com/alexyegong/ai-agent-messages/issues/4

---

**更新时间**: 2026-03-22 03:35 GMT+8
