# text-model-vision

English | [中文](README.md)

A Codex plugin that gives text-only models (e.g. DeepSeek) image understanding.

## Usage

```powershell
node "<plugin-root>\scripts\vision.js" "<image path>" "Describe this image in Chinese."
node "<plugin-root>\scripts\vision.js" --url "<image URL>" "Describe this image in Chinese."
```

In Codex, just send an image to a text-only model and this skill runs automatically.

## Configuration

The script reads config in this order (first match wins; process env has priority):

1. Process environment (`DASHSCOPE_API_KEY` or `VISION_API_KEY`, `DASHSCOPE_BASE_URL`, `VISION_MODEL`)
2. `.env` in the current working directory
3. `.env` next to the script (`scripts/.env`)
4. (Author's machine only, if present) legacy vision skill `.env` at `C:\Users\lautung\.codex\skills\vision\scripts\.env`

### Environment variable option

Set `DASHSCOPE_API_KEY` (or `VISION_API_KEY`) instead of creating a `.env` file (Windows):

```powershell
# Temporary, current shell only
$env:DASHSCOPE_API_KEY = "sk-..."

# Persistent, user level (run once)
setx DASHSCOPE_API_KEY "sk-..."

# Or use the bundled helper script
powershell -ExecutionPolicy Bypass -File "scripts\set-env.ps1" -ApiKey "sk-..."
```

After `setx`, restart Codex or open a new terminal so the variable takes effect.

Quick start:

```powershell
Copy-Item "scripts\.env.example" "scripts\.env"
```

Then fill in your own values:

```ini
DASHSCOPE_API_KEY=sk-...
VISION_MODEL=qwen-vl-plus
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

Get a key at: https://bailian.console.aliyun.com/

## Cost & Privacy

- Pay-per-use (~0.02 CNY/call, Qwen Flash), network required
- Images are sent to DashScope as base64 or URL; the API key stays local, never print or commit it

## Credits

`scripts/vision.js` is adapted from [asuojun/claude-vision-skill](https://github.com/asuojun/claude-vision-skill).

## License

[MIT](../../LICENSE).
