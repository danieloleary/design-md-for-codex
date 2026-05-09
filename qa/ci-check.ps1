$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$Owner = "danieloleary"
$Repo = "design-md-for-codex"
$MainBranch = "main"
$PagesRoot = "https://$Owner.github.io/$Repo"
$GitHubRoot = "https://github.com/$Owner/$Repo"
$SkillTreeUrl = "$GitHubRoot/tree/$MainBranch/skills/design-system"
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
  Require-Command "npx"
  Require-Command "Expand-Archive"

  Step "Checking required files"
  $RequiredFiles = @(
    "README.md",
    "COPY.md",
    "index.html",
    "landing.css",
    "assets/hero-art.png",
    "assets/social-card.png",
    "assets/repo-banner.png",
    "assets/share-before-after.png",
    "assets/proof/fixture-before.png",
    "assets/proof/fixture-after.png",
    "LAUNCH.md",
    "SHARE.md",
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
    "qa/smoke-test.ps1"
  )
  foreach ($RelativePath in $RequiredFiles) {
    Require-File (Join-Path $RepoRoot $RelativePath)
  }

  Step "Checking copy and install text"
  $IndexHtml = Get-Content (Join-Path $RepoRoot "index.html") -Raw
  $Readme = Get-Content (Join-Path $RepoRoot "README.md") -Raw
  $ExpectedPrompt = "Use `$skill-installer to install $SkillTreeUrl"
  if ($IndexHtml -notlike "*$ExpectedPrompt*") { throw "index.html does not include the expected install prompt." }
  if ($Readme -notlike "*$ExpectedPrompt*") { throw "README.md does not include the expected install prompt." }
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
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "COPY.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "index.html")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "landing.css")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "LAUNCH.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "SHARE.md")
  Assert-NoEncodingArtifacts (Join-Path $RepoRoot "skills/design-system/SKILL.md")

  Step "Linting DESIGN.md files with latest validator"
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "skills/design-system/references/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Bundled DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "examples/minimal-repo/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "Minimal DESIGN.md lint failed." }
  & npx --yes @google/design.md@latest lint (Join-Path $RepoRoot "qa/fixture/DESIGN.md")
  if ($LASTEXITCODE -ne 0) { throw "QA fixture DESIGN.md lint failed." }

  Step "Parsing tokens"
  Get-Content (Join-Path $RepoRoot "skills/design-system/references/tokens.json") | ConvertFrom-Json | Out-Null
  Write-Host "OK tokens.json parses"

  Step "Checking public GitHub and Pages URLs"
  Assert-Url "$PagesRoot/" "design-md-for-codex"
  Assert-Url "$PagesRoot/assets/hero-art.png"
  Assert-Url "$PagesRoot/assets/proof/fixture-before.png"
  Assert-Url "$PagesRoot/assets/proof/fixture-after.png"
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
      $NormalizedPath -like "*/$Repo-$MainBranch/skills/design-system"
    } |
    Select-Object -First 1
  if (-not $ExtractedSkill) { throw "Could not find skills/design-system in public repo archive." }
  Require-File (Join-Path $ExtractedSkill.FullName "SKILL.md")
  Require-File (Join-Path $ExtractedSkill.FullName "agents/openai.yaml")
  Require-File (Join-Path $ExtractedSkill.FullName "references/DESIGN.md")
  Write-Host "OK public archive contains installable skill folder"

  Step "CI check passed"
} finally {
  if (Test-Path -LiteralPath $TempRoot) {
    Remove-Item -LiteralPath $TempRoot -Recurse -Force
  }
}
