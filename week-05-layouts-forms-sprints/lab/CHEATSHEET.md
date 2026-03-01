# Week 5 Cheatsheet: Sprint Planning

<div class="grid cards" markdown>

- :material-account-voice: **User Story Template**

    ---

    ```
    As a [type of user],
    I want to [do something],
    so that [I get some benefit].
    ```

    **Example:**
    > As a **patient**, I want to **log my mood with a score**
    > so that I can **track how I feel over time**.

    **Acceptance criteria:**

    - [ ] User can select a score from 1-10
    - [ ] User can optionally add a note
    - [ ] Entry appears in history list

- :material-speedometer: **Story Point Scale**

    ---

    | Points | Effort | Example |
    |--------|--------|---------|
    | 1 | Trivial | Change button color |
    | 2 | Small | Add a text field |
    | 3 | Medium | Build a new screen |
    | 5 | Large | Implement API integration |
    | 8 | Very large | Build offline sync |
    | 13 | Epic | Full auth system |

    **Rule:** If it's > 8 points, break it into smaller stories.

- :material-calendar-clock: **Sprint Ceremonies**

    ---

    | Ceremony | When | Duration | Purpose |
    |----------|------|----------|---------|
    | Sprint Planning | Start of sprint | 1-2 hours | Choose what to build |
    | Daily Standup | Every day | 15 min | Sync blockers |
    | Sprint Review | End of sprint | 30 min | Demo what was built |
    | Retrospective | End of sprint | 30 min | Improve process |

- :material-view-column: **GitHub Projects Board**

    ---

    | Column | Contains |
    |--------|----------|
    | **Backlog** | All stories not yet planned |
    | **Sprint Backlog** | Stories chosen for this sprint |
    | **In Progress** | Currently being worked on |
    | **In Review** | PR open, awaiting review |
    | **Done** | Merged and verified |

</div>

## Writing Good User Stories

| Do | Don't |
|----|-------|
| Focus on user value | Describe implementation details |
| Keep it small (fits in one sprint) | Write epics as single stories |
| Include acceptance criteria | Leave "done" undefined |
| Use consistent format | Mix formats across the team |

## Sprint Planning Checklist

- [ ] Product backlog is prioritized
- [ ] Team capacity estimated (hours/points available)
- [ ] Sprint goal defined (one sentence)
- [ ] Stories selected from top of backlog
- [ ] Total story points ≤ team velocity
- [ ] Each story has acceptance criteria
- [ ] Stories assigned to team members
- [ ] GitHub Issues created and added to project board

## Estimation Tips

- **Don't estimate in hours** — use relative story points
- **Use Planning Poker** — each member reveals their estimate simultaneously to avoid anchoring
- **Reference story** — pick a 3-point story as your baseline, estimate others relative to it
- **When in doubt, go higher** — it's better to finish early than to miss deadlines
