$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib\common.ps1")

$Contract = Get-ProjectContract
$IndexHtml = Get-Content (Join-Path $Script:RepoRoot "index.html") -Raw
$Readme = Get-Content (Join-Path $Script:RepoRoot "README.md") -Raw
$Repo = $Contract.repository.name

Step "Checking local tooling"
Require-Command "node"
Require-Command "npx"

Step "Checking required files"
$RequiredFiles = @(
  "public-contract.json",
  "DESIGN.md",
  "README.md",
  "AGENTS.md",
  "CLAUDE.md",
  "COPY.md",
  "index.html",
  "landing.css",
  "assets/hero-art.png",
  "assets/social-card.png",
  "assets/repo-banner.png",
  "assets/share-before-after.png",
  "assets/demo-video.mp4",
  "assets/demo-video-thumbnail.png",
  "assets/proof/fixture-before.png",
  "assets/proof/fixture-after.png",
  "assets/proof/ai-workbench-wide.png",
  "assets/proof/ai-workbench-detail.png",
  "LAUNCH.md",
  "LAUNCH-TRACKER.md",
  "SHARE.md",
  "MAINTENANCE-CHECKLIST.md",
  "TROUBLESHOOTING.md",
  "FAQ.md",
  "package.json",
  "package-lock.json",
  "qa/visual-qa.mjs",
  "qa/verify-fixture.mjs",
  ".github/pull_request_template.md",
  ".github/ISSUE_TEMPLATE/config.yml",
  ".github/ISSUE_TEMPLATE/install-bug.yml",
  ".github/ISSUE_TEMPLATE/skill-bug.yml",
  ".github/ISSUE_TEMPLATE/docs.yml",
  ".github/ISSUE_TEMPLATE/example-request.yml",
  "skills/design-system/SKILL.md",
  "skills/design-system/agents/openai.yaml",
  "skills/design-system/references/DESIGN.md",
  "skills/design-system/references/theme.css",
  "skills/design-system/references/tokens.json",
  "examples/minimal-repo/DESIGN.md",
  "examples/minimal-repo/.agents/skills/design-system/SKILL.md",
  "qa/fixture/DESIGN.md",
  "qa/fixture/index.html",
  "qa/fixture/after.html",
  "qa/fixture/codex-result.md",
  "qa/fixture/expected.md",
  "qa/generate-launch-assets.py",
  "qa/generate-demo-video.py",
  "qa/smoke-test.ps1"
)
foreach ($RelativePath in $RequiredFiles) {
  Require-File (Join-Path $Script:RepoRoot $RelativePath)
}

Step "Checking local links"
$HrefMatches = [regex]::Matches($IndexHtml, 'href="([^"]+)"')
foreach ($Match in $HrefMatches) {
  $Href = $Match.Groups[1].Value
  if ($Href.StartsWith("#") -or $Href -match "^[a-zA-Z][a-zA-Z0-9+.-]*:") { continue }
  $Target = ($Href -split "#")[0]
  if (-not $Target) { continue }
  $TargetPath = Join-Path $Script:RepoRoot $Target
  if (-not (Test-Path -LiteralPath $TargetPath)) {
    throw "Broken local href: $Href"
  }
}
Write-Host "OK local href targets"

Step "Checking local images"
$ImageTargets = @()
$ImageTargets += [regex]::Matches($IndexHtml, 'src="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
$ImageTargets += [regex]::Matches($IndexHtml, 'content="[^"]*(assets/[^"]+)"') | ForEach-Object { $_.Groups[1].Value }
$ImageTargets += [regex]::Matches($Readme, '!\[[^\]]*\]\(([^)]+)\)') | ForEach-Object { $_.Groups[1].Value }
foreach ($Src in ($ImageTargets | Sort-Object -Unique)) {
  if ($Src -match "^[a-zA-Z][a-zA-Z0-9+.-]*:") {
    $Uri = [uri]$Src
    $Target = $Uri.AbsolutePath.TrimStart("/")
    $RepoPrefix = "$Repo/"
    if ($Target.StartsWith($RepoPrefix)) {
      $Target = $Target.Substring($RepoPrefix.Length)
    } else {
      continue
    }
  } else {
    $Target = ($Src -split "#")[0]
  }
  if (-not $Target) { continue }
  $TargetPath = Join-Path $Script:RepoRoot $Target
  if (-not (Test-Path -LiteralPath $TargetPath -PathType Leaf)) {
    throw "Broken local image src: $Src"
  }
}
Write-Host "OK local image targets"

Step "Checking encoding"
$TextFiles = @(
  "README.md",
  "AGENTS.md",
  "CLAUDE.md",
  "COPY.md",
  "index.html",
  "landing.css",
  "LAUNCH.md",
  "LAUNCH-TRACKER.md",
  "SHARE.md",
  "MAINTENANCE-CHECKLIST.md",
  "TROUBLESHOOTING.md",
  "FAQ.md",
  "skills/design-system/SKILL.md"
)
foreach ($RelativePath in $TextFiles) {
  Assert-NoEncodingArtifacts (Join-Path $Script:RepoRoot $RelativePath)
}

Step "Parsing package metadata"
& node -e "JSON.parse(require('fs').readFileSync(process.argv[1], 'utf8')); JSON.parse(require('fs').readFileSync(process.argv[2], 'utf8'))" (Join-Path $Script:RepoRoot "package.json") (Join-Path $Script:RepoRoot "package-lock.json")
if ($LASTEXITCODE -ne 0) { throw "Package metadata JSON parse failed." }
Write-Host "OK package metadata parses"

Step "Local asset checks passed"
