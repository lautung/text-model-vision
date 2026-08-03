---
name: "text-model-vision"
description: "为非多模态模型（如 DeepSeek）提供看图能力。当用户发送图片（粘贴、本地路径或网络 URL）、系统提示图片内容被省略（例如 'image content omitted because you do not support image input'）、或要求识图/看图/描述/分析图片时使用。调用本地 scripts/vision.js，通过千问视觉 API 返回文字描述。不用于生成或编辑图片。"
---

# Text Model Vision 识图

让不具备原生多模态能力的模型（如 DeepSeek）通过千问视觉 API 看图，返回文字描述。

## 何时使用

- 用户发送图片：粘贴的剪贴板图片、本地图片路径、网络图片 URL
- 系统消息显示图片内容被省略（例如 "image content omitted because you do not support image input"）
- 用户要求描述、分析、识别图片内容

## 调用方法

本插件的识图脚本位于插件根目录的 `scripts/vision.js`（相对本技能文件为 `../../scripts/vision.js`）。先定位脚本的绝对路径（例如用 `rg --files` 搜索 `vision.js`），再执行：

```powershell
node "<插件根目录>\scripts\vision.js" "<图片路径>" "用中文描述这张图片"
node "<插件根目录>\scripts\vision.js" --url "<图片链接>" "用中文描述这张图片"
```

## 配置说明

- API Key、模型名、Base URL 读取顺序：进程环境变量 → 当前目录 .env → 脚本所在目录 .env →（作者本机，若存在）旧版 vision skill 的 `C:\Users\lautung\.codex\skills\vision\scripts\.env`
- 首次配置可把 `scripts/.env.example` 复制为 `scripts/.env` 后填入自己的 Key / To get started, copy `scripts/.env.example` to `scripts/.env` and fill in your key
- 默认使用千问 Flash 视觉模型，按量计费（约 0.02 元/次）
- 脚本无第三方依赖（内置 .env 解析），无需 npm install

## 安全注意事项

- API Key 只存在于本地 .env，禁止打印到对话、禁止提交到任何代码仓库
- 图片是二进制文件，不要用文本工具读取，用本脚本处理
