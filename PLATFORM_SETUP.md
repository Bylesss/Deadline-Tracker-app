# Flutter Platform Setup Issues

## Issue: "Unable to find suitable Visual Studio toolchain"

This means you're trying to run Flutter on Windows desktop, which requires Visual Studio.

## ✅ EASY FIX: Run on Web Instead

The app works perfectly in Chrome! No additional setup needed.

### Run on Chrome Web:

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

This will open the app in Chrome browser. ✅

---

## Alternative: Install Visual Studio for Windows Desktop

If you want to run as a native Windows app:

### Step 1: Download Visual Studio
Get **Visual Studio 2022 Community** (free):
https://visualstudio.microsoft.com/downloads/

### Step 2: During Installation
Select these workloads:
- ✅ **Desktop development with C++**

### Step 3: Verify Installation
```bash
flutter doctor
```

Should show:
```
[✓] Visual Studio - develop for Windows
```

### Step 4: Run Flutter
```bash
cd frontend
flutter run -d windows
```

---

## Check Available Platforms

See what platforms you can run on:

```bash
flutter devices
```

You should see:
- **Chrome (web)** - ✅ Works out of the box
- **Edge (web)** - ✅ Works out of the box
- Windows (desktop) - ❌ Requires Visual Studio
- Android emulator - If Android Studio installed
- Connected phone - If USB debugging enabled

---

## Recommended: Use Chrome Web

**Advantages:**
- ✅ No additional setup required
- ✅ Works immediately
- ✅ Easier debugging
- ✅ All features work (CSV upload, calendar, etc.)

**Command:**
```bash
flutter run -d chrome
```

---

## Run Flutter Doctor

To see what's available on your system:

```bash
flutter doctor -v
```

This shows:
- What's installed ✅
- What's missing ❌
- How to fix issues 🔧

---

## Quick Reference

| Platform | Command | Requirements |
|----------|---------|--------------|
| **Chrome** | `flutter run -d chrome` | ✅ None (works immediately) |
| **Edge** | `flutter run -d edge` | ✅ None (works immediately) |
| Windows | `flutter run -d windows` | ❌ Visual Studio + C++ tools |
| Android | `flutter run -d android` | ❌ Android Studio |

---

## Summary

**For quickest start, use Chrome:**

```bash
cd frontend
flutter run -d chrome
```

The app will open in your browser and work exactly the same! 🚀
