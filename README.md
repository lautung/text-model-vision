# text-model-vision

[English](README.en.md) | 中文

为非多模态模型（如 DeepSeek）提供看图能力的 Codex / ZCode 插件：通过千问视觉 API（DashScope，OpenAI 兼容接口）把图片转成文字描述。

## 功能

- 支持本地图片、粘贴图片与网络图片链接
- 无第三方依赖的 Node.js 脚本（内置 .env 解析）
- API 密钥仅存本地，不随插件分发
- 按量计费（千问 Flash，约 0.02 元/次）

## 安装

从 GitHub 安装：

```bash
codex plugin marketplace add lautung/text-model-vision
codex plugin add text-model-vision@text-model-vision
```

然后新开一个线程，让 Codex 加载新技能。

本地开发调试（仓库已克隆到本机时）：

```bash
codex plugin marketplace add C:\Users\lautung\Documents\text-model-vision
codex plugin add text-model-vision@text-model-vision
```

在 ZCode 中安装：

1. 打开 **设置 → 插件管理 → 发现** 页签，点击 **+** 添加市场
2. 填入 GitHub 仓库 `lautung/text-model-vision`（或本机仓库路径）
3. 在发现列表中找到 **text-model-vision**，点击安装（默认已启用）

然后新开一个会话，让 ZCode 加载新技能。

## 配置

在 `plugins/text-model-vision/scripts/.env` 中写入配置，或设置进程环境变量。

快速开始：

```powershell
Copy-Item "plugins\text-model-vision\scripts\.env.example" "plugins\text-model-vision\scripts\.env"
```

然后编辑 `.env` 填入自己的值：

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

### 方式二：环境变量

也可以不创建 `.env`，改为设置环境变量 `DASHSCOPE_API_KEY`（或 `VISION_API_KEY`，Windows）：

```powershell
# 当前终端临时生效
$env:DASHSCOPE_API_KEY = "sk-..."

# Windows 用户级永久设置（运行一次）
setx DASHSCOPE_API_KEY "sk-..."

# 或使用插件自带的设置脚本
powershell -ExecutionPolicy Bypass -File "plugins\text-model-vision\scripts\set-env.ps1" -ApiKey "sk-..."
```

`setx` 之后请重启 Codex / ZCode 或新开终端使其生效。

> ZCode 注意：插件安装在缓存目录（如 `~/.zcode/cli/plugins/cache/...`），插件更新时会重新拉取该目录，`scripts/.env` 会被重置——ZCode 下建议优先用环境变量配置密钥，`.env` 方式主要用于 Codex 或临时调试。

读取顺序：进程环境变量 → 当前目录 `.env` → `scripts/.env` →（仅作者本机，若存在）旧版 vision skill 的 `.env`。
获取 Key：https://bailian.console.aliyun.com/

## 使用

在 Codex / ZCode 中把图片发给纯文本模型即可，技能会自动触发；也可以直接调用脚本：

```powershell
node "plugins\text-model-vision\scripts\vision.js" "<图片路径>" "用中文描述这张图片"
node "plugins\text-model-vision\scripts\vision.js" --url "<图片链接>" "用中文描述这张图片"
```

## 计费与隐私

- 千问 Flash 视觉模型，按量计费，需要联网
- 图片以 base64 或 URL 形式发送给 DashScope
- API Key 仅保存在本地，切勿提交 `.env`

## 仓库结构

```
.
├── marketplace.json                    # ZCode 仓库市场
├── .agents/plugins/marketplace.json    # Codex 仓库市场
├── plugins/text-model-vision/          # 插件本体
│   ├── .codex-plugin/plugin.json       # Codex 插件清单
│   ├── .zcode-plugin/plugin.json       # ZCode 插件清单
│   ├── scripts/vision.js
│   └── skills/text-model-vision/SKILL.md
├── README.md                           # 中文说明
└── README.en.md                        # English
```

> 维护注意：`.codex-plugin/plugin.json` 与 `.zcode-plugin/plugin.json` 的 `name` / `version` / `description` 需保持一致。

## 开发

使用 plugin-creator 技能校验插件：

```powershell
python "C:\Users\lautung\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py" plugins\text-model-vision
```

## 致谢

`plugins/text-model-vision/scripts/vision.js` 改编自 [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill)。

## 许可

[MIT](LICENSE)。
