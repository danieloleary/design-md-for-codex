$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib\common.ps1")

$Contract = Get-ProjectContract
$Owner = $Contract.repository.owner
$Repo = $Contract.repository.name
$MainBranch = $Contract.repository.branch
$PagesRoot = $Contract.repository.pagesUrl.TrimEnd("/")
$GitHubRoot = $Contract.repository.url.TrimEnd("/")
$SkillPath = ($Contract.skill.path -replace "\\", "/").Trim("/")
$TempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("design-md-ci-" + [guid]::NewGuid().ToString("N"))

try {
  Step "Checking public drift tooling"
  Require-Command "Expand-Archive"

  Step "Checking public GitHub and Pages URLs"
  Assert-Url "$PagesRoot/" "Dan O'Leary"
  Assert-Url "$PagesRoot/assets/hero-art.png"
  Assert-Url "$PagesRoot/assets/social-card.png"
  Assert-Url "$PagesRoot/assets/repo-banner.png"
  Assert-Url "$PagesRoot/assets/share-before-after.png"
  Assert-Url "$PagesRoot/assets/proof/fixture-before.png"
  Assert-Url "$PagesRoot/assets/proof/fixture-after.png"
  Assert-Url "$PagesRoot/assets/proof/ai-workbench-wide.png"
  Assert-Url "$PagesRoot/assets/proof/ai-workbench-detail.png"
  Assert-Url "$PagesRoot/LAUNCH.md" "Launch Plan"
  Assert-Url "$PagesRoot/LAUNCH-TRACKER.md" "Launch Tracker"
  Assert-Url "$PagesRoot/SHARE.md" "Where To Share"
  Assert-Url "$PagesRoot/skills/design-system/references/DESIGN.md" "Codex Workshop Design System"
  Assert-Url "$PagesRoot/qa/smoke-test.ps1" "Smoke test passed"
  Assert-Url "$GitHubRoot/blob/$MainBranch/skills/design-system/SKILL.md" "design-system"
  Assert-Url "$GitHubRoot/blob/$MainBranch/qa/fixture/DESIGN.md" "Design Skill QA Fixture"

  Step "Checking public skill folder download"
  New-Item -ItemType Directory -Force -Path $TempRoot | Out-Null
  $ZipPath = Join-Path $TempRoot "repo.zip"
  $ExtractPath = Join-Path $TempRoot "repo"
  Invoke-WebRequest -Uri "https://codeload.github.com/$Owner/$Repo/zip/refs/heads/$MainBranch" -OutFile $ZipPath -TimeoutSec 60
  Expand-Archive -LiteralPath $ZipPath -DestinationPath $ExtractPath -Force
  $ExtractedSkill = Get-ChildItem -Path $ExtractPath -Directory -Recurse |
    Where-Object {
      $NormalizedPath = $_.FullName -replace "\\", "/"
      $NormalizedPath -like "*/$Repo-$MainBranch/$SkillPath"
    } |
    Select-Object -First 1
  if (-not $ExtractedSkill) { throw "Could not find skills/design-system in public repo archive." }
  Require-File (Join-Path $ExtractedSkill.FullName "SKILL.md")
  Require-File (Join-Path $ExtractedSkill.FullName "agents/openai.yaml")
  Require-File (Join-Path $ExtractedSkill.FullName "references/DESIGN.md")
  Write-Host "OK public archive contains installable skill folder"

  Step "Public drift checks passed"
} finally {
  if (Test-Path -LiteralPath $TempRoot) {
    Remove-Item -LiteralPath $TempRoot -Recurse -Force
  }
}
