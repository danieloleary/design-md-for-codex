$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib\common.ps1")

$Contract = Get-ProjectContract
$Owner = $Contract.repository.owner
$Repo = $Contract.repository.name
$MainBranch = $Contract.repository.branch
$PagesRoot = $Contract.repository.pagesUrl.TrimEnd("/")
$GitHubRoot = $Contract.repository.url.TrimEnd("/")
$SkillPath = ($Contract.skill.path -replace "\\", "/").Trim("/")
$SkillTreeUrl = $Contract.skill.url
$InstallPrompt = $Contract.skill.installPrompt

Step "Checking public contract"
$ExpectedGitHubRoot = "https://github.com/$Owner/$Repo"
$ExpectedPagesRoot = "https://$Owner.github.io/$Repo"
$ExpectedSkillTreeUrl = "$GitHubRoot/tree/$MainBranch/$SkillPath"
$ExpectedInstallPrompt = "Use `$skill-installer to install $ExpectedSkillTreeUrl"

if ($GitHubRoot -ne $ExpectedGitHubRoot) { throw "public-contract.json repository.url must be $ExpectedGitHubRoot" }
if ($PagesRoot -ne $ExpectedPagesRoot) { throw "public-contract.json repository.pagesUrl must be $ExpectedPagesRoot/" }
if ($SkillTreeUrl -ne $ExpectedSkillTreeUrl) { throw "public-contract.json skill.url must be $ExpectedSkillTreeUrl" }
if ($InstallPrompt -ne $ExpectedInstallPrompt) { throw "public-contract.json skill.installPrompt must match the skill URL." }
Require-File (Join-Path $Script:RepoRoot $Contract.publicFiles.readme)
Require-File (Join-Path $Script:RepoRoot $Contract.publicFiles.rootDesign)
Require-File (Join-Path $Script:RepoRoot $Contract.publicFiles.landingPage)
Require-File (Join-Path $Script:RepoRoot $Contract.publicFiles.skillEntry)
Require-File (Join-Path $Script:RepoRoot $Contract.publicFiles.designReference)
Write-Host "OK public contract"

Step "Checking primary copy surfaces"
$IndexHtml = Get-Content (Join-Path $Script:RepoRoot "index.html") -Raw
$Readme = Get-Content (Join-Path $Script:RepoRoot "README.md") -Raw
if ($IndexHtml -notlike "*$InstallPrompt*") { throw "index.html does not include the expected install prompt." }
if ($Readme -notlike "*$InstallPrompt*") { throw "README.md does not include the expected install prompt." }
if ($IndexHtml -notlike "*$($Contract.repository.pagesUrl)*") { throw "index.html does not include the expected Pages URL." }
if ($Readme -notlike "*$($Contract.repository.pagesUrl)*") { throw "README.md does not include the expected Pages URL." }
if ($IndexHtml -notlike "*$GitHubRoot*") { throw "index.html does not include the expected repo URL." }
if ($IndexHtml -notmatch "data-copy-install") { throw "index.html is missing the copy install button hook." }
Write-Host "OK install prompt and copy hook"

Step "Checking repeated install URLs for drift"
$Extensions = @(".md", ".html", ".ps1", ".mjs", ".py", ".json", ".yaml", ".yml")
$ExcludedDirs = @(".git", "node_modules", "output")
$SkillUrlPattern = 'https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/tree/[A-Za-z0-9_.-]+/skills/design-system'
$InstallPromptPattern = 'Use \$skill-installer to install https://github\.com/[^\s`"<>)]+' 
$Drift = New-Object System.Collections.Generic.List[string]

$Files = Get-ChildItem -LiteralPath $Script:RepoRoot -Recurse -File |
  Where-Object { $Extensions -contains $_.Extension }

foreach ($File in $Files) {
  $Relative = $File.FullName.Substring($Script:RepoRoot.Length).TrimStart("\", "/")
  if ($Relative -eq "package-lock.json") { continue }

  $RelativeParts = $Relative -split "[\\/]"
  if ($ExcludedDirs | Where-Object { $RelativeParts -contains $_ }) { continue }

  $Content = Get-Content -LiteralPath $File.FullName -Raw
  foreach ($Match in [regex]::Matches($Content, $SkillUrlPattern)) {
    if ($Match.Value -ne $SkillTreeUrl) {
      $Drift.Add("$Relative has stale skill URL: $($Match.Value)")
    }
  }
  foreach ($Match in [regex]::Matches($Content, $InstallPromptPattern)) {
    if ($Match.Value -ne $InstallPrompt) {
      $Drift.Add("$Relative has stale install prompt: $($Match.Value)")
    }
  }
}

if ($Drift.Count -gt 0) {
  throw ("Contract drift found:`n" + ($Drift -join "`n"))
}
Write-Host "OK repeated install URLs match public-contract.json"

Step "Public contract checks passed"
