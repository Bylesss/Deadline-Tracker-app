# Deadline Tracker App (Flutter + FastAPI)

Deadline Tracker is a student productivity app that helps you:

- import deadlines from a CSV file,
- view them on a calendar,
- and stay focused with a built-in Pomodoro timer.

This repository contains:

- a Flutter frontend in the frontend folder,
- a FastAPI backend in the backend folder.

## Features

- Home dashboard with navigation cards
- CSV deadline import (title + date)
- Shared in-memory deadline store
- Interactive calendar with deadline markers
- Pomodoro timer with Work / Short Break / Long Break modes
- FastAPI backend endpoint for CSV upload testing

## Tech Stack

- Frontend: Flutter (Dart)
- Backend: FastAPI (Python)
- File input: file_picker package

## Backend Connection

The frontend calls the backend using `API_BASE_URL` in `lib/api_service.dart`.

Default value:

- `http://localhost:8000`

Override when running Flutter:

- `flutter run --dart-define=API_BASE_URL=http://localhost:8000`

If backend delete protection is enabled with `ADMIN_TOKEN`, pass the same token
to Flutter:

- `flutter run --dart-define=ADMIN_TOKEN=your-token --dart-define=API_BASE_URL=http://localhost:8000`

## Project Structure

deadline-tracker-app/
- backend/
	- app.py
- frontend/
	- lib/
		- main.dart
		- deadline_upload.dart
		- deadline_store.dart
		- calendar.dart
		- pomodoro.dart
		- styles.dart
	- pubspec.yaml

## Prerequisites

Install before running:

- Flutter SDK (3.10+)
- Dart SDK (comes with Flutter)
- Python 3.10+

Optional but recommended:

VS Code with Flutter extension

## Run the Frontend

From the frontend folder:

1. Install packages:

	 flutter pub get

2. Run the app:

	 flutter run

If no device is attached, you can run on web:

flutter run -d chrome

## Run the Backend

From the backend folder:

1. Create and activate a virtual environment.
2. Install dependencies:

	 pip install fastapi uvicorn python-multipart

3. Start the API:

	 uvicorn app:app --reload

The backend will be available at:

- API root: http://127.0.0.1:8000/
- Swagger docs: http://127.0.0.1:8000/docs

## API Endpoints

- GET /
	- Returns a basic status message.

- POST /upload-csv
	- Accepts a CSV file, validates rows, stores deadlines in SQLite, and returns created records.

- GET /deadlines
	- Returns all deadlines from the SQLite database.

- DELETE /deadlines
	- Deletes all deadlines from the SQLite database.
	- If backend `ADMIN_TOKEN` is set, include `X-Admin-Token`.

## CSV Format

The current parser expects:

- a header row,
- column 1 = title,
- column 2 = date in ISO format (for example, 2026-03-23).

Example:

title,date
Math Assignment,2026-03-25
Chemistry Lab,2026-03-28

## Current Limitations

- No per-user data partitioning (all users share the same deadline table).
- No authentication for read/upload endpoints.
- No authentication/authorization.
- No pagination/filtering on deadline list endpoint.

## Suggested Next Improvements

- Add persistent storage (SQLite or PostgreSQL)
- Improve CSV parsing robustness and validation
- Connect frontend upload flow to backend endpoint
- Add notifications/reminders for upcoming deadlines
- Add tests for parser, store, and key widgets

## Troubleshooting

- If flutter pub get fails, run flutter doctor and fix reported issues.
- If file picking fails on some platforms, confirm platform permissions.
- If backend cannot start, verify dependencies and Python version.

## License

No license specified yet.
