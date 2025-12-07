from fastapi import FastAPI, UploadFile
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Deadline Tracker API")

# Allow Flutter frontend to talk to backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict to your frontend URL
    allow_methods=["*"],
    allow_headers=["*"],
)

# Test endpoint
@app.get("/")
def read_root():
    return {"message": "Backend is running"}

# Endpoint for uploading deadlines CSV (staff)
@app.post("/upload-csv")
async def upload_csv(file: UploadFile):
    contents = await file.read()
    # For now, just return filename
    return {"filename": file.filename, "size": len(contents)}
