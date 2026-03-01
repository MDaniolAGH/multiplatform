"""
Mood Tracking API
=================
Mobile Apps for Healthcare, Week 2

A minimal REST API that stores and retrieves mood entries.

Run with:
    uvicorn main:app --reload

Endpoints:
    GET  /health  — health check
    POST /mood    — create a mood entry
    GET  /moods   — list all mood entries
"""

from fastapi import FastAPI
from pydantic import BaseModel


# ---------------------------------------------------------------------------
# App instance
# ---------------------------------------------------------------------------

app = FastAPI(
    title="Mood API",
    description="A simple mood tracking API for the Week 2 lab exercise.",
)


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------

class MoodEntry(BaseModel):
    """A single mood entry submitted by the user.

    Attributes:
        score: An integer representing the mood level (e.g., 1-10).
        note:  A short free-text description of how the user feels.
    """

    score: int
    note: str


# ---------------------------------------------------------------------------
# In-memory storage
# ---------------------------------------------------------------------------

mood_entries: list[MoodEntry] = []


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

@app.get("/health")
def health_check() -> dict:
    """Check if the API is running."""
    return {"status": "healthy"}


@app.post("/mood")
def create_mood(entry: MoodEntry) -> MoodEntry:
    """Record a new mood entry."""
    mood_entries.append(entry)
    return entry


@app.get("/moods")
def get_moods() -> list[MoodEntry]:
    """Retrieve all mood entries."""
    return mood_entries
