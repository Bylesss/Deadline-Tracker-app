from pydantic import BaseModel
from datetime import datetime
from typing import List

# Response model for a single deadline
class DeadlineResponse(BaseModel):
    id: int
    title: str
    date: datetime
    created_at: datetime
    
    class Config:
        from_attributes = True

# Response model for CSV upload
class UploadResponse(BaseModel):
    message: str
    count: int
    deadlines: List[DeadlineResponse]

# Response model for getting all deadlines
class DeadlinesResponse(BaseModel):
    deadlines: List[DeadlineResponse]

# Response model for delete operation
class DeleteResponse(BaseModel):
    message: str
    count: int
