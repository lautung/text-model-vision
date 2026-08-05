<#
把 DashScope API Key 设置为 Windows 用户级环境变量，作为 .env 之外的另一种配置方式。

用法:
  powershell -ExecutionPolicy Bypass -File .\scripts\set-env.ps1 -ApiKey sk-xxxx
  或直接运行后按提示输入。

设置后请重启 Codex / ZCode 或新开终端，使环境变量生效。
#>
param(
    [string]$ApiKey
)

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
    $ApiKey = Read-Host -Prompt "请输入 DashScope API Key"
}

if ([string]::IsNullOrWhiteSpace($ApiKey)) {
    Write-Error "未提供有效的 API Key"
    exit 1
}

[Environment]::SetEnvironmentVariable("DASHSCOPE_API_KEY", $ApiKey, "User")
Write-Host "已设置用户级环境变量 DASHSCOPE_API_KEY。"
Write-Host "请重启 Codex / ZCode 或新开终端，使环境变量生效。"
