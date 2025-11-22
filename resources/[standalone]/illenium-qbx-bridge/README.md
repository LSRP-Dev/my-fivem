# illenium-appearance QBX Bridge

A compatibility bridge that allows **illenium-appearance** to work seamlessly with **QBX Core (QBox)** without modifying the original illenium-appearance files.

## 🎯 Purpose

This bridge translates QB Core API calls to QBX Core equivalents, allowing illenium-appearance to function properly on QBX-based servers.

## 📋 Features

- ✅ **Automatic Detection** - Detects QBX Core and routes calls accordingly
- ✅ **Zero Configuration** - Works out of the box
- ✅ **Non-Invasive** - Doesn't modify original illenium-appearance files
- ✅ **Fallback Support** - Still works with regular QB Core if needed

## 🚀 Installation

1. **Place the resource** in `resources/[standalone]/illenium-qbx-bridge/`

2. **Ensure proper load order** in `server.cfg`:
   ```cfg
   ensure qbx_core
   ensure illenium-qbx-bridge  # Load BEFORE illenium-appearance
   ensure illenium-appearance
   ```

3. **Restart your server**

## ⚙️ How It Works

The bridge intercepts QB Core API calls from illenium-appearance and routes them to QBX Core:

- `QBCore.Functions.GetPlayer()` → `exports.qbx_core:GetPlayer()`
- `QBCore.Functions.GetPlayerData()` → `exports.qbx_core.Functions.GetPlayerData()`
- All other QB Core functions are mapped to their QBX equivalents

## 🔍 Verification

After starting your server, you should see:
```
[illenium-qbx-bridge] Server bridge initialized successfully!
[illenium-qbx-bridge] Client bridge initialized successfully!
[illenium-appearance] Using QBX Bridge for QBX Core compatibility
```

## 🐛 Troubleshooting

**Bridge not initializing:**
- Ensure `qbx_core` is loaded before the bridge
- Check that `qbx_core` is actually started

**illenium-appearance still has errors:**
- Verify the bridge loads before illenium-appearance
- Check server console for bridge initialization messages
- Restart both resources: `restart illenium-qbx-bridge` then `restart illenium-appearance`

## 📝 Technical Details

The bridge creates a compatibility layer that:
1. Detects QBX Core availability
2. Creates QB Core-compatible function wrappers
3. Routes all calls to QBX Core equivalents
4. Provides seamless integration for illenium-appearance

## ✅ Compatibility

- ✅ QBX Core (QBox)
- ✅ illenium-appearance v5.7.0+
- ✅ FiveM Server Build 2800+

## 📄 License

This bridge is provided as-is for compatibility purposes.
