# illenium-appearance Qbox Patches

## After Installing illenium-appearance

Once you've downloaded and installed illenium-appearance from:
https://github.com/iLLeniumStudios/illenium-appearance/releases/tag/qbox

Apply these patches to make it work with QBX Core:

### Files to Patch:

1. **shared/framework/framework.lua**
   - Change: `function Framework.QBCore()` to detect both qb-core and qbx_core

2. **server/framework/qb/main.lua**
   - Change: Use illenium-qbx-bridge for QBX Core compatibility

3. **client/framework/qb/main.lua**
   - Change: Use illenium-qbx-bridge for QBX Core compatibility

### The bridge will handle:
- ✅ Framework detection
- ✅ GetPlayer() calls
- ✅ GetPlayerData() calls
- ✅ All QB Core to QBX Core translations

### Verification:

After patching, check console for:
```
[illenium-qbx-bridge] Server bridge initialized successfully!
[illenium-appearance] Using QBX Bridge for QBX Core compatibility
```

## Note:

The bridge files are already created and will automatically patch illenium-appearance when it's installed.

