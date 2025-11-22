# Auto-patch script for illenium-appearance Qbox compatibility
# Run this AFTER installing illenium-appearance

$illeniumPath = "..\illenium-appearance"
$patchPath = $PSScriptRoot

Write-Host "Applying illenium-appearance patches for Qbox..." -ForegroundColor Cyan

# Check if illenium-appearance exists
if (-not (Test-Path $illeniumPath)) {
    Write-Host "ERROR: illenium-appearance not found at: $illeniumPath" -ForegroundColor Red
    Write-Host "Please install illenium-appearance first!" -ForegroundColor Yellow
    Write-Host "Download from: https://github.com/iLLeniumStudios/illenium-appearance/releases/tag/qbox" -ForegroundColor Yellow
    exit 1
}

# Copy framework.lua
$source = Join-Path $patchPath "shared_framework_framework.lua"
$dest = Join-Path $illeniumPath "shared\framework\framework.lua"
if (Test-Path $dest) {
    Copy-Item $source $dest -Force
    Write-Host "✓ Patched: shared/framework/framework.lua" -ForegroundColor Green
} else {
    Write-Host "WARNING: Destination not found: $dest" -ForegroundColor Yellow
}

# Copy server framework
$source = Join-Path $patchPath "server_framework_qb_main.lua"
$dest = Join-Path $illeniumPath "server\framework\qb\main.lua"
if (Test-Path $dest) {
    Copy-Item $source $dest -Force
    Write-Host "✓ Patched: server/framework/qb/main.lua" -ForegroundColor Green
} else {
    Write-Host "WARNING: Destination not found: $dest" -ForegroundColor Yellow
}

# Copy client framework
$source = Join-Path $patchPath "client_framework_qb_main.lua"
$dest = Join-Path $illeniumPath "client\framework\qb\main.lua"
if (Test-Path $dest) {
    Copy-Item $source $dest -Force
    Write-Host "✓ Patched: client/framework/qb/main.lua" -ForegroundColor Green
} else {
    Write-Host "WARNING: Destination not found: $dest" -ForegroundColor Yellow
}

Write-Host "`nPatches applied successfully!" -ForegroundColor Green
Write-Host "Please restart your server to apply changes." -ForegroundColor Cyan
