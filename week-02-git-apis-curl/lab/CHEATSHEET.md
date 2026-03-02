# Week 2 Cheatsheet: Git Branching, REST APIs & curl

## Git Branching Commands

| Command | Purpose |
|---------|---------|
| `git branch` | List branches |
| `git branch <name>` | Create branch |
| `git switch <name>` | Switch to branch |
| `git switch -c <name>` | Create + switch |
| `git merge <branch>` | Merge into current branch |
| `git branch -d <name>` | Delete merged branch |
| `git push -u origin <name>` | Push branch to remote |
| `git pull origin main` | Update local main |

## HTTP Methods

| Method | Purpose | Example |
|--------|---------|---------|
| `GET` | Fetch data | `GET /moods` |
| `POST` | Create new data | `POST /mood` |
| `PUT` | Replace data | `PUT /mood/1` |
| `PATCH` | Partial update | `PATCH /mood/1` |
| `DELETE` | Remove data | `DELETE /mood/1` |

## curl Recipes

```bash
# GET request
curl http://localhost:8000/moods

# POST with JSON body
curl -X POST http://localhost:8000/mood \
  -H "Content-Type: application/json" \
  -d '{"score": 7, "note": "good"}'

# Pretty-print JSON
curl -s http://localhost:8000/moods \
  | python3 -m json.tool

# Verbose output (see headers)
curl -v http://localhost:8000/health
```

## Merge Conflict Markers

```
<<<<<<< HEAD
Your branch's version
=======
Incoming branch's version
>>>>>>> other-branch
```

**Resolution steps:**

1. Read both versions
2. Choose what to keep
3. Delete all 3 marker lines
4. `git add` + `git commit`

## curl Flags Quick Reference

| Flag | Purpose | Example |
|------|---------|---------|
| `-X` | Set HTTP method | `-X POST` |
| `-H` | Add header | `-H "Content-Type: application/json"` |
| `-d` | Send request body | `-d '{"key": "value"}'` |
| `-s` | Silent (no progress bar) | `curl -s URL` |
| `-v` | Verbose (show headers) | `curl -v URL` |
| `-i` | Include response headers | `curl -i URL` |

## HTTP Status Codes

| Code | Meaning | When you see it |
|------|---------|----------------|
| `200` | OK | Successful GET/PUT/PATCH |
| `201` | Created | Successful POST |
| `204` | No Content | Successful DELETE |
| `400` | Bad Request | Malformed request |
| `404` | Not Found | Wrong endpoint URL |
| `422` | Unprocessable Entity | Invalid data (FastAPI) |
| `500` | Internal Server Error | Server crashed |

## Pull Request Workflow

```
1. Create branch    →  git switch -c feature-x
2. Make changes     →  edit files, git add, git commit
3. Push branch      →  git push -u origin feature-x
4. Open PR          →  github.com → Compare & Pull Request
5. Review           →  Files changed tab → comments → approve
6. Merge            →  Merge pull request → Confirm
7. Update local     →  git switch main && git pull
```
