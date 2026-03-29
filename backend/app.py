import os

from fastapi import FastAPI, UploadFile, Depends, HTTPException, Header
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from datetime import datetime
import csv
import io

from database import init_db, get_db, Deadline
from models.schemas import DeadlineResponse, UploadResponse, DeadlinesResponse, DeleteResponse

app = FastAPI(title="Deadline Tracker API")

ALLOWED_ORIGINS = [
    origin.strip()
    for origin in os.getenv(
        "ALLOWED_ORIGINS",
        "http://localhost:3000,http://localhost:5173,http://localhost:8000",
    ).split(",")
    if origin.strip()
]

# If set, privileged endpoints require this header:
# X-Admin-Token: <ADMIN_TOKEN>
ADMIN_TOKEN = os.getenv("ADMIN_TOKEN", "")

# Initialize database on startup
@app.on_event("startup")
def on_startup():
    init_db()

# Allow Flutter frontend to talk to backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=ALLOWED_ORIGINS,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Test endpoint
@app.get("/")
def read_root():
    return {"message": "Backend is running"}

# Get all deadlines
@app.get("/deadlines", response_model=DeadlinesResponse)
def get_deadlines(db: Session = Depends(get_db)):
    deadlines = db.query(Deadline).order_by(Deadline.date).all()
    return {"deadlines": deadlines}

# Upload CSV and parse deadlines
@app.post("/upload-csv", response_model=UploadResponse)
async def upload_csv(file: UploadFile, db: Session = Depends(get_db)):
    if not file.filename.endswith('.csv'):
        raise HTTPException(status_code=400, detail="File must be a CSV")
    
    try:
        # Read and decode CSV
        contents = await file.read()
        csv_content = contents.decode('utf-8')
        csv_reader = csv.reader(io.StringIO(csv_content))
        
        # Skip header row
        next(csv_reader, None)
        
        deadlines_added = []
        line_number = 1
        
        for row in csv_reader:
            line_number += 1
            
            # Validate row has at least 2 columns
            if len(row) < 2:
                raise HTTPException(
                    status_code=400, 
                    detail=f"Line {line_number}: Invalid format, expected at least 2 columns (title, date)"
                )
            
            title = row[0].strip()
            date_str = row[1].strip()
            
            # Validate title
            if not title:
                raise HTTPException(
                    status_code=400,
                    detail=f"Line {line_number}: Title cannot be empty"
                )
            
            # Validate and parse date
            try:
                date = datetime.fromisoformat(date_str.replace('Z', '+00:00'))
            except ValueError:
                raise HTTPException(
                    status_code=400,
                    detail=f"Line {line_number}: Invalid date format '{date_str}'. Expected ISO8601 format (e.g., 2024-12-25T23:59:59)"
                )
            
            # Create and save deadline
            deadline = Deadline(title=title, date=date)
            db.add(deadline)
            deadlines_added.append(deadline)
        
        # Commit all deadlines
        db.commit()
        
        # Refresh to get IDs
        for deadline in deadlines_added:
            db.refresh(deadline)
        
        return {
            "message": f"Successfully uploaded {len(deadlines_added)} deadline(s)",
            "count": len(deadlines_added),
            "deadlines": deadlines_added
        }
    
    except UnicodeDecodeError:
        raise HTTPException(status_code=400, detail="File encoding error. Please ensure CSV is UTF-8 encoded")
    except Exception as e:
        db.rollback()
        if isinstance(e, HTTPException):
            raise e
        raise HTTPException(status_code=500, detail=f"Error processing CSV: {str(e)}")

# Delete all deadlines
@app.delete("/deadlines", response_model=DeleteResponse)
def delete_all_deadlines(
    db: Session = Depends(get_db),
    x_admin_token: str | None = Header(default=None),
):
    if ADMIN_TOKEN and x_admin_token != ADMIN_TOKEN:
        raise HTTPException(status_code=401, detail="Unauthorized")

    count = db.query(Deadline).count()
    db.query(Deadline).delete()
    db.commit()
    return {"message": f"Deleted {count} deadline(s)", "count": count}
