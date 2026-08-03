# text-model-vision

[English](README.en.md) | 中文

为非多模态模型（如 DeepSeek）补上看图能力的 Codex 插件。

## 用法

```powershell
node "<插件根目录>\scripts\vision.js" "<图片路径>" "用中文描述这张图片"
node "<插件根目录>\scripts\vision.js" --url "<图片链接>" "用中文描述这张图片"
```

在 Codex 中，直接把图片发给纯文本模型，本技能会自动调用脚本。

## 配置

脚本按以下顺序读取配置（先到者生效，进程环境变量优先）：

1. 进程环境变量（`DASHSCOPE_API_KEY` 或 `VISION_API_KEY`、`DASHSCOPE_BASE_URL`、`VISION_MODEL`）
2. 当前目录 `.env`
3. 脚本所在目录 `scripts/.env`
4. （仅作者本机，若存在）旧版 vision skill 的 `.env` 回退：`C:\Users\lautung\.codex\skills\vision\scripts\.env`

### 方式二：环境变量

不创建 `.env`，改为设置环境变量（Windows）：

```powershell
# 当前终端临时生效
$env:DASHSCOPE_API_KEY = "sk-..."

# Windows 用户级永久设置（运行一次）
setx DASHSCOPE_API_KEY "sk-..."

# 或使用插件自带的设置脚本
powershell -ExecutionPolicy Bypass -File "scripts\set-env.ps1" -ApiKey "sk-..."
```

`setx` 之后请重启 Codex 或新开终端使其生效。

快速开始：

```powershell
Copy-Item "scripts\.env.example" "scripts\.env"
```

然后编辑 `scripts/.env` 填入你自己的值：

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

获取 Key：https://bailian.console.aliyun.com/

## 计费与隐私

- 按量计费（千问 Flash 约 0.02 元/次），需要联网
- 图片以 base64 或 URL 形式发送给 DashScope；API Key 只保存在本地，禁止打印或提交

## 致谢

`scripts/vision.js` 改编自 [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill)。
