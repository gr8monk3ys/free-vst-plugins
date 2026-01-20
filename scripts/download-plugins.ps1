# Free VST Plugins Downloader for Windows
# PowerShell wrapper for the Python download script

param(
    [switch]$All,
    [switch]$Synths,
    [switch]$Effects,
    [switch]$Instruments,
    [switch]$Bundles,
    [switch]$List,
    [string]$Dir,
    [switch]$Help
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Build arguments for Python script
$args = @()

if ($Help) { $args += "--help" }
if ($All) { $args += "--all" }
if ($Synths) { $args += "--synths" }
if ($Effects) { $args += "--effects" }
if ($Instruments) { $args += "--instruments" }
if ($Bundles) { $args += "--bundles" }
if ($List) { $args += "--list" }
if ($Dir) { $args += "--dir"; $args += $Dir }

# Check for Python
$python = $null
foreach ($cmd in @("python3", "python", "py")) {
    try {
        $version = & $cmd --version 2>&1
        if ($version -match "Python 3") {
            $python = $cmd
            break
        }
    } catch {}
}

if (-not $python) {
    Write-Host "Error: Python 3 not found. Please install Python 3 from https://python.org" -ForegroundColor Red
    exit 1
}

# Run the Python script
$pythonScript = Join-Path $ScriptDir "download-plugins.py"
& $python $pythonScript @args
