$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillUrl = "https://github.com/danieloleary/design-md-for-codex/tree/main/skills/design-system"
$InstallPrompt = "Use `$skill-installer to install $SkillUrl"
$TempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("design-md-smoke-" + [guid]::NewGuid().ToString("N"))
$InstallDest = Join-Path $TempRoot "skills"
$Installer = Join-Path $env:USERPROFILE ".codex\skills\.system\skill-installer\scripts\install-skill-from-github.py"
$Validator = Join-Path $env:USERPROFILE ".codex\skills\.system\skill-creator\scripts\quick_validate.py"

function Step($Message) {
  Write-Host ""
  Write-Host "== $Message" -ForegroundColor Cyan
}

function Require-File($Path) {
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    throw "Missing required file: $Path"
  }
  Write-Host "OK $Path"
}

function Require-Command($Name) {
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "Missing required command: $Name"
  }
  Write-Host "OK command $Name"
}

try {
  Step "Checking local tooling"
  Require-Command "python"
  Require-Command "npx"

  Step "Checking repo files"
  Require-File (Join-Path $RepoRoot "skills\design-system\SKILL.md")
  Require-File (Join-Path $RepoRoot "skills\design-system\agents\openai.yaml")
  Require-File (Join-Path $RepoRoot "skills\design-system\references\DESIGN.md")
  Require-File (Join-Path $RepoRoot "skills\design-system\references\theme.css")
  Require-File (Join-Path $RepoRoot "skills\design-system\references\tokens.json")
  Require-File (Join-Path $RepoRoot "qa\fixture\DESIGN.md")
  Require-File (Join-Path $RepoRoot "qa\fixture\index.html")

  Step "Installing public GitHub skill into temp folder"
  if (-not (Test-Path -LiteralPath $Installer -PathType Leaf)) {
    throw "Cannot find local skill installer helper: $Installer"
  }
  New-Item -ItemType Directory -Force -Path $InstallDest | Out-Null
  & python $Installer --url $SkillUrl --dest $InstallDest
  if ($LASTEXITCODE -ne 0) { throw "Public GitHub install failed." }

  $InstalledSkill = Join-Path $InstallDest "design-system"
  Require-File (Join-Path $InstalledSkill "SKILL.md")
  Require-File (Join-Path $InstalledSkill "agents\openai.yaml")
  Require-File (Join-Path $InstalledSkill "references\DESIGN.md")
  Require-File (Join-Path $InstalledSkill "references\theme.css")
  Require-File (Join-Path $InstalledSkill "references\tokens.json")

  Step "Validating skill package"
  if (Test-Path -LiteralPath $Validator -PathType Leaf) {
    & python $Validator (Join-Path $RepoRoot "skills\design-system")
    if ($LASTEXITCODE -ne 0) { throw "Repo skill validation failed." }
    & python $Validator $InstalledSkill
    if ($LASTEXITCODE -ne 0) { throw "Installed skill validation failed." }
  } else {
    Write-Host "WARN validator not found: $Validator"
  }

  Step "Linting DESIGN.md files"
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "skills\design-system\references\DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Bundled DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "examples\minimal-repo\DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Minimal DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "qa\fixture\DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "QA fixture DESIGN.md lint failed." }

  Step "Parsing tokens.json"
  Get-Content (Join-Path $RepoRoot "skills\design-system\references\tokens.json") | ConvertFrom-Json | Out-Null
  Write-Host "OK tokens.json parses"

  Step "Checking public URLs"
  $Urls = @(
    "https://danieloleary.github.io/design-md-for-codex/",
    "https://github.com/danieloleary/design-md-for-codex/blob/main/skills/design-system/SKILL.md",
    "https://github.com/danieloleary/design-md-for-codex/blob/main/skills/design-system/references/DESIGN.md"
  )
  foreach ($Url in $Urls) {
    $Response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 20
    if ($Response.StatusCode -ne 200) { throw "Unexpected status $($Response.StatusCode) for $Url" }
    Write-Host "OK $Url"
  }

  Step "Manual Codex QA prompt"
  Write-Host $InstallPrompt
  Write-Host ""
  Write-Host "After restart, open qa\fixture in Codex and run:"
  Write-Host '$design-system Make this page follow DESIGN.md.'
  Write-Host ""
  Write-Host "Expected behavior is documented in qa\fixture\expected.md"

  Step "Smoke test passed"
} finally {
  if (Test-Path -LiteralPath $TempRoot) {
    Remove-Item -LiteralPath $TempRoot -Recurse -Force
  }
}
