# 🚀 QUICK START GUIDE

## The Problem
**"Can't connect to server"** means the backend is not running!
**"Path unavailable on web"** - FIXED! Now works on web platform.

## The Solution (3 Steps)

### Step 1: Open First Terminal - Start Backend

```bash
cd backend
pip install -r requirements.txt
python -m uvicorn app:app --reload
```

**✅ You should see:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Application startup complete.
```

**✅ Test it:** Open browser → http://localhost:8000
- Should show: `{"message":"Backend is running"}`

**⚠️ IMPORTANT: Keep this terminal open!**

---

### Step 2: Open Second Terminal - Start Frontend

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

**Note:** Using Chrome web version (works on all platforms!)

**Other options:**
- `-d edge` (Microsoft Edge browser)
- `-d windows` (requires Visual Studio with C++ tools)
- `-d macos` (macOS only)
- `-d linux` (Linux only)

---

### Step 3: Use the App

1. App should now connect successfully ✅
2. Select "Staff Member"
3. Click "Upload Deadlines"
4. Choose `sample_deadlines.csv`
5. Deadlines will be saved to database!

**✅ The app now works on web - file upload fixed!**

---

## 🪟 Windows Quick Start

**Double-click:** `START_HERE.bat`

This will:
1. Install dependencies
2. Start the backend server
3. Show you when it's ready

Then in a **new terminal**:
```bash
cd frontend
flutter run -d windows
```

---

## ❌ Troubleshooting

### Backend won't start?

**Check Python:**
```bash
python --version
```
Need Python 3.7+

**Reinstall dependencies:**
```bash
cd backend
pip install --upgrade pip
pip install -r requirements.txt
```

### Frontend can't connect?

1. **Is backend running?** Check Terminal 1
2. **Test in browser:** http://localhost:8000
3. **Check port:** Look for "running on http://127.0.0.1:XXXX"
   - If not 8000, edit `frontend/lib/api_service.dart` line 10

### Port 8000 already in use?

**Start on different port:**
```bash
python -m uvicorn app:app --reload --port 8001
```

**Then update frontend:**
Edit `frontend/lib/api_service.dart`:
```dart
static const String baseUrl = 'http://localhost:8001';
```

---

## 📋 Checklist

- [ ] Backend terminal is open and shows "Application startup complete"
- [ ] Browser shows `{"message":"Backend is running"}` at http://localhost:8000
- [ ] Frontend terminal is running Flutter app
- [ ] App connects without errors

---

## 🆘 Still Need Help?

See `TROUBLESHOOTING.md` for detailed solutions!
