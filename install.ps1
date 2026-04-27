$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillsSrc = Join-Path $ScriptDir "skills"
$SharedRefs = Join-Path $ScriptDir "references"

# Get runtime selector from first parameter, default to 'both'
$Runtime = if ($args.Count -gt 0) { $args[0] } else { "both" }

# Validate runtime parameter
if ($Runtime -notmatch "^(claude|copilot|both)$") {
    Write-Host "Usage: .\install.ps1 [claude|copilot|both]"
    Write-Host ""
    Write-Host "  claude   Install to `$env:USERPROFILE\.claude\skills only"
    Write-Host "  copilot  Install to `$env:USERPROFILE\.copilot\skills only"
    Write-Host "  both     Install to both locations (default)"
    exit 1
}

if (-not (Test-Path $SkillsSrc)) {
    Write-Error "Error: skills/ directory not found at $SkillsSrc"
    exit 1
}

function Install-ToDestination {
    param(
        [string]$DestinationName,
        [string]$SkillsDst
    )

    if (-not (Test-Path $SkillsDst)) {
        New-Item -ItemType Directory -Path $SkillsDst -Force | Out-Null
    }

    # Clean up existing mmpf-* directories for this runtime only
    Get-ChildItem -Path $SkillsDst -Directory -Filter "mmpf-*" -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item -Recurse -Force $_.FullName
    }

    $installed = 0
    Get-ChildItem -Path $SkillsSrc -Directory -Filter "mmpf-*" | ForEach-Object {
        $target = Join-Path $SkillsDst $_.Name
        Copy-Item -Recurse $_.FullName $target

        # Copy shared references into each installed skill
        if (Test-Path $SharedRefs) {
            $refsTarget = Join-Path $target "references"
            if (-not (Test-Path $refsTarget)) {
                New-Item -ItemType Directory -Path $refsTarget -Force | Out-Null
            }
            Copy-Item (Join-Path $SharedRefs "*.md") $refsTarget
        }

        Write-Host "  Installed $($_.Name) to $DestinationName"
        $installed++
    }

    Write-Host "Done. $installed MMPF skills installed to $SkillsDst"
}

Write-Host "Installing MMPF skills to runtime: $Runtime"
Write-Host ""

switch ($Runtime) {
    "claude" {
        $ClaudeSkills = Join-Path $env:USERPROFILE ".claude\skills"
        Install-ToDestination "Claude" $ClaudeSkills
    }
    "copilot" {
        $CopilotSkills = Join-Path $env:USERPROFILE ".copilot\skills"
        Install-ToDestination "Copilot" $CopilotSkills
    }
    "both" {
        $ClaudeSkills = Join-Path $env:USERPROFILE ".claude\skills"
        $CopilotSkills = Join-Path $env:USERPROFILE ".copilot\skills"
        Install-ToDestination "Claude" $ClaudeSkills
        Write-Host ""
        Install-ToDestination "Copilot" $CopilotSkills
    }
}
