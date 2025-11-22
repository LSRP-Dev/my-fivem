#!/bin/bash
# Auto-patch script for illenium-appearance Qbox compatibility
# Run this AFTER installing illenium-appearance

ILLENIUM_PATH="../illenium-appearance"
PATCH_PATH="$(cd "$(dirname "$0")" && pwd)"

echo "Applying illenium-appearance patches for Qbox..."

# Check if illenium-appearance exists
if [ ! -d "$ILLENIUM_PATH" ]; then
    echo "ERROR: illenium-appearance not found at: $ILLENIUM_PATH"
    echo "Please install illenium-appearance first!"
    echo "Download from: https://github.com/iLLeniumStudios/illenium-appearance/releases/tag/qbox"
    exit 1
fi

# Copy framework.lua
if [ -f "$ILLENIUM_PATH/shared/framework/framework.lua" ]; then
    cp "$PATCH_PATH/shared_framework_framework.lua" "$ILLENIUM_PATH/shared/framework/framework.lua"
    echo "✓ Patched: shared/framework/framework.lua"
else
    echo "WARNING: Destination not found: $ILLENIUM_PATH/shared/framework/framework.lua"
fi

# Copy server framework
if [ -f "$ILLENIUM_PATH/server/framework/qb/main.lua" ]; then
    cp "$PATCH_PATH/server_framework_qb_main.lua" "$ILLENIUM_PATH/server/framework/qb/main.lua"
    echo "✓ Patched: server/framework/qb/main.lua"
else
    echo "WARNING: Destination not found: $ILLENIUM_PATH/server/framework/qb/main.lua"
fi

# Copy client framework
if [ -f "$ILLENIUM_PATH/client/framework/qb/main.lua" ]; then
    cp "$PATCH_PATH/client_framework_qb_main.lua" "$ILLENIUM_PATH/client/framework/qb/main.lua"
    echo "✓ Patched: client/framework/qb/main.lua"
else
    echo "WARNING: Destination not found: $ILLENIUM_PATH/client/framework/qb/main.lua"
fi

echo ""
echo "Patches applied successfully!"
echo "Please restart your server to apply changes."
