$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSrc = Join-Path $ScriptDir "skills"
$SkillsDst = Join-Path $env:USERPROFILE ".claude\skills"

if (-not (Test-Path $SkillsSrc)) {
    Write-Error "Error: skills/ directory not found at $SkillsSrc"
    exit 1
}

if (-not (Test-Path $SkillsDst)) {
    New-Item -ItemType Directory -Path $SkillsDst -Force | Out-Null
}

$installed = 0
Get-ChildItem -Path $SkillsSrc -Directory -Filter "mmpf-*" | ForEach-Object {
    $target = Join-Path $SkillsDst $_.Name
    if (Test-Path $target) {
        Remove-Item -Recurse -Force $target
    }
    Copy-Item -Recurse $_.FullName $target
    Write-Host "  Installed $($_.Name)"
    $installed++
}

Write-Host ""
Write-Host "Done. $installed MMPF skills installed to $SkillsDst"
