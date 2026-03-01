# Week 2 Lab: Instructor Guide

**Course:** Mobile Apps for Healthcare
**Lab Duration:** 2 hours
**Topic:** Git Branching, REST APIs & curl
**Audience:** 3rd-year Biomedical Engineering students --- comfortable with basic terminal and git from Week 1

> This document is for the **instructor only**. Students use the separate `README.md` workbook.

---

## Pre-Lab Checklist

Complete these **before students arrive**:

- [ ] Git installed on all lab machines (`git --version` in terminal)
- [ ] Python 3 installed (`python3 --version` or `python --version`)
- [ ] Prepare a merge conflict demo repository (two branches modifying the same file -- `patient_info.txt` with conflicting blood pressure values; see Appendix at the end of this guide)
- [ ] Test that `pip install fastapi uvicorn` works on the lab network (try it inside a venv)
- [ ] Have the starter template `fastapi-starter/main.py` ready and accessible to students
- [ ] GitHub Classroom assignment created and accept link ready to share (see "GitHub Classroom Setup" section below)
- [ ] Open the student workbook (`README.md`) on the projector
- [ ] Increase terminal font size to at least 18pt
- [ ] Have a browser tab ready for the GitHub PR demo
- [ ] Prepare a second terminal window for curl testing (students will need two terminals open simultaneously)
- [ ] Have USB drives with the Python installer ready if lab machines do not have it

### Room Setup

- Projector showing your terminal (large font, dark background recommended)
- Browser window with your GitHub repository ready for the PR demo
- Two terminal windows side by side: one for the server, one for curl commands
- If lab has both macOS and Windows machines, know which students are on which OS (activation commands and curl quoting differ)

### If Python Is Not Installed

Some lab machines may only have Python 2 or no Python at all. Fallback plan:

1. Try `python3 --version` first, then `python --version`
2. If neither works, install from [python.org](https://www.python.org/downloads/) --- takes ~5 min
3. On Windows, make sure to check **"Add Python to PATH"** during installation
4. After install, students must **close and reopen** their terminal
5. If download is slow on lab WiFi, use the USB drives with the installer

---

## Timing Overview

| Time | Duration | Activity | Type |
|------|----------|----------|------|
| 0:00--0:05 | 5 min | Welcome & context | Instructor talk |
| 0:05--0:25 | 20 min | Part 1a: Branching demo + follow-along | Follow-along |
| 0:25--0:40 | 15 min | Part 1b: Merge conflict exercise | Student work |
| 0:40--0:45 | 5 min | Break / catch-up buffer | --- |
| 0:45--1:05 | 20 min | Part 2: Pull Requests on GitHub | Follow-along |
| 1:05--1:45 | 40 min | Part 3: FastAPI step-by-step | Follow-along + student work |
| 1:45--1:50 | 5 min | Break / catch-up buffer | --- |
| 1:50--2:00 | 10 min | Part 4: curl testing + assignment intro | Follow-along + wrap-up |

**Total:** 120 minutes (2 hours)

> **Pacing note:** The two 5-minute buffers are critical. Use them to help stragglers catch up. If everyone is on track, use the time for Q&A or to reinforce concepts. Never skip the buffers --- someone always needs them.

---

## Detailed Facilitation Guide

### 0:00--0:05 --- Welcome & Context Setting (5 min)

**Type:** Instructor talk

**What to say (talking points, not a script):**

- Welcome back. Last week you learned the terminal and basic Git. This week we build on that.
- "Today you will learn three things that professional healthcare developers use constantly: branching, APIs, and testing."
- Branching lets teams work in parallel without stepping on each other's code -- essential when multiple people are building a patient-facing app.
- REST APIs are how mobile apps talk to servers. Your phone's health tracking app sends mood data, step counts, or blood pressure readings to a server through an API.
- curl lets you test those APIs without writing a single line of frontend code.
- AI tools are still NOT allowed in Weeks 1--3.
- Reminder: everything you need is in the workbook (`README.md`). Follow it step by step.

**What students should be doing:**

- Opening their terminals
- Navigating to their `mhealth-course` directory (or equivalent from Week 1)
- Having the workbook open on screen or on the projector

**Checkpoint:** Before moving on, verify that **every student has a terminal open** and can run `git --version` and `python3 --version` (or `python --version`). Identify Python issues immediately.

**Common pitfall:** Students who missed Week 1 or did not complete the assignment may not have Git configured. Quickly run `git config --global user.name` and `git config --global user.email` to verify. Help them configure if needed.

---

### 0:05--0:25 --- Part 1a: Branching Demo + Follow-Along (20 min)

**Type:** Follow-along

**Pacing:** This covers workbook sections 1.1 through 1.4. Budget roughly 5 minutes per section.

#### 0:05--0:10 --- Why Branches? + Creating a Branch (5 min)

**Demo on projector:**

1. Navigate to an existing Git repository (use one from Week 1 or create a fresh one)
2. `git branch` --- show the current branch
3. `git branch feature-greeting` --- create a new branch
4. `git branch` --- show the new branch in the list, current branch is still `main`

**Talking points:**

- "Think of branches as parallel timelines for your project. The main timeline keeps running, and your branch is a separate timeline where you experiment."
- "In a hospital software team, one developer might be adding a new patient form on one branch while another is fixing a bug on a different branch. Neither interferes with the other."
- Draw a quick diagram on the whiteboard showing `main` continuing forward while `feature` diverges

**What to watch for:**

- Students who do not have a Git repo ready. Tell them to `mkdir branch-demo && cd branch-demo && git init` and make one commit so they have something to branch from.

#### 0:10--0:15 --- Switching Branches + Making Changes (5 min)

**Demo:**

1. `git switch feature-greeting` (or `git checkout feature-greeting`)
2. `echo "Hello from feature branch!" > greeting.txt`
3. `git add greeting.txt`
4. `git commit -m "Add greeting.txt on feature branch"`
5. `ls` --- show the file exists
6. `git switch main`
7. `ls greeting.txt` --- file not found! It only lives on the feature branch

**Key teaching moment:** The disappearing file. This is the moment students truly understand what branches do. Pause here and let it sink in.

**Talking point:** "The file is not deleted. It is safely stored in Git on the feature branch. Switch back and it reappears. Branches are like parallel worlds."

**What to watch for:**

- Students confused by `switch` vs `checkout` -- explain both work, `switch` is newer and clearer
- Students who get "error: pathspec" messages -- they likely have a typo in the branch name

#### 0:15--0:20 --- Merging a Branch (5 min)

**Demo:**

1. `git switch main` (make sure you are on `main`)
2. `git merge feature-greeting`
3. `ls greeting.txt` --- now it exists on `main`
4. `git log --oneline --graph` --- show the merge in history
5. `git branch -d feature-greeting` --- clean up

**Talking point:** "Merging is how you bring your experiment back into the main timeline. In a team, you do not merge directly -- you open a Pull Request so others can review. We will do that in Part 2."

**Have students follow along** through the entire sequence. Walk around to verify.

**Checkpoint:** Ask: "Who can show me the output of `git log --oneline` with at least two commits -- one from `main` and one merged from the feature branch?" Pick a student to share.

#### 0:20--0:25 --- Shortcut and Recap (5 min)

**Demo the shortcut:**

```bash
git switch -c feature-quick
# OR
git checkout -b feature-quick
```

**Quick verbal recap:**

- `git branch <name>` creates
- `git switch <name>` switches
- `git switch -c <name>` creates and switches
- `git merge <name>` merges into current branch
- `git branch -d <name>` deletes

**What to watch for:**

- Students who are behind. If more than 2--3 are stuck, slow down and walk through one more branch-create-merge cycle as a group.

---

### 0:25--0:40 --- Part 1b: Merge Conflict Exercise (15 min)

**Type:** Student work (guided)

**This is where students typically panic.** Normalize it immediately.

**Say:** "We are going to create a merge conflict on purpose. Conflicts happen all the time in real projects -- they are normal, not errors. The goal is to learn to resolve them calmly."

#### 0:25--0:28 --- Setup (3 min)

**Option A (preferred):** Students clone the pre-prepared conflict repository you set up before lab:

```bash
git clone <YOUR-CONFLICT-REPO-URL> conflict-exercise
cd conflict-exercise
```

**Option B (fallback):** If the repo is not ready or the network is slow, have students create the conflict locally:

```bash
mkdir conflict-exercise && cd conflict-exercise && git init
echo "Patient: Maria Kowalska" > patient_info.txt
echo "Age: 45" >> patient_info.txt
echo "Blood pressure: 118/76 mmHg" >> patient_info.txt
git add patient_info.txt
git commit -m "Add initial patient info"

git switch -c branch-a
# Edit line 3 to a different blood pressure
# (use a text editor or the following command)
```

If using Option B, walk them through creating both branches with conflicting edits. This takes more time but builds understanding.

#### 0:28--0:32 --- Explore the Branches (4 min)

**Have students:**

1. `git switch branch-a` and `cat patient_info.txt` -- note the blood pressure value
2. `git switch branch-b` and `cat patient_info.txt` -- note the different value
3. Discuss: "Two doctors updated the same patient's blood pressure reading from different appointments. Git does not know which one is correct -- only you can decide."

#### 0:32--0:38 --- Trigger and Resolve the Conflict (6 min)

**Walk through on projector while students follow along:**

1. Make sure you are on `branch-b`
2. `git merge branch-a` -- conflict!
3. `cat patient_info.txt` -- show the conflict markers

**Go very slowly through the markers:**

```
<<<<<<< HEAD
Blood pressure: 130/85 mmHg
=======
Blood pressure: 120/80 mmHg
>>>>>>> branch-a
```

**Explain each line:**

- `<<<<<<< HEAD` -- "This is what YOUR branch (branch-b) has"
- `=======` -- "This is the dividing line"
- `>>>>>>> branch-a` -- "This is what the incoming branch (branch-a) has"

**Resolve it:** Open in a text editor (or use `echo` to overwrite). Remove ALL three marker lines. Keep the value you decide is correct -- for example, a compromise:

```
Blood pressure: 125/82 mmHg
```

**Complete the merge:**

```bash
git add patient_info.txt
git commit -m "Resolve merge conflict in patient_info.txt"
```

**Verify:** `git log --oneline --graph` shows the merge commit.

#### 0:38--0:40 --- Checkpoint (2 min)

**Ask:** "Who successfully resolved the conflict? Show me your `git log --oneline --graph`."

**Common pitfalls:**

- Students who leave the conflict markers in the file -- remind them to remove ALL three marker lines
- Students who try to edit the file while Git is in a "merging" state and get confused -- reassure them that editing the file IS the resolution
- Students who accidentally commit the markers -- they can `git log`, see the bad commit, and know to watch for this in the future

**Recovery if behind:** If many students are stuck, do the entire resolution on the projector as a group and have them type along. Do not move on until at least 70% have a merge commit.

---

### 0:40--0:45 --- Break / Catch-Up Buffer (5 min)

- Students who finished: take a real break
- Students who are behind: use this time to catch up on the merge conflict exercise
- Walk around and verify everyone has at least completed the branching demo
- Quick reinforcement question: "What are the three conflict marker lines? What do they mean?"
- Remind students they will need **two terminal windows** for the second half of the lab

---

### 0:45--1:05 --- Part 2: Pull Requests on GitHub (20 min)

**Type:** Follow-along

**This section alternates between terminal and browser.** Have both visible on the projector.

#### 0:45--0:52 --- Push a Branch to GitHub (7 min)

**Demo on projector:**

1. Start from a local repository that has a remote set up (students should have this from Week 1)
2. Create a new branch and make a change:

```bash
git switch -c feature-health-tip
echo "Drink at least 2 liters of water daily." > health_tip.txt
git add health_tip.txt
git commit -m "Add daily health tip"
```

3. Push the branch:

```bash
git push -u origin feature-health-tip
```

**Key emphasis on `git push -u origin feature-health-tip`:**

- `origin` is the remote (GitHub)
- `feature-health-tip` is the branch name
- `-u` sets up tracking so future pushes are simpler (`git push` without arguments)
- "This is a command students get wrong often. Type it carefully."

**What to watch for:**

- Students who do not have a remote set up. Help them add one: `git remote add origin git@github.com:USERNAME/REPO.git`
- Authentication failures -- refer back to Week 1 SSH setup or HTTPS backup
- Students who push to `main` instead of the feature branch -- they need to switch to the feature branch first

**Talking point:** "You never push directly to `main` on a team project. You push your feature branch and then ask the team to review it through a Pull Request."

#### 0:52--1:00 --- Create and Review a PR (8 min)

**Switch to the browser. Demo on projector:**

1. Open the repository on github.com
2. Show the yellow banner: "feature-health-tip had recent pushes" with the green button
3. Click "Compare & pull request"
4. Fill in:
   - **Base:** `main`
   - **Compare:** `feature-health-tip`
   - **Title:** "Add daily health tip file"
   - **Description:** "Adds a health_tip.txt file with a hydration reminder for patients."
5. Click "Create pull request"

**Then show the review workflow:**

1. Click "Files changed" tab -- show the diff
2. Click the "+" next to a line -- leave a comment (e.g., "Should we include a source for this recommendation?")
3. Click "Review changes" > "Approve" > "Submit review"

**Exercise:** "Pair up with the person sitting next to you. Each of you push a branch, create a PR, then review each other's PR. Leave at least one comment and approve it."

**What to watch for:**

- Students who cannot find the "Compare & pull request" button -- show them the manual path through the Branch dropdown
- Students who create a PR from `main` to `main` -- make sure the compare branch is correct
- Students working alone because their neighbor is absent -- they can review their own PR or you can pair them with someone else

#### 1:00--1:05 --- Merge the PR + Sync Local (5 min)

**Demo on projector:**

1. Click "Merge pull request" > "Confirm merge"
2. Click "Delete branch" (optional but good practice)
3. Back in terminal:

```bash
git switch main
git pull origin main
```

4. Show that the merged changes are now on local `main`

**Checkpoint:** "Who has successfully created, reviewed, and merged a PR? Raise your hand."

**Recovery if behind:** If the pairing exercise is taking too long, have everyone watch the demo and skip the peer review. Students can practice PRs in the assignment.

---

### 1:05--1:45 --- Part 3: FastAPI Step-by-Step (40 min)

**Type:** Follow-along + student work

**This is the biggest section. Pace yourself carefully.**

#### 1:05--1:12 --- Virtual Environment Setup (7 min)

**Demo on projector:**

```bash
mkdir mood-api && cd mood-api
python -m venv venv
```

> **Note:** Some machines may need `python3 -m venv venv` instead.

**Activate the venv:**

```bash
# macOS / Linux
source venv/bin/activate

# Windows (Command Prompt)
venv\Scripts\activate

# Windows (PowerShell)
venv\Scripts\Activate.ps1
```

**Show the `(venv)` prefix** appearing in the prompt. Explain: "This tells you that you are inside the virtual environment. Any packages you install now stay here, not on the whole system."

**Install dependencies:**

```bash
pip install fastapi uvicorn
```

**Talking points:**

- "In healthcare software, you might have one project using version 2.0 of a library and another using version 3.0. Virtual environments keep them separate."
- "Think of it like separate medicine cabinets for different patients -- you don't want to mix them up."

**What to watch for:**

- `python: command not found` -- try `python3`
- `No module named venv` -- the student may need to install `python3-venv` on Linux: `sudo apt install python3-venv`
- **Windows PowerShell execution policy errors** -- run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` or use Command Prompt instead
- Students who forget to activate the venv before `pip install` -- the packages will install globally

**Checkpoint:** "Does everyone see `(venv)` in their prompt? Run `pip list` and confirm you see `fastapi` and `uvicorn`."

#### 1:12--1:30 --- Building the API Step by Step (18 min)

**Students can either start from the provided `fastapi-starter/main.py` template or build from scratch.** Recommend the template for students who are not confident with Python.

**Go through each step on the projector. Have students type along.**

**Step 1 (1:12--1:14): Imports and app setup**

```python
from fastapi import FastAPI

app = FastAPI(title="Mood API", description="A simple mood tracking API")
```

**Step 2 (1:14--1:16): In-memory storage**

```python
mood_entries = []
```

**Talking point:** "In a real healthcare app, you would use a database. For today, a Python list is fine. We will cover databases later in the course."

**Step 3 (1:16--1:20): Pydantic model**

```python
from pydantic import BaseModel

class MoodEntry(BaseModel):
    score: int
    note: str
```

**Key teaching moment:** "Pydantic validates your data automatically. In a healthcare context, this matters -- you do not want someone accidentally submitting a blood pressure reading as a string instead of a number. Bad data in healthcare can be dangerous."

**What to watch for:**

- Students who do not add the import at the top of the file
- Indentation errors (Python is strict about this)

**Step 4 (1:20--1:23): Health endpoint**

```python
@app.get("/health")
def health_check():
    return {"status": "healthy"}
```

**Say:** "Let's test this one endpoint before building the rest. Run the server."

```bash
uvicorn main:app --reload
```

**Show the output.** Open `http://localhost:8000/docs` in the browser to show Swagger UI.

**Talking point:** "In production healthcare systems, the `/health` endpoint is how monitoring tools know if the service is alive. If it stops responding, the operations team gets an alert."

**What to watch for:**

- `ModuleNotFoundError: No module named 'fastapi'` -- the venv is not activated
- `Error loading ASGI app. Could not import module "main"` -- the file is not named `main.py` or they are in the wrong directory
- Port 8000 already in use -- `uvicorn main:app --reload --port 8001`

**Step 5 (1:23--1:26): POST /mood endpoint**

```python
@app.post("/mood")
def create_mood(entry: MoodEntry):
    mood_entries.append(entry)
    return entry
```

**The server should auto-reload** (because of `--reload`). Show the new endpoint in Swagger UI.

**Step 6 (1:26--1:28): GET /moods endpoint**

```python
@app.get("/moods")
def get_moods():
    return mood_entries
```

**Checkpoint:** "Refresh your Swagger UI at `/docs`. Do you see three endpoints: `/health`, `/mood`, and `/moods`?"

#### 1:28--1:35 --- Test in Swagger UI (7 min)

**Demo on projector using Swagger UI:**

1. Click on `GET /health` > "Try it out" > "Execute" -- show the response
2. Click on `POST /mood` > "Try it out" > enter `{"score": 7, "note": "good day"}` > "Execute" -- show the 200 response
3. Add a couple more mood entries
4. Click on `GET /moods` > "Try it out" > "Execute" -- show all entries

**Let students play with Swagger UI for a few minutes.** This builds confidence before they move to curl.

**What to watch for:**

- Students who closed the server terminal -- remind them the server must keep running
- Students who see "Internal Server Error" -- check their `main.py` for syntax errors, the terminal running uvicorn will show the traceback

#### 1:35--1:45 --- Student Work: Complete the API (10 min)

**Say:** "If you have been following along, your API should be working. If you are behind, use this time to finish building it. If you are ahead, try adding type hints to your functions like the solution file shows."

**Walk around the room actively.** Prioritize students who:

1. Cannot get the server to start
2. Have import errors
3. Have syntax errors in their `main.py`

**For fast students:**

- Suggest adding type hints: `def health_check() -> dict:`, `def create_mood(entry: MoodEntry) -> MoodEntry:`, `def get_moods() -> list[MoodEntry]:`
- Ask them to try sending invalid data through Swagger UI and observe the 422 response
- Point them toward the assignment section -- they can start thinking about which endpoint to build

---

### 1:45--1:50 --- Break / Catch-Up Buffer (5 min)

- Students who finished: take a real break, stretch
- Students who are behind: use this time to get their server running
- Walk around and verify: "Is your server running? Can you see three endpoints in Swagger UI?"
- **Critical check:** Everyone should have TWO terminal windows ready for Part 4 -- one running the server, one free for curl commands
- Quick hint: "If you need to open a new terminal, do NOT close the one running the server"

---

### 1:50--2:00 --- Part 4: curl Testing + Assignment Intro (10 min)

**Type:** Follow-along + wrap-up

#### 1:50--1:56 --- curl Commands (6 min)

**Make sure your server is running in one terminal. Demo curl in a second terminal.**

**Test 1: Health endpoint**

```bash
curl http://localhost:8000/health
```

Expected:

```json
{"status":"healthy"}
```

**Test 2: POST a mood entry**

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 7, "note": "good day"}'
```

Expected:

```json
{"score":7,"note":"good day"}
```

**Go slowly over the curl flags.** Break down each part:

- `-X POST` -- the HTTP method
- `-H "Content-Type: application/json"` -- tells the server "I am sending JSON"
- `-d '...'` -- the data (request body)

**Test 3: GET all moods**

```bash
curl http://localhost:8000/moods
```

**Test 4: Invalid data**

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 5}'
```

Show the 422 response. Explain: "FastAPI rejected this because `note` is missing. In a healthcare app, you absolutely want this kind of validation."

**What to watch for:**

- **Windows CMD users:** Single quotes do not work. They must use double quotes with escaped inner quotes:

```cmd
curl -X POST http://localhost:8000/mood -H "Content-Type: application/json" -d "{\"score\": 7, \"note\": \"good day\"}"
```

- Students who closed their server terminal -- remind them to restart with `uvicorn main:app --reload`
- Students who see "Connection refused" -- server is not running or they are using the wrong port
- JSON syntax errors in the `-d` flag -- missing quotes, extra commas, etc.

#### 1:56--2:00 --- Assignment Introduction + Wrap-Up (4 min)

**Talking points:**

- Walk through the individual assignment in the workbook
- Share the GitHub Classroom assignment accept link (see the "GitHub Classroom Setup" section below)
- Emphasize the workflow: Accept assignment > Clone > Branch > Code > Test with curl > Commit > Push > Open PR to your own `main`
- "Your PR description must include an example curl command and the expected response. This is standard practice -- when you document an API, you show how to use it."
- Deadline: before Week 3 lab
- "Choose one of the suggested endpoints, or propose your own. Clear it with me first if you go custom."
- Show the grading rubric briefly (10 points total)
- "This is individual work. No AI tools. The point is to practice."

**Final words:**

- "Today you learned branching, Pull Requests, building an API, and testing it -- that is a complete development workflow."
- "It might feel like a lot. Re-read the workbook if you need to. Everything is there."
- "The lecture will explain the theory behind REST, HTTP methods, and JSON. See you there."

---

## Instructor Notes: Pacing & Common Issues

### Where Students Typically Get Stuck

1. **Merge conflicts are intimidating.** Students panic when they see the conflict markers. Normalize this immediately: "This is not an error. This is Git asking you to make a decision." Walk through every marker line slowly.

2. **Python not installed or wrong version on lab machines.** Identify this in the first 5 minutes. Have the USB drives ready. If installation takes too long, pair the student with a neighbor so they can follow along visually.

3. **Virtual environment activation syntax differs between OS.** macOS/Linux uses `source venv/bin/activate`. Windows CMD uses `venv\Scripts\activate`. PowerShell uses `venv\Scripts\Activate.ps1`. Have all three written on the board or on a slide.

4. **curl syntax on Windows.** Single quotes do not work in CMD or PowerShell. Students must use double quotes with escaped inner quotes, or switch to Git Bash (which supports single quotes). This is the single most common curl issue.

5. **Students forget to keep the server running while testing with curl.** They need two terminals open simultaneously. Remind them before Part 4. If a student has only one terminal, they can use Swagger UI in the browser as a fallback.

### Where to Slow Down

- **Merge conflict resolution.** Walk through every marker line. Show the before (conflicted file), the decision (which value to keep), and the after (clean file). This is the single most valuable skill from Part 1.
- **The first `git push -u origin branch-name` command.** Students will mistype the branch name or forget `-u`. Write the full command on the board.
- **JSON body syntax in curl.** Students will make quote mistakes, forget the `Content-Type` header, or use the wrong HTTP method. Demo each flag separately before combining them.

### Where You Can Speed Up

- **Branch creation/switching** (students did similar navigation in Week 1 with `cd`; the concepts transfer)
- **GitHub account setup** (already done in Week 1; skip entirely unless a student is new)
- **curl flags table** (Section 4.6 in the workbook is reference material, not essential to memorize; mention it exists and move on)

### If Running Out of Time

Priority order (must complete):

1. **Branching + merge conflict** -- essential for teamwork; this is the foundation of collaborative development
2. **FastAPI up and running** -- needed for the assignment; students must have a working API before they leave
3. **At least one curl test** -- validates the API works from the command line; even just `curl http://localhost:8000/health` is enough
4. **PR workflow** -- can be demonstrated briefly in 3 minutes or assigned as homework; students can follow the workbook on their own

Can be shortened:

- Swagger UI exploration (1:28--1:35) -- skip the interactive testing and go straight to curl
- Peer PR review exercise -- do as a demo-only instead of having students pair up
- curl pretty-printing (`python -m json.tool`) -- nice to have but not essential

### If You Have Extra Time

- Show `git log --oneline --graph --all` after the merge and discuss how to read the graph
- Demo `git stash` as a way to save work-in-progress before switching branches
- Have students add input validation to their API (e.g., `score` must be between 1 and 10 using Pydantic's `Field`)
- Explore the alternative docs page at `http://localhost:8000/redoc`
- Start the assignment together -- help students fork the repo and create their feature branch

---

## Complete Solutions

### FastAPI Solution (`solution.py`)

This is the complete working API that students should arrive at by the end of Part 3:

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="Mood API",
    description="A simple mood tracking API for the Week 2 lab exercise.",
)

class MoodEntry(BaseModel):
    score: int
    note: str

mood_entries: list[MoodEntry] = []

@app.get("/health")
def health_check() -> dict:
    return {"status": "healthy"}

@app.post("/mood")
def create_mood(entry: MoodEntry) -> MoodEntry:
    mood_entries.append(entry)
    return entry

@app.get("/moods")
def get_moods() -> list[MoodEntry]:
    return mood_entries
```

### curl Commands and Expected Outputs

**Health check:**

```bash
curl http://localhost:8000/health
```

```json
{"status":"healthy"}
```

**Create a mood entry:**

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 7, "note": "good day"}'
```

```json
{"score":7,"note":"good day"}
```

**Create additional entries:**

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 4, "note": "stressful morning"}'
```

```json
{"score":4,"note":"stressful morning"}
```

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 9, "note": "great workout"}'
```

```json
{"score":9,"note":"great workout"}
```

**Retrieve all moods:**

```bash
curl http://localhost:8000/moods
```

```json
[{"score":7,"note":"good day"},{"score":4,"note":"stressful morning"},{"score":9,"note":"great workout"}]
```

**Pretty-printed:**

```bash
curl -s http://localhost:8000/moods | python -m json.tool
```

```json
[
    {
        "score": 7,
        "note": "good day"
    },
    {
        "score": 4,
        "note": "stressful morning"
    },
    {
        "score": 9,
        "note": "great workout"
    }
]
```

**Invalid data (missing field):**

```bash
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 5}'
```

```json
{
    "detail": [
        {
            "type": "missing",
            "loc": ["body", "note"],
            "msg": "Field required",
            "input": {"score": 5},
            "url": "https://errors.pydantic.dev/2.5/v/missing"
        }
    ]
}
```

> **Note:** The exact error format may vary slightly depending on the FastAPI/Pydantic version installed.

**Windows CMD alternative (double-quote syntax):**

```cmd
curl -X POST http://localhost:8000/mood -H "Content-Type: application/json" -d "{\"score\": 7, \"note\": \"good day\"}"
```

### Merge Conflict Resolution Example

**`patient_info.txt` before the conflict (on `main`):**

```
Patient: Maria Kowalska
Age: 45
Blood pressure: 118/76 mmHg
```

**`patient_info.txt` on `branch-a`:**

```
Patient: Maria Kowalska
Age: 45
Blood pressure: 120/80 mmHg
```

**`patient_info.txt` on `branch-b`:**

```
Patient: Maria Kowalska
Age: 45
Blood pressure: 130/85 mmHg
```

**After `git merge branch-a` while on `branch-b`, the conflicted file looks like:**

```
Patient: Maria Kowalska
Age: 45
<<<<<<< HEAD
Blood pressure: 130/85 mmHg
=======
Blood pressure: 120/80 mmHg
>>>>>>> branch-a
```

**After resolution (student decides on a compromise value):**

```
Patient: Maria Kowalska
Age: 45
Blood pressure: 125/82 mmHg
```

**Then:**

```bash
git add patient_info.txt
git commit -m "Resolve merge conflict in patient_info.txt"
```

---

## End-of-Lab Assessment

### Minimum Completion Checklist

Every student should leave the lab with:

- [ ] Created and merged at least one branch
- [ ] Successfully resolved a merge conflict
- [ ] Opened or reviewed at least one Pull Request on GitHub
- [ ] FastAPI server running with all three endpoints working (`/health`, `/mood`, `/moods`)
- [ ] Tested at least one endpoint with curl
- [ ] Understands the assignment (accept GitHub Classroom link, branch, new endpoint, PR)

### Quick Verification Method

In the last 2 minutes, ask students to run:

```bash
git log --oneline --graph
```

to confirm they have merge history, and:

```bash
curl http://localhost:8000/health
```

to confirm their API is responding.

### For Students Who Did Not Finish

- Reassure them: "You have the workbook. Follow it step by step at home."
- Parts 3 and 4 (FastAPI + curl) can be completed independently -- everything is in the workbook
- The merge conflict exercise requires the prepared repo -- provide the URL or have them create the conflict locally using the Appendix instructions below
- Remind them the assignment deadline is before Week 3 lab
- Offer office hours or a communication channel for questions

---

## GitHub Classroom Setup

Follow these steps **before the lab session** to prepare the individual assignment.

### Step 1: Create the Template Repository on GitHub

1. Create a new repository on GitHub (e.g., `mood-tracker-api-template`).
2. Push the contents of `week-02-git-apis-curl/assignment-template/` to it:

```bash
cd week-02-git-apis-curl/assignment-template
git init
git add .
git commit -m "Initial mood tracker API template"
git remote add origin git@github.com:YOUR-ORG/mood-tracker-api-template.git
git push -u origin main
```

3. Go to the repository **Settings** on GitHub.
4. Under **General**, check **Template repository**.

### Step 2: Create the Assignment in GitHub Classroom

1. Go to [classroom.github.com](https://classroom.github.com) and select your classroom.
2. Click **New assignment**.
3. Configure the assignment:
   - **Title:** `week-02-mood-tracker-endpoint`
   - **Type:** Individual
   - **Visibility:** Private (recommended)
   - **Template repository:** Select `mood-tracker-api-template`
   - **Deadline:** Before the start of Week 3 lab
4. Click **Create assignment**.
5. Copy the **assignment accept link** — this is what you share with students.

### Step 3: Share with Students

- Post the accept link on the course page or share it during the lab session.
- When a student clicks the link, GitHub Classroom automatically creates a private copy of the template repository under their account.
- Students clone their repo, create a feature branch, add an endpoint, and open a PR from the feature branch to their own `main`.

### Reviewing Student Work

- Use the GitHub Classroom **dashboard** to see all student repositories at a glance.
- Click into individual repos to review PRs, code, and commit history.
- You can leave review comments directly on student PRs.

---

## Appendix: How to Prepare the Merge Conflict Exercise Repository

Run these commands **before the lab session** to create a repository with two conflicting branches. Host it on GitHub (or a local Git server) so students can clone it.

### Step 1: Create the repository

```bash
mkdir conflict-exercise && cd conflict-exercise
git init
```

### Step 2: Create the base file on `main`

```bash
cat > patient_info.txt << 'EOF'
Patient: Maria Kowalska
Age: 45
Blood pressure: 118/76 mmHg
EOF

git add patient_info.txt
git commit -m "Add initial patient info"
```

### Step 3: Create `branch-a` with one blood pressure value

```bash
git switch -c branch-a

cat > patient_info.txt << 'EOF'
Patient: Maria Kowalska
Age: 45
Blood pressure: 120/80 mmHg
EOF

git add patient_info.txt
git commit -m "Update blood pressure reading (morning appointment)"
```

### Step 4: Create `branch-b` from `main` with a different blood pressure value

```bash
git switch main
git switch -c branch-b

cat > patient_info.txt << 'EOF'
Patient: Maria Kowalska
Age: 45
Blood pressure: 130/85 mmHg
EOF

git add patient_info.txt
git commit -m "Update blood pressure reading (afternoon appointment)"
```

### Step 5: Push to GitHub

```bash
git switch main
git remote add origin git@github.com:YOUR-USERNAME/conflict-exercise.git
git push -u origin main
git push origin branch-a
git push origin branch-b
```

### Step 6: Verify

Clone the repo in a fresh directory and confirm that:

1. `main` has the original blood pressure (118/76)
2. `branch-a` has 120/80
3. `branch-b` has 130/85
4. Merging `branch-a` into `branch-b` produces a conflict on line 3

**Narrative for students:** "Two doctors saw the same patient on the same day. Dr. A recorded blood pressure as 120/80 in the morning. Dr. B recorded 130/85 in the afternoon. Both updated the patient record. Git cannot decide which reading to keep -- you must review both and make a clinical judgment."

> **Tip:** If you want to make the exercise slightly harder, add a second conflict -- for example, have `branch-a` also change the age to 46 (birthday between appointments) while `branch-b` keeps it at 45. This gives students two conflicts to resolve in one merge.
