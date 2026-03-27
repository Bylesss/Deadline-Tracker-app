@echo off
echo ================================================
echo   DEADLINE TRACKER - STARTUP INSTRUCTIONS
echo ================================================
echo.
echo The app needs TWO terminals running:
echo.
echo TERMINAL 1 (Backend Server):
echo   cd backendK
echo   pip install -r requirements.txt
echo   python -m uvicorn app:app --reload
echo.
echo TERMINAL 2 (Flutter App):
echo   cd frontend
echo   flutter pub get
echo   flutter run -d windows
echo.
echo ================================================
echo Press any key to start BACKEND SERVER in this window...
pause >nul

cd backend
echo.
echo Installing dependencies...
python -m pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install dependencies
    echo Make sure Python is installed and in PATH
    pause
    exit /b 1
)

echo.
echo ================================================
echo   Backend server starting on http://localhost:8000
echo   KEEP THIS WINDOW OPEN!
echo   Press Ctrl+C to stop
echo ================================================
echo.
python -m uvicorn app:app --reload
