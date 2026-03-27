# Connection Troubleshooting Guide

## Quick Fix Steps

### Step 1: Start the Backend Server

Open a **NEW terminal/command prompt** and run:

```bash
cd backend
python -m uvicorn app:app --reload
```

You should see:
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
INFO:     Started server process
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

**Keep this terminal open!** The server must stay running.

### Step 2: Test the Backend

Open your browser and go to: **http://localhost:8000**

You should see:
```json
{"message":"Backend is running"}
```

If you see this, the backend is working! ✅

### Step 3: Check Frontend Configuration

The frontend is configured to connect to: **http://localhost:8000**

If your backend is running on a different address, update:
- File: `frontend/lib/api_service.dart`
- Line 9: `static const String baseUrl = 'http://localhost:8000';`

### Step 4: Run the Frontend

In a **separate terminal**, run:

```bash
cd frontend
flutter run
```

---

## Common Issues

### Issue 1: "Connection refused" or "Can't connect"

**Cause:** Backend server is not running

**Fix:**
1. Open a terminal
2. `cd backend`
3. `python -m uvicorn app:app --reload`
4. Keep this terminal open

### Issue 2: "Module not found" errors

**Cause:** Python dependencies not installed

**Fix:**
```bash
cd backend
pip install -r requirements.txt
```

### Issue 3: Backend runs but connection still fails

**Cause:** Port mismatch or firewall

**Fix:**
1. Check what port backend is running on (look for "running on http://...")
2. Update frontend `api_service.dart` if port is different
3. Try: http://127.0.0.1:8000 instead of http://localhost:8000

### Issue 4: "ModuleNotFoundError: No module named 'database'"

**Cause:** Running from wrong directory

**Fix:**
```bash
# Make sure you're in the backend directory
cd backend
python -m uvicorn app:app --reload
```

### Issue 5: Flutter web and localhost issues

**Cause:** Browser security restrictions

**Fix:** Run Flutter on Windows/macOS/Linux desktop instead:
```bash
flutter run -d windows  # or macos, linux
```

Or use Chrome with disabled security:
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

---

## Verify Backend is Running

### Method 1: Check the Terminal
Look for:
```
INFO:     Uvicorn running on http://127.0.0.1:8000
```

### Method 2: Browser Test
Open: http://localhost:8000
Should show: `{"message":"Backend is running"}`

### Method 3: API Docs
Open: http://localhost:8000/docs
Should show FastAPI interactive documentation

---

## Manual Testing (Without Frontend)

### Test 1: Health Check
```bash
curl http://localhost:8000/
```
Expected: `{"message":"Backend is running"}`

### Test 2: Get Deadlines
```bash
curl http://localhost:8000/deadlines
```
Expected: `{"deadlines":[]}`

### Test 3: Upload CSV
```bash
curl -X POST -F "file=@sample_deadlines.csv" http://localhost:8000/upload-csv
```

---

## Complete Startup Sequence

### Terminal 1 (Backend):
```bash
cd C:\Users\Georg\Documents\GitHub\Deadline-Tracker-app\backend
pip install -r requirements.txt
python -m uvicorn app:app --reload
```
**Leave this running!**

### Terminal 2 (Frontend):
```bash
cd C:\Users\Georg\Documents\GitHub\Deadline-Tracker-app\frontend
flutter pub get
flutter run -d windows
```

---

## Still Not Working?

### Check Python Installation
```bash
python --version
```
Should be Python 3.7 or higher

### Check if Port 8000 is in Use
```bash
netstat -ano | findstr :8000
```

If port is in use, start backend on different port:
```bash
python -m uvicorn app:app --reload --port 8001
```

Then update `api_service.dart`:
```dart
static const String baseUrl = 'http://localhost:8001';
```

### Check Flutter Dependencies
```bash
cd frontend
flutter doctor
flutter pub get
```

---

## Need More Help?

1. **Check backend terminal** - Look for error messages
2. **Check frontend logs** - Look for connection errors
3. **Try browser first** - Visit http://localhost:8000 directly
4. **Check firewall** - Make sure it's not blocking port 8000

The backend MUST be running before the frontend can connect!
