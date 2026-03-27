# Deadline Tracker - 2-Tier Architecture

## Architecture Overview

This application now uses a **2-tier architecture**:

```
┌─────────────────────────────────┐
│   Presentation Tier             │
│   (Flutter Frontend)            │
│   - User Interface              │
│   - CSV Upload                  │
│   - Display Deadlines           │
└────────────┬────────────────────┘
             │ HTTP/REST API
             ▼
┌─────────────────────────────────┐
│   Data Tier                     │
│   (FastAPI Backend + SQLite)    │
│   - CSV Parsing                 │
│   - Data Validation             │
│   - Database Persistence        │
└─────────────────────────────────┘
```

## Setup Instructions

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Start the FastAPI server:**
   ```bash
   uvicorn app:app --reload
   ```
   
   The backend will run on `http://localhost:8000`

4. **Test the backend:**
   - Open browser: http://localhost:8000 (should show `{"message": "Backend is running"}`)
   - API docs: http://localhost:8000/docs

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Update API URL (if needed):**
   - Edit `lib/api_service.dart`
   - Update `baseUrl` if backend is not on localhost:8000

4. **Run the Flutter app:**
   ```bash
   flutter run
   ```

## API Endpoints

### `GET /`
Test endpoint to verify backend is running.

**Response:**
```json
{"message": "Backend is running"}
```

### `POST /upload-csv`
Upload a CSV file with deadlines.

**Request:** multipart/form-data with `file` field

**CSV Format:**
```csv
title,date
Math Assignment,2024-12-25T23:59:59
Project Submission,2024-12-31T23:59:59
```

**Response:**
```json
{
  "message": "Successfully uploaded 2 deadline(s)",
  "count": 2,
  "deadlines": [
    {
      "id": 1,
      "title": "Math Assignment",
      "date": "2024-12-25T23:59:59",
      "created_at": "2024-03-27T12:00:00"
    }
  ]
}
```

### `GET /deadlines`
Retrieve all deadlines from database.

**Response:**
```json
{
  "deadlines": [
    {
      "id": 1,
      "title": "Math Assignment",
      "date": "2024-12-25T23:59:59",
      "created_at": "2024-03-27T12:00:00"
    }
  ]
}
```

### `DELETE /deadlines`
Delete all deadlines from database.

**Response:**
```json
{
  "message": "Deleted 5 deadline(s)",
  "count": 5
}
```

## Database

- **Type:** SQLite
- **File:** `backend/deadlines.db` (created automatically)
- **Schema:**
  ```sql
  CREATE TABLE deadlines (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title VARCHAR(255) NOT NULL,
      date DATETIME NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  );
  ```

## CSV Format Guide

Your CSV file must follow this format:

```csv
title,date
Assignment Name,2024-12-25T23:59:59
Project Name,2024-12-31T23:59:59
```

- **Header row:** Required (title,date)
- **Title:** Any text string
- **Date:** ISO8601 format (YYYY-MM-DDTHH:MM:SS)

## Testing the Application

1. **Start the backend:**
   ```bash
   cd backend
   uvicorn app:app --reload
   ```

2. **Start the frontend:**
   ```bash
   cd frontend
   flutter run
   ```

3. **Test CSV upload:**
   - Use the provided `sample_deadlines.csv` file
   - Log in as "Staff Member"
   - Click "Upload Deadlines"
   - Select the CSV file
   - Verify deadlines are uploaded successfully

4. **View deadlines:**
   - Navigate to "Calendar" to see uploaded deadlines
   - Deadlines persist across app restarts

## Error Handling

The application includes comprehensive error handling:

- **Backend validation:** CSV format, date validation, missing fields
- **Frontend error display:** User-friendly error messages
- **Connection status:** Indicator when backend is unreachable
- **Loading states:** Visual feedback during uploads

## Dependencies

### Backend (`backend/requirements.txt`)
```
fastapi==0.109.0
uvicorn==0.27.0
sqlalchemy==2.0.25
python-multipart==0.0.6
aiofiles==23.2.1
```

### Frontend (`frontend/pubspec.yaml`)
```yaml
dependencies:
  flutter:
    sdk: flutter
  file_picker: ^6.1.0
  http: ^1.1.0
  cupertino_icons: ^1.0.2
```

## Architecture Benefits

✅ **Separation of Concerns:** UI logic separate from data logic  
✅ **Data Persistence:** SQLite database stores deadlines permanently  
✅ **Scalability:** Easy to add more features or switch databases  
✅ **Validation:** Backend validates all data before storage  
✅ **API-First:** Can add mobile apps, web dashboards, etc.  
✅ **Error Handling:** Robust error handling at all layers

## Future Enhancements

- User authentication and authorization
- Multi-user support with user-specific deadlines
- Deadline editing and deletion (individual)
- Push notifications for upcoming deadlines
- Advanced filtering and search
- Export deadlines to various formats
