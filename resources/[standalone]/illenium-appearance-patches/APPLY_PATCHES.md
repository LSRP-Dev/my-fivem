# How to Apply illenium-appearance Patches

## After Installing illenium-appearance

1. **Copy the patched framework files:**

   From: `resources/[standalone]/illenium-appearance-patches/`
   
   To: `resources/[standalone]/illenium-appearance/`

   **Files to copy:**
   - `shared_framework_framework.lua` → `shared/framework/framework.lua`
   - `server_framework_qb_main.lua` → `server/framework/qb/main.lua`
   - `client_framework_qb_main.lua` → `client/framework/qb/main.lua`

2. **Or use the auto-patch script:**
   ```bash
   # Windows PowerShell
   .\apply_patches.ps1
   
   # Linux/Mac
   ./apply_patches.sh
   ```

3. **Restart your server**

## What These Patches Do:

- ✅ Enable QBX Core detection in framework.lua
- ✅ Route all QB Core API calls through illenium-qbx-bridge
- ✅ Fix "No export Functions" errors
- ✅ Enable proper GetPlayer() and GetPlayerData() calls
- ✅ Fix HasTracker() and other framework functions

## Verification:

After applying patches, check console for:
```
[illenium-qbx-bridge] Server bridge initialized successfully!
[illenium-appearance] Using QBX Bridge for QBX Core compatibility
```

No errors should appear!

