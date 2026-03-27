@echo off
echo ====================================
echo   Deadline Tracker - Backend Setup
echo ====================================
echo.

echo Installing dependencies...
pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Dependencies installed successfully!
echo.
echo Starting backend server...
echo Backend will run on http://localhost:8000
echo Press Ctrl+C to stop the server
echo.

uvicorn app:app --reload
