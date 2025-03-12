#
# This script updates all structural files of this repository, esp. the github action configuration of Dependabot.
#
$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

$yaml = @"
This:
- is
- a
- test
"@

Set-Content -Value $yaml -Path (Join-Path $PSScriptRoot "test.yaml") -Encoding utf8NoBOM
