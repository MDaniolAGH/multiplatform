# Mood Tracking API

A minimal REST API for recording and retrieving mood entries, built with [FastAPI](https://fastapi.tiangolo.com/).

This project is the starting point for the **Week 2 Individual Assignment** in the *Mobile Apps for Healthcare* course.

## Setup

```bash
# 1. Clone this repository (after accepting the GitHub Classroom assignment)
git clone <your-repo-url>
cd <your-repo-name>

# 2. Create and activate a virtual environment
python -m venv venv
source venv/bin/activate        # macOS / Linux
# venv\Scripts\activate          # Windows CMD
# venv\Scripts\Activate.ps1      # Windows PowerShell

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run the server
uvicorn main:app --reload
```

The API will be available at `http://localhost:8000`. Interactive docs are at `http://localhost:8000/docs`.

## Existing Endpoints

| Method | Path      | Description              |
|--------|-----------|--------------------------|
| GET    | `/health` | Health check             |
| POST   | `/mood`   | Create a new mood entry  |
| GET    | `/moods`  | List all mood entries    |

## Your Task

Add a **new endpoint** to `main.py`. See the lab workbook for full assignment details, endpoint options, and grading criteria.

## Quick Test with curl

```bash
# Health check
curl http://localhost:8000/health

# Create a mood entry
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 7, "note": "good day"}'

# List all mood entries
curl http://localhost:8000/moods
```
