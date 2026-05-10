param(
  [switch]$SkipPublicDrift
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ContractPath = Join-Path $RepoRoot "public-contract.json"
$Contract = Get-Content -LiteralPath $ContractPath -Raw | ConvertFrom-Json
$Owner = $Contract.repository.owner
$Repo = $Contract.repository.name
$MainBranch = $Contract.repository.branch
$PagesRoot = $Contract.repository.pagesUrl.TrimEnd("/")
$GitHubRoot = $Contract.repository.url.TrimEnd("/")
$SkillPath = ($Contract.skill.path -replace "\\", "/").Trim("/")
$SkillTreeUrl = $Contract.skill.url
$InstallPrompt = $Contract.skill.installPrompt
$TempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("design-md-ci-" + [guid]::NewGuid().ToString("N"))

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

function Assert-Url($Url, $ExpectedPattern = $null) {
  $Response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 30
  if ($Response.StatusCode -ne 200) {
    throw "Unexpected status $($Response.StatusCode) for $Url"
  }
  $Content = $Response.Content
  if ($Content -is [byte[]]) {
    $Content = [System.Text.Encoding]::UTF8.GetString($Content)
  }
  if ($ExpectedPattern -and ($Content -notmatch $ExpectedPattern)) {
    throw "Expected content not found at $Url"
  }
  Write-Host "OK $Url"
}

function Assert-NoEncodingArtifacts($Path) {
  $Content = Get-Content -LiteralPath $Path -Raw
  $BadChars = @([char]0x00C3, [char]0x00E2, [char]0x00EF, [char]0xFFFD)
  foreach ($BadChar in $BadChars) {
    if ($Content.Contains($BadChar)) {
      throw "Possible encoding artifact in $Path"
    }
  }
  Write-Host "OK no encoding artifacts in $Path"
}

try {
  Step "Checking CI tooling"
  Require-Command "node"
  Require-Command "npx"
  Require-Command "Expand-Archive"

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
    Require-File (Join-Path $RepoRoot $RelativePath)
  }

  Step "Checking public contract"
  $ExpectedGitHubRoot = "https://github.com/$Owner/$Repo"
  $ExpectedPagesRoot = "https://$Owner.github.io/$Repo"
  $ExpectedSkillTreeUrl = "$GitHubRoot/tree/$MainBranch/$SkillPath"
  $ExpectedInstallPrompt = "Use `$skill-installer to install $ExpectedSkillTreeUrl"
  if ($GitHubRoot -ne $ExpectedGitHubRoot) { throw "public-contract.json repository.url must be $ExpectedGitHubRoot" }
  if ($PagesRoot -ne $ExpectedPagesRoot) { throw "public-contract.json repository.pagesUrl must be $ExpectedPagesRoot/" }
  if ($SkillTreeUrl -ne $ExpectedSkillTreeUrl) { throw "public-contract.json skill.url must be $ExpectedSkillTreeUrl" }
  if ($InstallPrompt -ne $ExpectedInstallPrompt) { throw "public-contract.json skill.installPrompt must match the skill URL." }
  Require-File (Join-Path $RepoRoot $Contract.publicFiles.readme)
  Require-File (Join-Path $RepoRoot $Contract.publicFiles.rootDesign)
  Require-File (Join-Path $RepoRoot $Contract.publicFiles.landingPage)
  Require-File (Join-Path $RepoRoot $Contract.publicFiles.skillEntry)
  Require-File (Join-Path $RepoRoot $Contract.publicFiles.designReference)
  Write-Host "OK public contract"

  Step "Checking copy and install text"
  $IndexHtml = Get-Content (Join-Path $RepoRoot "index.html") -Raw
  $Readme = Get-Content (Join-Path $RepoRoot "README.md") -Raw
  if ($IndexHtml -notlike "*$InstallPrompt*") { throw "index.html does not include the expected install prompt." }
  if ($Readme -notlike "*$InstallPrompt*") { throw "README.md does not include the expected install prompt." }
  if ($IndexHtml -notlike "*$($Contract.repository.pagesUrl)*") { throw "index.html does not include the expected Pages URL." }
  if ($Readme -notlike "*$($Contract.repository.pagesUrl)*") { throw "README.md does not include the expected Pages URL." }
  if ($IndexHtml -notlike "*$GitHubRoot*") { throw "index.html does not include the expected repo URL." }
  if ($IndexHtml -notmatch "data-copy-install") { throw "index.html is missing the copy install button hook." }
  Write-Host "OK install prompt and copy hook"

  Step "Checking local links"
  $HrefMatches = [regex]::Matches($IndexHtml, 'href="([^"]+)"')
  foreach ($Match in $HrefMatches) {
    $Href = $Match.Groups[1].Value
    if ($Href.StartsWith("#") -or $Href -match "^[a-zA-Z][a-zA-Z0-9+.-]*:") { continue }
    $Target = ($Href -split "#")[0]
    if (-not $Target) { continue }
    $TargetPath = Join-Path $RepoRoot $Target
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
    $TargetPath = Join-Path $RepoRoot $Target
    if (-not (Test-Path -LiteralPath $TargetPath -PathType Leaf)) {
      throw "Broken local image src: $Src"
    }
  }
  Write-Host "OK local image targets"

  Step "Checking encoding"
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "README.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "AGENTS.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "CLAUDE.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "COPY.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "index.html")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "landing.css")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "LAUNCH.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "LAUNCH-TRACKER.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "SHARE.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "MAINTENANCE-CHECKLIST.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "TROUBLESHOOTING.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "FAQ.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "skills/design-system/SKILL.md")

  Step "Linting DESIGN.md files with latest validator"
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Root DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "skills/design-system/references/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Bundled DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "examples/minimal-repo/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Minimal DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "qa/fixture/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "QA fixture DESIGN.md lint failed." }

  Step "Parsing tokens"
  Get-Content (Join-Path $RepoRoot "skills/design-system/references/tokens.json") | ConvertFrom-Json | Out-Null
  Write-Host "OK tokens.json parses"

  Step "Parsing Node package metadata"
  & node -e "JSON.parse(require('fs').readFileSync(process.argv[1], 'utf8')); JSON.parse(require('fs').readFileSync(process.argv[2], 'utf8'))" (Join-Path $RepoRoot "package.json") (Join-Path $RepoRoot "package-lock.json")
  if ($LASTEXITCODE -ne 0) { throw "Package metadata JSON parse failed." }
  Write-Host "OK package metadata parses"

  if ($SkipPublicDrift) {
    Step "Skipping public drift checks"
    Write-Host "OK public GitHub Pages/archive checks skipped for local or PR validation"
  } else {
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
  }

  Step "CI check passed"
} finally {
  if (Test-Path -LiteralPath $TempRoot) {
    Remove-Item -LiteralPath $TempRoot -Recurse -Force
  }
}
