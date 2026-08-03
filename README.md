# text-model-vision

**A Codex plugin that gives text-only models (e.g. DeepSeek) image understanding through the Qwen Vision API (DashScope, OpenAI-compatible).**
**为非多模态模型（如 DeepSeek）提供看图能力的 Codex 插件：通过千问视觉 API（DashScope，OpenAI 兼容接口）把图片转成文字描述。**

## Features / 功能

- Local images, clipboard images, and image URLs all work / 支持本地图片、粘贴图片与网络图片链接
- Dependency-free Node.js script with a built-in `.env` parser / 无第三方依赖的 Node.js 脚本（内置 .env 解析）
- API key stays local and is never distributed with the plugin / API 密钥仅存本地，不随插件分发
- Pay-per-use, ~0.02 CNY/call (Qwen Flash) / 按量计费（千问 Flash，约 0.02 元/次）

## Install / 安装

From GitHub / 从 GitHub 安装：

```bash
codex plugin marketplace add lautung/text-model-vision
codex plugin add text-model-vision@text-model-vision
```

Then start a new thread so Codex loads the new skill. / 然后新开一个线程，让 Codex 加载新技能。

For local development / 本地开发调试（仓库已克隆到本机时）：

```bash
codex plugin marketplace add C:\Users\lautung\Documents\text-model-vision
codex plugin add text-model-vision@text-model-vision
```

## Configure / 配置

Create `plugins/text-model-vision/scripts/.env` or set process environment variables:
在 `plugins/text-model-vision/scripts/.env` 中写入配置，或设置进程环境变量：

Quick start / 快速开始：

```powershell
Copy-Item "plugins\text-model-vision\scripts\.env.example" "plugins\text-model-vision\scripts\.env"
```

### Environment variable option / 方式二：环境变量

Prefer an environment variable? Set `DASHSCOPE_API_KEY` (or `VISION_API_KEY`) instead of creating `.env` (Windows):
也可以不创建 `.env`，改为设置环境变量 `DASHSCOPE_API_KEY`（或 `VISION_API_KEY`，Windows）：

```powershell
# 当前终端临时生效 / temporary, current shell only
$env:DASHSCOPE_API_KEY = "sk-..."

# Windows 用户级永久设置 / persistent, user level (run once)
setx DASHSCOPE_API_KEY "sk-..."

# 或使用插件自带的设置脚本 / or use the bundled helper script
powershell -ExecutionPolicy Bypass -File "plugins\text-model-vision\scripts\set-env.ps1" -ApiKey "sk-..."
```

After `setx`, restart Codex or open a new terminal so the variable takes effect.
`setx` 之后请重启 Codex 或新开终端使其生效。

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

Read order / 读取顺序：process env → cwd `.env` → `scripts/.env` → (author's machine only, if present) legacy vision skill `.env` /（仅作者本机，若存在）旧版 vision skill 的 `.env`。
Get a key at / 获取 Key：https://bailian.console.aliyun.com/

## Usage / 使用

Send an image to a text-only model in Codex and the skill triggers automatically. You can also call the script directly:
在 Codex 中把图片发给纯文本模型即可，技能会自动触发；也可以直接调用脚本：

```powershell
node "plugins\text-model-vision\scripts\vision.js" "<图片路径>" "用中文描述这张图片"
node "plugins\text-model-vision\scripts\vision.js" --url "<图片链接>" "用中文描述这张图片"
```

## Cost & Privacy / 计费与隐私

- Qwen Flash vision model, pay-per-use, network required / 千问 Flash 视觉模型，按量计费，需要联网
- Images are sent to DashScope as base64 or URL / 图片以 base64 或 URL 形式发送给 DashScope
- The API key is only stored locally; never commit `.env` / API Key 仅保存在本地，切勿提交 `.env`

## Repository layout / 仓库结构

```
.
├── .agents/plugins/marketplace.json   # Codex repo marketplace
├── plugins/text-model-vision/         # the plugin itself
│   ├── .codex-plugin/plugin.json
│   ├── scripts/vision.js
│   └── skills/text-model-vision/SKILL.md
└── README.md
```

## Development / 开发

Validate the plugin with the plugin-creator skill:
使用 plugin-creator 技能校验插件：

```powershell
python "C:\Users\lautung\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py" plugins\text-model-vision
```

## Credits / 致谢

`plugins/text-model-vision/scripts/vision.js` 改编自 [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill)。
`plugins/text-model-vision/scripts/vision.js` is adapted from [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill).

## License / 许可

Not specified / 未指定。
