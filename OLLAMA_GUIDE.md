# 本地 Ollama 调用指南

## 概述

本指南说明如何在无疾云项目中调用本地的 Ollama 和 CodeQwen 模型。

---

## 1. Ollama 基础信息

### 当前状态
- **版本**: 0.17.6
- **安装路径**: `/usr/local/bin/ollama`
- **API 地址**: `http://localhost:11434`

### 已安装模型
- `qwen3-embedding:0.6b` - 639 MB（嵌入模型）
- `qwen2.5-coder:7b` - 正在下载中（约 4.7 GB）

### 服务管理
```bash
# 查看服务状态
curl -s http://localhost:11434/api/tags

# 查看已安装模型
ollama list

# 运行模型（测试）
ollama run qwen2.5-coder:7b
```

---

## 2. 安装 CodeQwen 模型

### 推荐模型
- **qwen2.5-coder:7b** - 7B 参数，代码生成专用（当前正在安装）
- **qwen2.5-coder:14b** - 14B 参数，质量更高但需要更多资源（可选）
- **qwen2.5:7b** - 7B 参数，通用对话（可选）

### 安装命令
```bash
# 安装 7B 代码模型（推荐）
ollama pull qwen2.5-coder:7b

# 安装 14B 代码模型（如果机器性能允许）
ollama pull qwen2.5-coder:14b

# 安装通用模型（可选）
ollama pull qwen2.5:7b
```

### 模型选择建议
- **开发环境**: qwen2.5-coder:7b（速度快，资源占用低）
- **生产环境**: qwen2.5-coder:14b（质量更高，但需要 16GB+ RAM）
- **测试环境**: 可以先用 7B 版本

---

## 3. Python 集成方案

### 方案 A: 直接 HTTP 调用（推荐）

**优点**: 简单直接，无需额外依赖

```python
import requests
import json

OLLAMA_BASE_URL = "http://localhost:11434"

def call_ollama(prompt, model="qwen2.5-coder:7b", stream=False):
    """
    调用本地 Ollama 模型

    Args:
        prompt: 用户提示词
        model: 模型名称
        stream: 是否流式返回

    Returns:
        str: 模型响应
    """
    url = f"{OLLAMA_BASE_URL}/api/generate"

    payload = {
        "model": model,
        "prompt": prompt,
        "stream": stream,
        "options": {
            "temperature": 0.7,
            "num_predict": 2048,
        }
    }

    response = requests.post(url, json=payload, timeout=60)
    response.raise_for_status()

    result = response.json()
    return result.get("response", "")

# 使用示例
if __name__ == "__main__":
    result = call_ollama("写一个 Python 函数，计算斐波那契数列")
    print(result)
```

### 方案 B: 使用 LangChain（高级）

**优点**: 支持提示词模板、链式调用、工具调用

```bash
pip install langchain langchain-community langchain-core
```

```python
from langchain_community.llms import Ollama
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain

# 初始化模型
llm = Ollama(
    model="qwen2.5-coder:7b",
    base_url="http://localhost:11434",
    temperature=0.7
)

# 创建提示词模板
template = """
你是一个健康数据分析专家。请分析以下健康数据：

{data}

请提供：
1. 数据摘要
2. 异常值检测
3. 健康建议
"""

prompt = PromptTemplate(
    template=template,
    input_variables=["data"]
)

# 创建链
chain = LLMChain(llm=llm, prompt=prompt)

# 使用
health_data = """
血压：120/80 mmHg
心率：75 bpm
血糖：5.6 mmol/L
"""

result = chain.run(data=health_data)
print(result)
```

---

## 4. FastAPI 集成示例

在无疾云项目中，可以创建一个新的服务模块：

### 文件结构
```
backend/
├── services/
│   ├── ollama_service.py  # Ollama 服务
│   ├── ai_service.py      # AI 服务（原通义千问）
│   └── health_analyzer.py # 健康数据分析
```

### ollama_service.py
```python
import requests
import logging
from typing import Optional, Dict, Any

logger = logging.getLogger(__name__)

class OllamaService:
    """本地 Ollama 服务"""

    def __init__(
        self,
        base_url: str = "http://localhost:11434",
        default_model: str = "qwen2.5-coder:7b"
    ):
        self.base_url = base_url
        self.default_model = default_model

    def health_check(self) -> bool:
        """检查 Ollama 服务是否可用"""
        try:
            response = requests.get(f"{self.base_url}/api/tags", timeout=5)
            return response.status_code == 200
        except Exception as e:
            logger.error(f"Ollama 健康检查失败: {e}")
            return False

    def generate(
        self,
        prompt: str,
        model: Optional[str] = None,
        temperature: float = 0.7,
        max_tokens: int = 2048,
        stream: bool = False
    ) -> str:
        """
        生成文本

        Args:
            prompt: 提示词
            model: 模型名称（默认使用 default_model）
            temperature: 温度参数（0-1）
            max_tokens: 最大生成 token 数
            stream: 是否流式返回

        Returns:
            生成的文本
        """
        url = f"{self.base_url}/api/generate"

        payload = {
            "model": model or self.default_model,
            "prompt": prompt,
            "stream": stream,
            "options": {
                "temperature": temperature,
                "num_predict": max_tokens,
            }
        }

        try:
            response = requests.post(url, json=payload, timeout=120)
            response.raise_for_status()

            result = response.json()
            return result.get("response", "")

        except Exception as e:
            logger.error(f"Ollama 生成失败: {e}")
            raise

    async def generate_async(
        self,
        prompt: str,
        model: Optional[str] = None,
        temperature: float = 0.7,
        max_tokens: int = 2048
    ) -> str:
        """异步生成文本"""
        import aiohttp
        import asyncio

        url = f"{self.base_url}/api/generate"

        payload = {
            "model": model or self.default_model,
            "prompt": prompt,
            "stream": False,
            "options": {
                "temperature": temperature,
                "num_predict": max_tokens,
            }
        }

        async with aiohttp.ClientSession() as session:
            async with session.post(url, json=payload, timeout=120) as response:
                response.raise_for_status()
                result = await response.json()
                return result.get("response", "")

    def get_models(self) -> list:
        """获取已安装的模型列表"""
        try:
            response = requests.get(f"{self.base_url}/api/tags", timeout=10)
            response.raise_for_status()
            data = response.json()
            return [model["name"] for model in data.get("models", [])]
        except Exception as e:
            logger.error(f"获取模型列表失败: {e}")
            return []

# 全局实例
ollama_service = OllamaService()
```

### 在 API 中使用
```python
from fastapi import APIRouter, Depends, HTTPException
from services.ollama_service import ollama_service

router = APIRouter(prefix="/ai", tags=["AI"])

@router.post("/analyze")
async def analyze_health_data(
    data: str,
    model: str = "qwen2.5-coder:7b"
):
    """使用本地 Ollama 分析健康数据"""

    # 检查服务是否可用
    if not ollama_service.health_check():
        raise HTTPException(status_code=503, detail="Ollama 服务不可用")

    # 构建提示词
    prompt = f"""
    你是一个专业的健康数据分析专家。请分析以下健康数据：

    {data}

    请以 JSON 格式返回分析结果，包含以下字段：
    {{
        "summary": "数据摘要",
        "abnormalities": ["异常值1", "异常值2"],
        "recommendations": ["建议1", "建议2"]
    }}
    """

    try:
        result = await ollama_service.generate_async(
            prompt=prompt,
            model=model,
            temperature=0.7
        )
        return {"result": result}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"分析失败: {str(e)}")

@router.get("/models")
async def list_models():
    """获取可用的模型列表"""
    models = ollama_service.get_models()
    return {"models": models}
```

---

## 5. 配置环境变量

在 `.env` 文件中添加：

```env
# Ollama 配置
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_DEFAULT_MODEL=qwen2.5-coder:7b
OLLAMA_TIMEOUT=120
```

---

## 6. 常用命令速查

```bash
# 查看已安装模型
ollama list

# 运行模型（交互式）
ollama run qwen2.5-coder:7b

# 测试 API
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "你好",
  "stream": false
}'

# 查看模型信息
ollama show qwen2.5-coder:7b

# 删除模型
ollama rm qwen2.5-coder:7b
```

---

## 7. 性能优化建议

### 内存优化
```python
options = {
    "temperature": 0.7,
    "num_predict": 1024,  # 减少输出长度
    "num_ctx": 4096,      # 限制上下文长度
    "num_thread": 4,      # 控制线程数
}
```

### GPU 加速（如果有 NVIDIA GPU）
```bash
# 安装 CUDA 版本的 Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Ollama 会自动检测并使用 GPU
```

---

## 8. 故障排查

### 服务无法连接
```bash
# 检查服务是否运行
curl http://localhost:11434/api/tags

# 重启 Ollama
sudo systemctl restart ollama  # 如果使用 systemd
# 或
killall ollama && ollama serve  # 手动重启
```

### 模型加载慢
```bash
# 查看模型大小
ollama show qwen2.5-coder:7b

# 使用更小的模型
ollama pull qwen2.5-coder:3b
```

### 内存不足
- 使用更小的模型（3b 而不是 7b）
- 减少上下文长度（num_ctx）
- 增加系统 swap 空间

---

## 9. 与现有服务集成

### 替代或补充阿里云通义千问

```python
# services/ai_service.py（原通义千问服务）
from services.ollama_service import ollama_service

class AIService:
    """AI 服务 - 支持多个后端"""

    def __init__(self, backend: str = "local"):
        """
        Args:
            backend: "local" (Ollama) | "aliyun" (通义千问)
        """
        self.backend = backend

    def generate(self, prompt: str) -> str:
        if self.backend == "local":
            # 使用本地 Ollama
            return ollama_service.generate(prompt)
        elif self.backend == "aliyun":
            # 使用阿里云通义千问（原有逻辑）
            return self._call_qwen_aliyun(prompt)
        else:
            raise ValueError(f"未知后端: {self.backend}")
```

---

## 10. 下一步行动

1. ✅ 等待 qwen2.5-coder:7b 下载完成
2. ✅ 测试模型是否正常工作
3. ⏳ 在 backend 项目中创建 `services/ollama_service.py`
4. ⏳ 实现健康数据分析 API
5. ⏳ 前端集成新的分析接口
6. ⏳ 性能测试和优化

---

## 相关资源

- Ollama 官方文档: https://ollama.com/docs
- Qwen 模型库: https://ollama.com/library/qwen2.5-coder
- 无疾云项目文档: `/workspace/projects/workspace/health-data-platform/`

---

*最后更新: 2026-03-28*
