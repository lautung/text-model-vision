# text-model-vision

为非多模态模型（如 DeepSeek）补上看图能力的 Codex 插件。
A Codex plugin that gives text-only models (e.g. DeepSeek) image understanding.

## Usage / 用法

```powershell
node "<插件根目录>\scripts\vision.js" "<图片路径>" "用中文描述这张图片"
node "<插件根目录>\scripts\vision.js" --url "<图片链接>" "用中文描述这张图片"
```

In Codex, just send an image to a text-only model and this skill runs automatically.
在 Codex 中，直接把图片发给纯文本模型，本技能会自动调用脚本。

## Configuration / 配置

The script reads config in this order (first match wins; process env has priority):
脚本按以下顺序读取配置（先到者生效，进程环境变量优先）：

1. Process environment / 进程环境变量（`DASHSCOPE_API_KEY` 或 `VISION_API_KEY`、`DASHSCOPE_BASE_URL`、`VISION_MODEL`）
2. `.env` in the current working directory / 当前目录 `.env`
3. `.env` next to the script / 脚本所在目录 `scripts/.env`
4. (Author's machine only, if present) legacy vision skill `.env` /（仅作者本机，若存在）旧版 vision skill 的 `.env` 回退：`C:\Users\lautung\.codex\skills\vision\scripts\.env`

### Option B: Environment variable / 方式二：环境变量

Set `DASHSCOPE_API_KEY` (or `VISION_API_KEY`) instead of creating a `.env` file:
不创建 `.env`，改为设置环境变量（Windows）：

```powershell
# 当前终端临时生效 / temporary, current shell only
$env:DASHSCOPE_API_KEY = "sk-..."

# Windows 用户级永久设置 / persistent, user level (run once)
setx DASHSCOPE_API_KEY "sk-..."

# 或使用插件自带的设置脚本 / or use the bundled helper script
powershell -ExecutionPolicy Bypass -File "scripts\set-env.ps1" -ApiKey "sk-..."
```

After `setx`, restart Codex or open a new terminal so the variable takes effect.
`setx` 之后请重启 Codex 或新开终端使其生效。

Quick start / 快速开始：

```powershell
Copy-Item "scripts\.env.example" "scripts\.env"
```

Then fill in your own values / 然后编辑 `scripts/.env` 填入你自己的值：

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

Get a key at / 获取 Key：https://bailian.console.aliyun.com/

## Cost & Privacy / 计费与隐私

- 按量计费（千问 Flash 约 0.02 元/次），需要联网 / Pay-per-use (~0.02 CNY/call), network required
- 图片以 base64 或 URL 形式发送给 DashScope；API Key 只保存在本地，禁止打印或提交 / Images are sent to DashScope as base64 or URL; the API key stays local, never print or commit it

## Credits / 致谢

`scripts/vision.js` 改编自 [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill)。
`scripts/vision.js` is adapted from [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill).
