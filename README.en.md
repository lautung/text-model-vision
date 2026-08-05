# text-model-vision

English | [中文](README.md)

A Codex / ZCode plugin that gives text-only models (e.g. DeepSeek) image understanding through the Qwen Vision API (DashScope, OpenAI-compatible).

## Features

- Works with local images, clipboard images, and image URLs
- Dependency-free Node.js script with a built-in `.env` parser
- API key stays local and is never distributed with the plugin
- Pay-per-use, ~0.02 CNY/call (Qwen Flash)

## Install

From GitHub:

```bash
codex plugin marketplace add lautung/text-model-vision
codex plugin add text-model-vision@text-model-vision
```

Then start a new thread so Codex loads the new skill.

For local development (when the repo is already cloned locally):

```bash
codex plugin marketplace add C:\Users\lautung\Documents\text-model-vision
codex plugin add text-model-vision@text-model-vision
```

To install in ZCode:

1. Open **Settings → Plugin Management → Discover**, click **+** to add a marketplace
2. Enter the GitHub repo `lautung/text-model-vision` (or a local repo path)
3. Find **text-model-vision** in the list and install it (enabled by default)

Then start a new session so ZCode loads the new skill.

## Configure

Create `plugins/text-model-vision/scripts/.env` or set process environment variables.

Quick start:

```powershell
Copy-Item "plugins\text-model-vision\scripts\.env.example" "plugins\text-model-vision\scripts\.env"
```

Then fill in your own values:

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

### Environment variable option

Prefer an environment variable? Set `DASHSCOPE_API_KEY` (or `VISION_API_KEY`) instead of creating `.env` (Windows):

```powershell
# Temporary, current shell only
$env:DASHSCOPE_API_KEY = "sk-..."

# Persistent, user level (run once)
setx DASHSCOPE_API_KEY "sk-..."

# Or use the bundled helper script
powershell -ExecutionPolicy Bypass -File "plugins\text-model-vision\scripts\set-env.ps1" -ApiKey "sk-..."
```

After `setx`, restart Codex / ZCode or open a new terminal so the variable takes effect.

> ZCode note: the plugin is installed into a cache directory (e.g. `~/.zcode/cli/plugins/cache/...`) that is re-fetched on plugin updates, which resets `scripts/.env`. On ZCode, prefer the environment variable; `.env` is mainly for Codex or quick local debugging.

Read order: process env → cwd `.env` → `scripts/.env` → (author's machine only, if present) legacy vision skill `.env`.
Get a key at: https://bailian.console.aliyun.com/

## Usage

Send an image to a text-only model in Codex / ZCode and the skill triggers automatically. You can also call the script directly:

```powershell
node "plugins\text-model-vision\scripts\vision.js" "<image path>" "Describe this image in Chinese."
node "plugins\text-model-vision\scripts\vision.js" --url "<image URL>" "Describe this image in Chinese."
```

## Cost & Privacy

- Qwen Flash vision model, pay-per-use, network required
- Images are sent to DashScope as base64 or URL
- The API key is only stored locally; never commit `.env`

## Repository layout

```
.
├── marketplace.json                    # ZCode repo marketplace
├── .agents/plugins/marketplace.json    # Codex repo marketplace
├── plugins/text-model-vision/          # the plugin itself
│   ├── .codex-plugin/plugin.json       # Codex plugin manifest
│   ├── .zcode-plugin/plugin.json       # ZCode plugin manifest
│   ├── scripts/vision.js
│   └── skills/text-model-vision/SKILL.md
├── README.md                           # 中文说明
└── README.en.md                        # English
```

> Maintenance note: keep `name` / `version` / `description` in sync between `.codex-plugin/plugin.json` and `.zcode-plugin/plugin.json`.

## Development

Validate the plugin with the plugin-creator skill:

```powershell
python "C:\Users\lautung\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py" plugins\text-model-vision
```

## Credits

`plugins/text-model-vision/scripts/vision.js` is adapted from [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill).

## License

[MIT](LICENSE).
