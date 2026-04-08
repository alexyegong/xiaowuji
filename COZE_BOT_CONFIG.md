# 扣子 OpenClaw 配置

## Bot 信息

**Bot ID**: 7607853735758381091
**Bot Token**: 87ec93034edae3cf75856ca18309256d4d818ed251582bcf5c1689b5c94b7963
**Bot URL**: https://01037feb-e878-4ea4-982a-d92c06e42fab.dev.coze.site

## 环境变量

```bash
export COZE_BOT_ID="7607853735758381091"
export COZE_TOKEN="87ec93034edae3cf75856ca18309256d4d818ed251582bcf5c1689b5c94b7963"
export COZE_INTEGRATION_BASE_URL="https://api.coze.com"
export COZE_INTEGRATION_MODEL_BASE_URL="https://model.coze.com"
```

## 功能验证

基于 WORKSPACE/skills/ 中的 Coze SDK 验证报告，此 Bot 已具备以下能力：

### ✅ 已验证功能

1. **大语言模型 (LLM)**
   - 流式对话
   - 思考链
   - 缓存机制
   - 多模态支持（图片/视频）

2. **语音识别 (ASR)**
   - 支持最长 2 小时音频

3. **语音合成 (TTS)**
   - 30+ 音色
   - 支持 SSML

4. **联网搜索**
   - Web 搜索
   - AI 摘要
   - 图片搜索
   - 时间过滤
   - 站点限制

5. **图片生成**
   - 文生图
   - 图生图
   - 支持 2K/4K

6. **视频生成**
   - 文本生成视频
   - 图片生成视频

## 与 EvoMap 的集成

扣子 Bot 可以作为 EvoMap 网络的一部分：

1. **消息总线**: 通过扣子 API 接收和发送消息
2. **能力发布**: 将扣子的能力（ASR、TTS、搜索等）发布为 EvoMap Capsules
3. **任务分发**: 接收 EvoMap 的任务并使用扣子能力完成
4. **多模态处理**: 利用扣子的多模态能力处理图片、视频任务

## 技能集成

WORKSPACE/skills/ 中的 Coze SDK 技能：

- `coze-image-gen`: 高质量图片生成
- `coze-voice-gen`: 语音识别和合成
- `coze-web-search`: 联网搜索

## API 端点

根据扣子文档，主要的 API 端点：

- **聊天**: POST /v3/chat
- **流式聊天**: POST /v3/chat/stream
- **语音转文字**: POST /v1/audio/transcription
- **文字转语音**: POST /v1/audio/speech
- **图片生成**: POST /v1/images/generations
- **视频生成**: POST /v1/videos/generations

## 安全提示

⚠️ **CRITICAL**: Bot Token 是敏感信息，不要：
- 提交到公共代码仓库
- 在日志中输出完整 token
- 与未授权的第三方共享

## 配置文件位置

- 主配置: `/workspace/projects/workspace/COZE_BOT_CONFIG.md`
- 技能目录: `/workspace/projects/workspace/skills/coze-*/SKILL.md`
