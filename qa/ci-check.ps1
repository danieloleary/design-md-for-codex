param(
  [switch]$SkipPublicDrift
)

$ErrorActionPreference = "Stop"

function Run-Check($Name, $RelativeScript) {
  Write-Host ""
  Write-Host "## $Name" -ForegroundColor Green
  & (Join-Path $PSScriptRoot $RelativeScript)
}

Run-Check "Public contract" "check-public-contract.ps1"
Run-Check "Local assets" "check-local-assets.ps1"
Run-Check "Design artifacts" "check-design-artifacts.ps1"

if ($SkipPublicDrift) {
  Write-Host ""
  Write-Host "== Skipping public drift checks" -ForegroundColor Cyan
  Write-Host "OK public GitHub Pages/archive checks skipped for local or PR validation"
} else {
  Run-Check "Public drift" "check-public-drift.ps1"
}

Write-Host ""
Write-Host "== CI check passed" -ForegroundColor Cyan
