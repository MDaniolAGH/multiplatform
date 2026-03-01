# Micro-Checkpoint Template Guide

This guide explains how to add interactive micro-checkpoints to lab materials using the `mkdocs_quiz` plugin.

## Purpose

Checkpoints create a **do → verify → reward** loop that:

1. **Verifies** the student actually completed the step and understood what happened
2. **Reveals** a congratulatory message explaining why this skill matters in real industry/healthcare practice
3. **Breaks** long 90-minute lab sessions into ~15-20 minute achievement segments

## Plugin Syntax

The `mkdocs_quiz` plugin is configured in `mkdocs.yml` (line 37). CSS overrides live in `docs/assets/stylesheets/quiz-overrides.css`.

### Basic structure

```html
<quiz>
Your question text here? Use `backticks` for inline code.

- [ ] Wrong answer A
- [ ] Wrong answer B
- [x] Correct answer
- [ ] Wrong answer C

---

**Bold opening line!** Explanation paragraph with industry/healthcare context. Keep it to 2-3 sentences. Mention a specific standard, company, or real-world scenario to make it tangible.
</quiz>
```

### Key syntax rules

| Element | Syntax | Notes |
|---------|--------|-------|
| Quiz block | `<quiz>` ... `</quiz>` | Must be on its own line, not indented |
| Correct answer | `- [x]` | Exactly one answer should be marked correct |
| Wrong answers | `- [ ]` | 2-3 wrong answers (3-4 total options) |
| Hidden content | `---` | Everything after `---` is hidden until the student answers |
| Inline code | `` `code` `` | Works inside questions and answers |

### Important notes

- The `<quiz>` tag must **not** be indented (no leading spaces)
- Leave a blank line before `<quiz>` and after `</quiz>`
- The `---` separator is required to create the hidden reveal section
- Answers use checkbox-style markdown (`- [ ]` / `- [x]`)

## Placement Guidelines

- **Frequency:** One checkpoint every ~15-20 minutes of student work
- **Location:** After a student completes a hands-on step, not in the middle of an explanation
- **Typical count:** 4-6 checkpoints per 90-minute lab session

## Question Design Guidelines

1. **Verify conceptual understanding**, not exact output matching — students' outputs will differ
2. **Use present tense** ("What does X do?") not future tense ("What will happen?")
3. **Keep wrong answers plausible** — they should represent real misconceptions, not obviously silly
4. **3-4 answer options** — fewer is better than more; avoid 5+ options
5. **One correct answer** per checkpoint

## Hidden Content Guidelines

1. **Start with a bold affirmation** ("Checkpoint complete!", "Part N complete!", "You just did X!")
2. **Explain the industry relevance** in 2-3 sentences — mention specific standards (IEC 62304, ISO 13485, HIPAA), companies (EY, Siemens Healthineers, Google Health), or real-world scenarios
3. **Connect to the student's future** — "you now qualify", "you're ready", "this is exactly what professionals do"
4. **Keep it under 4 sentences total** — students should feel rewarded, not lectured

## Reusable Patterns

### Pattern 1: "What did you observe?"

Best for: verifying the student ran a command and noticed the result.

```html
<quiz>
After running `COMMAND`, what did you observe?

- [ ] Plausible-but-wrong observation A
- [x] The correct observation
- [ ] Plausible-but-wrong observation B

---

**Checkpoint complete!** Industry context about why this observation matters. Real-world example in 1-2 sentences.
</quiz>
```

### Pattern 2: "What does this command/concept do?"

Best for: verifying understanding of a tool or concept just taught.

```html
<quiz>
What does the `COMMAND --FLAG` flag do?

- [ ] Misconception A (common beginner guess)
- [ ] Misconception B (sounds plausible)
- [x] The actual behavior
- [ ] Misconception C (related but wrong)

---

**You just learned CONCEPT!** This is used in INDUSTRY_CONTEXT. At COMPANY, engineers use this to SPECIFIC_TASK. You now have the same skill.
</quiz>
```

### Pattern 3: "What would happen if...?"

Best for: testing deeper understanding and edge cases.

```html
<quiz>
What would happen if you ran `COMMAND` without `FLAG`?

- [x] The correct consequence
- [ ] Nothing — the flag is optional and has no effect
- [ ] An error message would appear

---

**Great reasoning!** Understanding CONCEPT prevents REAL_WORLD_PROBLEM. In healthcare software, SPECIFIC_SCENARIO. This kind of attention to detail is what separates junior from senior engineers.
</quiz>
```

## Copy-Paste Skeleton

Use this as a starting point — fill in the placeholders:

```html
<quiz>
QUESTION_TEXT

- [ ] WRONG_ANSWER_1
- [x] CORRECT_ANSWER
- [ ] WRONG_ANSWER_2
- [ ] WRONG_ANSWER_3

---

**BOLD_AFFIRMATION** INDUSTRY_CONTEXT_2_TO_3_SENTENCES
</quiz>
```

## Example: Week 1 Checkpoints

Week 1 has 6 checkpoints placed at approximately these intervals:

| # | Location | ~Minute | Topic |
|---|----------|---------|-------|
| 1 | After Section 1.3 (`cd`) | 15 | File system navigation |
| 2 | After Exercise 1.8 (end of Part 1) | 30 | Terminal command mastery |
| 3 | After Section 2.5 (first commit) | 50 | Staging area concept |
| 4 | After Exercise 2.8 (5 commits) | 65 | Commit history / traceability |
| 5 | After Section 3.4 (SSH test) | 75 | Cryptographic authentication |
| 6 | After Section 4.1 (push to GitHub) | 85 | Cloud backup / full workflow |

Use this as a reference for checkpoint density and placement when adding checkpoints to other weeks.
