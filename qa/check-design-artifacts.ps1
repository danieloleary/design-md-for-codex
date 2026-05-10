$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib\common.ps1")

Step "Linting DESIGN.md files"
$RootDesign = Join-Path $Script:RepoRoot "DESIGN.md"
$BundledDesign = Join-Path $Script:RepoRoot "skills/design-system/references/DESIGN.md"
$MinimalDesign = Join-Path $Script:RepoRoot "examples/minimal-repo/DESIGN.md"
$FixtureDesign = Join-Path $Script:RepoRoot "qa/fixture/DESIGN.md"

& npx --yes @google/design.md@latest lint $RootDesign
if ($LASTEXITCODE -ne 0) { throw "Root DESIGN.md lint failed." }
& npx --yes @google/design.md@latest lint $BundledDesign
if ($LASTEXITCODE -ne 0) { throw "Bundled DESIGN.md lint failed." }
& npx --yes @google/design.md@latest lint $MinimalDesign
if ($LASTEXITCODE -ne 0) { throw "Minimal DESIGN.md lint failed." }
& npx --yes @google/design.md@latest lint $FixtureDesign
if ($LASTEXITCODE -ne 0) { throw "QA fixture DESIGN.md lint failed." }

Step "Parsing tokens"
Get-Content (Join-Path $Script:RepoRoot "skills/design-system/references/tokens.json") | ConvertFrom-Json | Out-Null
Write-Host "OK tokens.json parses"

Step "Verifying saved fixture proof"
$FixtureVerifier = Join-Path $Script:RepoRoot "qa/verify-fixture.mjs"
& node $FixtureVerifier
if ($LASTEXITCODE -ne 0) { throw "Fixture verifier failed." }

Step "Design artifact checks passed"
