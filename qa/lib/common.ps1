$ErrorActionPreference = "Stop"

$Script:QaLibRoot = Split-Path -Parent $PSCommandPath
$Script:QaRoot = Split-Path -Parent $Script:QaLibRoot
$Script:RepoRoot = Split-Path -Parent $Script:QaRoot
$Script:ContractPath = Join-Path $Script:RepoRoot "public-contract.json"

function Step($Message) {
  Write-Host ""
  Write-Host "== $Message" -ForegroundColor Cyan
}

function Get-ProjectContract {
  Get-Content -LiteralPath $Script:ContractPath -Raw | ConvertFrom-Json
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
