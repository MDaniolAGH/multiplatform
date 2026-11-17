# Agentic SDLC: From Idea to Merge

<div class="lab-meta" markdown>
<div class="lab-meta__row"><span class="lab-meta__label">Course</span> Multiplatform Mobile Software Engineering in Practice</div>
<div class="lab-meta__row"><span class="lab-meta__label">Type</span> Guide. Read it before Lab 4 and keep it open during project work</div>
<div class="lab-meta__row"><span class="lab-meta__label">Reading time</span> about 40 min</div>
<div class="lab-meta__row"><span class="lab-meta__label">Builds on</span> Lecture 3 (working with a coding agent) and Lecture 4 (acceptance criteria, plan and diff review)</div>
</div>

A coding agent can write a Flutter screen in a few minutes. That alone is not a way to build software. Somebody still has to decide what the screen is for, describe it precisely enough to check, give the agent what it needs to know about the project, look at what it did, prove that it works, and be able to explain the change months later.

This guide follows **one feature**, a weekly mood summary for the Mood Tracker, from a sketch to a merged pull request. At every stage it shows who does the work, what goes in, what comes out, and what checks it.

<div class="grid cards" markdown>

- :material-target:{ .lg .middle } **After reading, you can**

    ---

    - [ ] Explain what an agent adds to a language model, and why the same model behaves differently in a different harness
    - [ ] Decide what belongs in an agent's context, and why more context is not always better
    - [ ] Keep the project knowledge (architecture, decisions, notes) that an agent needs to plan well, and keep it up to date
    - [ ] Write an `AGENTS.md` that sets roles, standards and the checks an agent must pass
    - [ ] Take a feature through all ten stages and name what each stage leaves behind
    - [ ] Trace a merged line of code back to the goal and the decision that justified it

- :material-map-legend:{ .lg .middle } **How to read this guide**

    ---

    | Section | What it covers |
    |---|---|
    | The pipeline at a glance | The whole process on one interactive map |
    | 1. From a prompt to an agent | Model, harness, tools |
    | 2. Context | What the agent knows, and what it costs |
    | 3. Project knowledge | What the plan is built on |
    | 4. `AGENTS.md` | The project's rules for agents |
    | 5. Stage by stage | The worked example, ten stages |
    | 6. Auditability | Walk back from code to goal |
    | 7. Templates | Ready to copy |

</div>

---

## The Pipeline at a Glance

Work flows from top to bottom. The colour of a stage shows who does the work; a stage that spans two lanes is shared. On the left is the **project knowledge**: the documents the agent reads before it plans, and the documentation stage updates.

**Try it.** Press **Walk through** to follow the weekly summary through every stage, including a failed check. Use **Show** to add the feedback loops, the knowledge flows or the audit trail. Click a stage, or a document in the project knowledge. The arrow keys step through the walk.

<div class="sdlc">
<div class="sdlc-toolbar">
<div class="sdlc-toolbar__group" role="group" aria-label="Walk through the pipeline">
<button type="button" class="sdlc-btn" data-action="prev" aria-label="Previous step">◀</button>
<button type="button" class="sdlc-btn sdlc-btn--primary" data-action="play">▶ Walk through</button>
<button type="button" class="sdlc-btn" data-action="next" aria-label="Next step">▶</button>
<span class="sdlc-toolbar__status" aria-live="polite"></span>
</div>
<div class="sdlc-toolbar__group" role="group" aria-label="Layers">
<span class="sdlc-legend__hint">Show:</span>
<button type="button" class="sdlc-chip is-loop" data-layer="loops" aria-pressed="false">Feedback loops</button>
<button type="button" class="sdlc-chip is-knowledge" data-layer="knowledge" aria-pressed="false">Knowledge flows</button>
<button type="button" class="sdlc-chip is-audit" data-layer="audit" aria-pressed="false">Audit trail</button>
</div>
</div>

<div class="sdlc-legend">
<span class="sdlc-legend__hint">Who:</span>
<button type="button" class="sdlc-chip is-you" data-actor="you" aria-pressed="false">You and your team</button>
<button type="button" class="sdlc-chip is-agent" data-actor="agent" aria-pressed="false">Coding agent</button>
<button type="button" class="sdlc-chip is-tool" data-actor="tool" aria-pressed="false">Deterministic tools</button>
</div>

<div class="sdlc-map" role="group" aria-label="Agentic SDLC pipeline: ten stages from idea to merge, with the project knowledge on the left">
<div class="sdlc-lane sdlc-lane--you is-you" aria-hidden="true"></div>
<div class="sdlc-lane sdlc-lane--agent is-agent" aria-hidden="true"></div>
<div class="sdlc-lane sdlc-lane--tool is-tool" aria-hidden="true"></div>
<div class="sdlc-lane-title is-knowledge" style="grid-column:2">Knowledge</div>
<div class="sdlc-lane-title is-you" style="grid-column:4">You</div>
<div class="sdlc-lane-title is-agent" style="grid-column:5">Agent</div>
<div class="sdlc-lane-title is-tool" style="grid-column:6">Tools</div>
<div class="sdlc-rail" aria-hidden="true"><span>Auditability</span><i class="sdlc-rail__fill"></i></div>

<div class="sdlc-kb is-knowledge">
<a class="sdlc-kb__title" href="#knowledge">Project know&shy;ledge</a>
<a class="sdlc-kb__doc" href="#knowledge" data-doc="architecture" data-feeds="analysis requirements plan implementation review">Archi&shy;tecture</a>
<a class="sdlc-kb__doc" href="#knowledge" data-doc="decisions" data-feeds="plan review">Deci&shy;sions</a>
<a class="sdlc-kb__doc" href="#knowledge" data-doc="notes" data-feeds="plan implementation">Notes &amp; log</a>
<a class="sdlc-kb__doc" href="#knowledge" data-doc="api" data-feeds="requirements plan implementation">README &amp; API</a>
<a class="sdlc-kb__doc" href="#agents-md" data-doc="agents" data-feeds="requirements plan implementation gate tests review">AGENTS<wbr>.md</a>
<a class="sdlc-kb__doc" href="#knowledge" data-doc="design" data-feeds="requirements plan">Design</a>
</div>

<a class="sdlc-stage is-you" href="#stage-idea" data-stage="idea" data-order="1" data-actors="you" style="--row:2;--col:4"><span class="sdlc-stage__n">1</span><span class="sdlc-stage__t">Idea</span><span class="sdlc-stage__s">a sketch, one sentence</span><span class="sdlc-stage__rec">issue #7</span></a>
<a class="sdlc-stage is-you" href="#stage-analysis" data-stage="analysis" data-order="2" data-actors="you" style="--row:3;--col:4"><span class="sdlc-stage__n">2</span><span class="sdlc-stage__t">Analysis</span><span class="sdlc-stage__s">define the goal</span><span class="sdlc-stage__rec">GOAL-1</span></a>
<a class="sdlc-stage is-you-agent" href="#stage-requirements" data-stage="requirements" data-order="3" data-actors="you agent" style="--row:4;--col:4 / 6"><span class="sdlc-stage__n">3</span><span class="sdlc-stage__t">Technical requirements</span><span class="sdlc-stage__s">criteria you can check</span><span class="sdlc-stage__rec">AC 1–6</span></a>
<a class="sdlc-stage is-you-agent is-kb-reader" href="#stage-plan" data-stage="plan" data-order="4" data-actors="you agent" style="--row:5;--col:4 / 6"><span class="sdlc-stage__n">4</span><span class="sdlc-stage__t">Plan</span><span class="sdlc-stage__s">reads the project knowledge · you approve</span><span class="sdlc-stage__rec">plan + answers</span></a>
<a class="sdlc-stage is-agent" href="#stage-implementation" data-stage="implementation" data-order="5" data-actors="agent" style="--row:6;--col:5"><span class="sdlc-stage__n">5</span><span class="sdlc-stage__t">Imple&shy;mentation</span><span class="sdlc-stage__s">a branch, small commits</span><span class="sdlc-stage__rec">Refs: GOAL-1</span></a>
<a class="sdlc-stage is-tool" href="#stage-gate" data-stage="gate" data-order="6" data-actors="tool" style="--row:7;--col:6"><span class="sdlc-stage__n">6</span><span class="sdlc-stage__t">Quality gate</span><span class="sdlc-stage__s">same input, same verdict</span><span class="sdlc-stage__rec">CI log</span></a>
<a class="sdlc-stage is-agent-tool" href="#stage-tests" data-stage="tests" data-order="7" data-actors="agent tool you" style="--row:8;--col:5 / 7"><span class="sdlc-stage__n">7</span><span class="sdlc-stage__t">Tests</span><span class="sdlc-stage__s">unit, widget, end-to-end, a real run</span><span class="sdlc-stage__rec">test report</span></a>
<a class="sdlc-stage is-you-agent" href="#stage-docs" data-stage="docs" data-order="8" data-actors="you agent" style="--row:9;--col:4 / 6"><span class="sdlc-stage__n">8</span><span class="sdlc-stage__t">Documentation</span><span class="sdlc-stage__s">update what the next plan reads</span><span class="sdlc-stage__rec">ADR-0004</span></a>
<a class="sdlc-stage is-you-agent" href="#stage-pr" data-stage="pr" data-order="9" data-actors="you agent" style="--row:10;--col:4 / 6"><span class="sdlc-stage__n">9</span><span class="sdlc-stage__t">Pull request</span><span class="sdlc-stage__s">agent drafts, you own it</span><span class="sdlc-stage__rec">PR #12</span></a>
<a class="sdlc-stage is-you" href="#stage-review" data-stage="review" data-order="10" data-actors="you" style="--row:11;--col:4"><span class="sdlc-stage__n">10</span><span class="sdlc-stage__t">Review and merge</span><span class="sdlc-stage__s">a person decides</span><span class="sdlc-stage__rec">approval</span></a>
</div>

<div class="sdlc-panel" aria-live="polite"><p class="sdlc-panel__empty">Click a stage or a document, or press <b>Walk through</b>.</p></div>

<div class="sdlc-details">
<div data-detail="idea"><h4>1. Idea</h4><dl><dt>Who</dt><dd>You, or the person who wants the feature</dd><dt>In</dt><dd>A user need</dd><dt>Out</dt><dd>A sketch and one sentence, recorded as an issue</dd><dt>Check</dt><dd>Can you say who it is for?</dd></dl></div>
<div data-detail="analysis"><h4>2. Analysis</h4><dl><dt>Who</dt><dd>You: business and technical view together</dd><dt>In</dt><dd>The idea; the architecture, to see what it touches</dd><dt>Out</dt><dd>A goal with an ID: what the screen does, its value, what it integrates with, constraints, what is out of scope</dd><dt>Check</dt><dd>Could two people build the same thing from it?</dd></dl></div>
<div data-detail="requirements"><h4>3. Technical requirements</h4><dl><dt>Who</dt><dd>You decide; the agent may draft and ask questions</dd><dt>In</dt><dd>Goal, design, architecture and API docs, <code>AGENTS.md</code></dd><dt>Out</dt><dd><code>ACCEPTANCE.md</code>: numbered, observable criteria</dd><dt>Check</dt><dd>Every criterion can be shown true or false by a test or a run</dd></dl></div>
<div data-detail="plan"><h4>4. Plan</h4><dl><dt>Who</dt><dd>The agent proposes; you approve, correct or ask for an alternative</dd><dt>In</dt><dd>Criteria and the <b>project knowledge</b>: architecture, decision records, notes, API docs, design, <code>AGENTS.md</code></dd><dt>Out</dt><dd>An approved plan: files, approach, the documents it relied on, contradictions found, questions answered</dd><dt>Check</dt><dd>Each criterion maps to a step; the plan fits the architecture and the recorded decisions</dd></dl></div>
<div data-detail="implementation"><h4>5. Implementation</h4><dl><dt>Who</dt><dd>The agent, inside its harness</dd><dt>In</dt><dd>The approved plan, notes, <code>AGENTS.md</code></dd><dt>Out</dt><dd>Small changes on a branch, with commit messages that say why</dd><dt>Check</dt><dd>The diff matches the plan; no unrelated edits</dd></dl></div>
<div data-detail="gate"><h4>6. Quality gate</h4><dl><dt>Who</dt><dd>Deterministic tools: analyzer and lints, formatter, secret scan, golden tests, dependency scan</dd><dt>In</dt><dd>The changed code</dd><dt>Out</dt><dd>Pass, or an exact error the agent must fix</dd><dt>Check</dt><dd>A pass means well-formed code, not a correct feature</dd></dl></div>
<div data-detail="tests"><h4>7. Tests</h4><dl><dt>Who</dt><dd>The agent writes them, tools run them; you check they test the criteria and run the app yourself</dd><dt>In</dt><dd>Criteria and code</dd><dt>Out</dt><dd>Unit, widget and end-to-end results, and what you saw on a device</dd><dt>Check</dt><dd>Would the test fail if the feature were broken?</dd></dl></div>
<div data-detail="docs"><h4>8. Documentation</h4><dl><dt>Who</dt><dd>The agent drafts; you check</dd><dt>In</dt><dd>The change, the decisions made in the plan, what went wrong on the way</dd><dt>Out</dt><dd>Updated architecture, a decision record, a notes entry, <code>AGENTS.md</code> if a rule was missing</dd><dt>Check</dt><dd>The documents describe the code as it now is</dd></dl></div>
<div data-detail="pr"><h4>9. Pull request</h4><dl><dt>Who</dt><dd>The agent drafts the description; you correct it and submit it</dd><dt>In</dt><dd>Commits, test and gate results, documentation changes</dd><dt>Out</dt><dd>What and why, how to review, evidence, documents changed, AI assistance</dd><dt>Check</dt><dd>Every claim in it is backed by output you saw</dd></dl></div>
<div data-detail="review"><h4>10. Review and merge</h4><dl><dt>Who</dt><dd>A person: a teammate reviews, the owner merges</dd><dt>In</dt><dd>The pull request, the architecture and decision records</dd><dt>Out</dt><dd>A review record and the merge; the knowledge now describes the new feature</dd><dt>Check</dt><dd>The team's review standards; the author can explain every line</dd></dl></div>
<div data-detail="kb"><h4>Project knowledge</h4><dl><dt>What</dt><dd>The documents in the repository that describe the system and why it is the way it is</dd><dt>Why</dt><dd>A coding agent starts every session knowing nothing about your project. These documents are how it learns the architecture and earlier decisions instead of guessing them.</dd><dt>Try</dt><dd>Click one document on the map to see which stages read it.</dd></dl></div>
</div>

<div class="sdlc-kb-details">
<div data-kb="architecture"><h4>Architecture: <code>ARCHITECTURE.md</code></h4><dl><dt>Records</dt><dd>The layers (models, data, widgets, screens), what each may depend on, where state lives, how data flows</dd><dt>Read by</dt><dd>Analysis, requirements, <b>plan</b> (where the change goes), implementation, review (does the change respect it?)</dd><dt>Updated</dt><dd>In stage 8, whenever the structure changes</dd></dl></div>
<div data-kb="decisions"><h4>Decisions: <code>docs/decisions/</code></h4><dl><dt>Records</dt><dd>One architecture decision record (ADR) per decision: context, decision, consequences. Example: ADR-0004, weeks start on Monday</dd><dt>Read by</dt><dd><b>Plan</b> and review</dd><dt>Why</dt><dd>Stops the agent, and new teammates, from silently re-deciding settled questions</dd></dl></div>
<div data-kb="notes"><h4>Notes and work log: <code>NOTES.md</code></h4><dl><dt>Records</dt><dd>What was done, what is in progress, known problems and traps, such as "createdAt may arrive in UTC: convert to local time before grouping by day"</dd><dt>Read by</dt><dd><b>Plan</b> and implementation</dd><dt>Why</dt><dd>The agent's context ends with the session; the notes stay</dd></dl></div>
<div data-kb="api"><h4>README and API docs</h4><dl><dt>Records</dt><dd>How to build and run the app; the backend contract: endpoints, fields, errors</dd><dt>Read by</dt><dd>Requirements, <b>plan</b>, implementation</dd></dl></div>
<div data-kb="agents"><h4><code>AGENTS.md</code></h4><dl><dt>Records</dt><dd>The rules for <em>working</em>: roles, standards, commands, boundaries, and where the other documents are</dd><dt>Read by</dt><dd>Almost every stage: it is the agent's entry point</dd></dl></div>
<div data-kb="design"><h4>Design</h4><dl><dt>Records</dt><dd>Mock-ups and sketches, or a design tool connected through MCP</dd><dt>Read by</dt><dd>Requirements and <b>plan</b></dd></dl></div>
</div>

<div class="sdlc-audits">
<div data-audit="idea"><h4>Audit record: the issue</h4><dl><dt>Record</dt><dd>Issue #7, "Weekly summary", with the sketch</dd><dt>Lives in</dt><dd>The issue tracker</dd><dt>Points back to</dt><dd>The user who asked</dd></dl></div>
<div data-audit="analysis"><h4>Audit record: GOAL-1</h4><dl><dt>Record</dt><dd>The goal definition, with an ID everything else can cite</dd><dt>Lives in</dt><dd>The issue, or <code>docs/goals/</code></dd><dt>Points back to</dt><dd>Issue #7</dd></dl></div>
<div data-audit="requirements"><h4>Audit record: acceptance criteria</h4><dl><dt>Record</dt><dd><code>ACCEPTANCE.md</code>, criteria numbered 1–6, headed with GOAL-1</dd><dt>Lives in</dt><dd>The repository, next to the code</dd><dt>Points back to</dt><dd>GOAL-1</dd></dl></div>
<div data-audit="plan"><h4>Audit record: the approved plan</h4><dl><dt>Record</dt><dd>The plan, the documents it relied on, and <b>your written answers</b> to its questions</dd><dt>Lives in</dt><dd>The pull request, or <code>docs/plans/</code></dd><dt>Points back to</dt><dd>Criteria 1–6, ADR-0004, <code>ARCHITECTURE.md</code></dd></dl></div>
<div data-audit="implementation"><h4>Audit record: commits</h4><dl><dt>Record</dt><dd>Small commits with <code>Refs: GOAL-1</code> and <code>AI-Agent:</code> trailers</dd><dt>Lives in</dt><dd>Git history</dd><dt>Find it</dt><dd><code>git log --grep="GOAL-1"</code></dd></dl></div>
<div data-audit="gate"><h4>Audit record: the CI log</h4><dl><dt>Record</dt><dd>The quality-gate run for each commit: tool versions, results</dd><dt>Lives in</dt><dd>The CI service, linked from the pull request</dd><dt>Points back to</dt><dd>The exact commit it checked</dd></dl></div>
<div data-audit="tests"><h4>Audit record: the test report</h4><dl><dt>Record</dt><dd>Test names that cite criteria, their results, and your device check</dd><dt>Lives in</dt><dd>CI and the pull request's Evidence section</dd><dt>Points back to</dt><dd>Criteria 2–5</dd></dl></div>
<div data-audit="docs"><h4>Audit record: decision and notes</h4><dl><dt>Record</dt><dd>ADR-0004, a dated <code>NOTES.md</code> entry, the <code>ARCHITECTURE.md</code> diff</dd><dt>Lives in</dt><dd>The repository, in the same pull request as the code</dd><dt>Points back to</dt><dd>GOAL-1 and the plan's questions</dd></dl></div>
<div data-audit="pr"><h4>Audit record: pull request #12</h4><dl><dt>Record</dt><dd>What and why, evidence, documents changed, AI assistance</dd><dt>Lives in</dt><dd>GitHub</dd><dt>Points back to</dt><dd>GOAL-1, the plan, the CI runs</dd></dl></div>
<div data-audit="review"><h4>Audit record: review and merge</h4><dl><dt>Record</dt><dd>Review comments, the approval, the merge commit</dd><dt>Lives in</dt><dd>GitHub and Git history</dd><dt>Find it</dt><dd><code>gh pr view 12 --comments</code></dd></dl></div>
</div>

<ol class="sdlc-walk">
<li data-stage="idea">A user sketches a card: <em>"I want to see how my week went."</em> You record it as issue #7. It is an idea, not yet a specification.</li>
<li data-stage="analysis">You and the team turn it into <b>GOAL-1</b>: what the card does, why it matters, what it touches, what is out of scope.</li>
<li data-stage="requirements">You write <code>ACCEPTANCE.md</code>: six criteria, including the week boundary and the empty week. The agent may ask questions; you decide.</li>
<li data-stage="kb">Before planning, the agent reads the <b>project knowledge</b>: <code>ARCHITECTURE.md</code>, ADR-0004 (<em>weeks start on Monday</em>) and <code>NOTES.md</code> (<em>createdAt may be UTC</em>). Without them it would have to guess all three.</li>
<li data-stage="plan">The agent proposes a plan: files, approach, the documents it used, <b>one contradiction</b> it found between the documents and the code, and one open question. You answer in writing and approve.</li>
<li data-stage="implementation">On a branch, the agent implements the first step and runs the checks.</li>
<li data-stage="gate" data-result="fail">The gate <b>fails</b>: <code>flutter analyze</code> reports an unused import. Same input, same verdict, every time.</li>
<li data-stage="implementation">The error goes back to the agent, which removes the import. Nobody had to copy and paste anything.</li>
<li data-stage="gate" data-result="pass">The gate <b>passes</b>. That proves the code is well-formed, not that the feature does what you asked.</li>
<li data-stage="tests">The tests run against the criteria, including the Sunday 23:59 boundary test you read before the code existed. You also run the app on a phone.</li>
<li data-stage="docs">The agent drafts the documentation: the new model in <code>ARCHITECTURE.md</code>, ADR-0004, a <code>NOTES.md</code> entry with what is left. You check that it matches the code.</li>
<li data-stage="pr">You open pull request #12: what and why, how to review, real evidence, documents changed, AI assistance.</li>
<li data-stage="review">A teammate reviews against the checklist, asks one question, and approves. You merge.</li>
<li data-stage="kb">Merged. The project knowledge now describes the weekly summary, so the <b>next</b> plan starts from it. That loop is what makes the next feature cheaper.</li>
</ol>
</div>

---

## 1. From a Prompt to an Agent

A language model on its own does one thing: given a prompt, it produces text. In a chat window that is the whole loop: **model → prompt → output**. You copy code in, copy the answer out, and you are the one who runs it, tests it and notices what is wrong.

An **agent** closes that loop. It wraps the model in a **harness**: the software that lets the model read files, run commands, look at the results and try again.

<div class="agent-compare">
<div class="agent-compare__panel">
<p class="agent-compare__title">Chat assistant</p>
<div class="flow">
<div class="flow__box is-you">You write a prompt</div>
<div class="flow__arrow">paste code in</div>
<div class="flow__box is-agent">Model</div>
<div class="flow__arrow">copy the answer out</div>
<div class="flow__box is-you">You run, test and fix it</div>
</div>
<p class="flow__note">The model never sees whether its code compiles. Every check is yours, done by hand.</p>
</div>
<div class="agent-compare__panel">
<p class="agent-compare__title">Agent = model + harness</p>
<div class="harness">
<span class="harness__label">Harness</span>
<div class="harness__part harness__part--tools"><b>Tools</b>read and edit files, run commands, search; more through MCP</div>
<div class="harness__part harness__part--auto"><b>Automation</b>the loop: plan, act, observe, repeat; hooks</div>
<div class="harness__model">Model</div>
<div class="harness__part harness__part--instr"><b>Instructions</b>the task prompt and reusable commands</div>
<div class="harness__part harness__part--std"><b>Standards</b><code>AGENTS.md</code>: the project's rules</div>
</div>
<p class="harness__task">A harness is a kit put together for one kind of task.</p>
</div>
</div>

| Part of the harness | What it does | Where you meet it in this course |
|---|---|---|
| **Tools** | Let the model act: read and edit files, run commands, search the code | The agent runs `flutter test` and reads the output itself |
| **Automation** | Runs the loop: plan, act, observe the result, repeat until done or stuck | The agent fixes an analyzer error without you pasting it back |
| **Instructions** | Frame each task: the prompt, plus reusable prompts and commands | The task prompt in Lecture 4 |
| **Standards** | Project rules the agent must follow on every task | `AGENTS.md` in the Lecture 4 demo project |

Two consequences matter in practice:

1. **The same model in a different harness is a different agent.** Claude, Gemini or GPT models behave differently in GitHub Copilot, in a command-line agent and in a chat window, because they have different tools, loops and rules around them.
2. **When an agent does poor work, fix the harness first.** Missing standards, missing project knowledge, a vague task or a tool it cannot run are far more common causes than "the model is bad". Changing the model rarely fixes a missing rule.

!!! info "MCP: plugging more tools into a harness"
    The **Model Context Protocol (MCP)** is an open protocol for connecting extra tools and data sources to a harness. An example is a design tool, so that the agent reads the screen design directly instead of you pasting a screenshot. MCP is optional; nothing in this course requires it.

---

## 2. Context: What the Agent Knows

The model knows nothing about your project except what is in its **context window** for the current task. Everything the agent works from has to fit there:

<div class="ctx">
<div class="ctx__bar" role="img" aria-label="Illustrative context window: rules, project knowledge, code, work log, changes, and free space">
<div class="ctx__seg" style="--w:5;background:#0B3C4D">Rules</div>
<div class="ctx__seg" style="--w:11;background:#4F46E5">Knowledge</div>
<div class="ctx__seg" style="--w:20;background:#0E7490">Code it has read</div>
<div class="ctx__seg" style="--w:15;background:#92600A">Work log</div>
<div class="ctx__seg" style="--w:8;background:#1B7F55">Changes</div>
<div class="ctx__seg ctx__seg--free" style="--w:41">free</div>
</div>
<div class="ctx__scale"><span>start of the task</span><span>illustrative proportions</span><span>window limit</span></div>
<div class="subagents">
<div class="subagents__main"><b>Main agent</b>: keeps the plan and the criteria, delegates the parts</div>
<div class="subagents__child"><b>Sub-agent A</b><br>find every place that reads entries</div>
<div class="subagents__child"><b>Sub-agent B</b><br>write the date-grouping function</div>
<div class="subagents__child"><b>Sub-agent C</b><br>write the tests for criterion 4</div>
<div class="subagents__note">Each sub-agent starts with a small, fresh context and returns a short result, not its whole work log.</div>
</div>
</div>

- **Rules**: `AGENTS.md` and the task prompt.
- **Project knowledge**: the architecture, decision records and notes it has read (Section 3).
- **Code** the agent has opened.
- **Work log**: its own earlier steps and every tool output, such as a long test run.
- **Changes**: the diffs made so far.

Context windows in current models are large: hundreds of thousands of tokens, and up to about a million for some. Filling them is still a bad idea, for three reasons:

- **Cost.** Every step of the loop sends the context again, and you pay for it in time and money. Less context means lower cost.
- **Focus.** Irrelevant files and stale tool output compete with what matters. A long session slowly fills with old logs.
- **Sub-agents** help. A large task can be split so that each part starts with a fresh, small context, as in the diagram above.

The opposite failure is **missing information**. A model does not stop when it lacks a fact; it fills the gap with something plausible.

<div class="stat">
<span class="stat__num stat__num--ok">≈ 90%</span><span class="stat__txt">of what an agent produces with missing information is fine…</span>
<span class="stat__num stat__num--bad">≈ 10%</span><span class="stat__txt">…is confident nonsense, written in exactly the same tone as the rest.</span>
<span class="stat__foot">A rule of thumb used in this course, not a measured figure. The point is the second line: reading the output does not tell you which part is wrong.</span>
</div>

That is why this pipeline does two things. It gives the agent the facts it needs: the goal, the criteria and, above all, the **project knowledge**. And it demands **evidence**: tests written against your criteria and gates that run without anyone's opinion. A test turns "looks right" into "checked".

!!! tip "What to put in the context, and what to leave out"
    **Include**: the criteria, the files the change touches, the relevant project documents, the project rules.
    **Leave out**: the whole repository "just in case", old chat history, unrelated logs.
    **Never include** passwords, API keys or real personal or health data. The context is sent to the model's provider.
    **Start a fresh session** when a task is finished, after writing down in `NOTES.md` what the next session needs to know.

---

## 3. Project Knowledge: What the Plan Is Built On {#knowledge}

!!! danger "The most important input to the plan"
    A coding agent has **no memory of your project** between sessions. Everything it learned yesterday, it has forgotten. If the architecture, the decisions and the traps are not written down in the repository, the agent will guess them again in every session, and each guess can be different. The documents in this section are the project's long-term memory, for agents and for people.

The context window (Section 2) is short-term memory: it lasts for one task. **Project knowledge** is what survives between tasks: the documents in the repository that describe what the system is, why it is that way, and what you have learned while building it.

| Document | What it records | The plan uses it to… |
|---|---|---|
| `README.md` | What the app is; how to build, run and test it | run the right commands |
| `ARCHITECTURE.md` | Layers and modules, what may depend on what, where state lives, how data flows | put the change in the right place, in the right shape |
| `docs/decisions/` | One architecture decision record (ADR) per decision: context, decision, consequences | respect decisions instead of re-making them |
| `NOTES.md` | Work log: done, in progress, known problems, traps found | avoid repeating mistakes; continue where the last session stopped |
| API docs | The backend contract: endpoints, fields, errors | use the data correctly |
| Design | Mock-ups and sketches | build the screen that was designed |
| `AGENTS.md` | How to work here: roles, standards, commands, boundaries (Section 4) | follow the rules, and find the documents above |

`AGENTS.md` says **how to work**. The other documents say **what the system is, and why**. Keep them apart: the rules are read on every task, while the agent reads the knowledge documents only when the task needs them.

=== "ARCHITECTURE.md"

    ```markdown
    # Mood Tracker: architecture

    ## Layers (dependencies point down only)
    screens/   HomeScreen owns the app's state and passes data down
    widgets/   stateless where possible; report events up through callbacks
    models/    pure Dart: data classes and functions, no Flutter imports
    data/      sample entries now; the API client from Lecture 6

    ## Rules
    - Logic that depends on the date takes the date as a parameter
      (see ADR-0003); it never calls DateTime.now() itself.
    - Lists are never changed in place; functions return new lists.

    ## Data flow
    entries (HomeScreen) → filter / summarise (models) → widgets → screen
    ```

=== "Decision record"

    ```markdown
    # ADR-0004: Weeks start on Monday

    Status: accepted, 2026-11-17 (GOAL-1)

    ## Context
    The weekly summary needs a first day of the week. Our users are in
    Poland, where weeks start on Monday, as in ISO 8601.

    ## Decision
    A week runs from Monday 00:00 to Sunday 23:59:59, in the phone's
    local time.

    ## Consequences
    Simple and testable. If we support other countries, revisit this
    with a new ADR that supersedes this one.
    ```

=== "NOTES.md"

    ```markdown
    # Notes

    ## 2026-11-12: entries from the API (spike)
    - createdAt is parsed from an ISO 8601 string. A trailing "Z" means
      UTC: call toLocal() before grouping entries by day.
    - Known problem: no loading indicator yet.

    ## 2026-11-17: weekly summary (GOAL-1, PR #12)
    - Done: summariseWeek in models/, WeeklySummaryCard in widgets/.
    - Not done: daylight-saving week not tested.
    - Trap: rounding 6.45 gives 6.4 or 6.5 depending on the method;
      we use toStringAsFixed(1) everywhere.
    ```

**Ask the agent to plan from the knowledge, and to say so.** A plan that does not name its sources may have been guessed:

```text title="Planning prompt (example)"
Before planning, read AGENTS.md, ARCHITECTURE.md, docs/decisions/ and the
latest entries in NOTES.md.

Plan GOAL-1 against ACCEPTANCE.md. In the plan:
- list the documents you used and what you took from each;
- point out anything where the documents and the code disagree;
- list the questions the documents do not answer.

Do not change any file yet.
```

!!! tip "Keeping the knowledge useful"
    - **Short and current beats long and complete.** One page of `ARCHITECTURE.md` that is true is worth more than ten that are out of date.
    - **Docs as code.** The documents live in the repository and change **in the same pull request** as the code they describe (stage 8). Reviewers check them like code.
    - **A wrong document is worse than none.** The agent trusts what it reads. If `ARCHITECTURE.md` describes code that no longer exists, every plan starts from a false premise. That is why the plan prompt asks for contradictions.
    - **Make `AGENTS.md` the index.** Agents read it first, so a line such as "Architecture: see `ARCHITECTURE.md`; decisions: `docs/decisions/`" makes sure the rest is found.
    - In the Lecture 4 demo project, the *Layout* table in `AGENTS.md` is a tiny architecture document. In your team project, give the architecture, the decisions and the notes their own files from the first sprint.

---

## 4. `AGENTS.md`: The Project's Rules for Agents {#agents-md}

`AGENTS.md` is a Markdown file in the root of a repository, written for coding agents rather than for people. Many agents read it automatically at the start of each task, so it is their **entry point** into the project. GitHub Copilot's coding agent and Copilot CLI read it, for example.

Support still differs between tools and features. Some Copilot features do not read `AGENTS.md` yet. Claude Code reads its own `CLAUDE.md`, which can refer to `AGENTS.md`. Check your tool's documentation rather than assuming.

A useful `AGENTS.md` answers six questions:

| Section | Question it answers | Example line |
|---|---|---|
| **Roles** | Which agent may do what? | "The implementer edits `lib/` and `test/`; the reviewer only reads and comments." |
| **Project knowledge** | Where are the documents about the system? | "Architecture: `ARCHITECTURE.md`. Decisions: `docs/decisions/`. Notes: `NOTES.md`." |
| **Project standards** | How is the app organised, and what is out of bounds? | "Models in `lib/models/`, widgets in `lib/widgets/`. No new packages." |
| **Code standards** | How do we write code here? | "Never change a list you were given; build a new one." |
| **Commit standards** | What must a commit say? | "Conventional Commits, plus `Refs:` and `AI-Agent:` trailers." |
| **Quality gate** | Which deterministic tools must pass, and what counts as passing? | "`flutter analyze` must report `No issues found!`; every test must pass." |

The Lecture 4 demo project contains a short, real `AGENTS.md`. Section 7 has a full template that adds roles, the knowledge index and commit standards to it.

!!! tip "Keep it short, and prefer tools to sentences"
    Every line of `AGENTS.md` is read on every task, so it costs context every time. If a rule can be checked by a tool (a lint rule, a formatter, a test), put it in the tool and mention the command in `AGENTS.md`. A tool enforces the rule every time; a sentence is only a request.

---

## 5. The Pipeline, Stage by Stage

!!! example "The worked example: a weekly mood summary"
    The Mood Tracker shows a summary and a history of entries. A user sketches a new card: the days of the week, each with its mood score, so they can see how the week went.

    The artefacts below were **written for this guide** to show what each stage should produce. They are not a recording of a real agent session, and no code for this feature ships with the course. The issue and pull request numbers and the commit hash are invented. Where an artefact contains tool output, it is marked as a placeholder for the real output.

### 5.1 Idea {#stage-idea}

<div class="stage-facts is-you">
<span>Who</span><span><span class="sdlc-chip is-you">You</span> or the person who wants the feature</span>
<span>In</span><span>A user need</span>
<span>Out</span><span>A sketch and one sentence, recorded as an issue</span>
</div>

> *"I want to see how my week went: Monday, Tuesday, Wednesday… each with my mood."*

The sketch shows a card with one row per day and a mood score on each. That is enough to start a conversation, so record it as an issue (here, issue #7). It is not enough to start coding: it does not say which week, what happens on a day with three entries or with none, or where the card goes.

### 5.2 Analysis: Define the Goal {#stage-analysis}

<div class="stage-facts is-you">
<span>Who</span><span><span class="sdlc-chip is-you">You</span> the business view and the technical view, together</span>
<span>In</span><span>The idea; the architecture, to see what the idea touches</span>
<span>Out</span><span>A short goal definition with an ID</span>
</div>

Analysis turns an idea into a **goal**. It needs both views. The business side knows why the feature matters; the technical side knows what it costs and what it touches. Answer four questions, and write down what is out of scope:

1. **What does the screen do?**
2. **What value does it bring?**
3. **What does it integrate with?**
4. **What technical constraints apply?**

```text title="GOAL-1: weekly mood summary (from issue #7)"
What it does     Shows, for the current week (Monday to Sunday), the average
                 mood score of each day and of the whole week.
Value            Users notice patterns ("Mondays are hard") without scrolling
                 the history. It is the first view that turns single entries
                 into information.
Integrates with  The existing list of MoodEntry values; later, GET /moods.
Constraints      No new packages. Computed on the device. Days follow the
                 phone's local time. Works with zero entries. Mood data is
                 health data: it stays on the device.
Out of scope     Charts, browsing other weeks, notifications.
```

!!! warning "What goes wrong here"
    Skipping analysis and asking the agent to "make a stats screen". The agent will then decide the value, the scope and the edge cases for you, and they will be plausible guesses.

### 5.3 Technical Requirements {#stage-requirements}

<div class="stage-facts is-you">
<span>Who</span><span><span class="sdlc-chip is-you">You</span> decide · <span class="sdlc-chip is-agent">Agent</span> may draft and ask questions</span>
<span>In</span><span>The goal, the design, the architecture and API docs, <code>AGENTS.md</code></span>
<span>Out</span><span><code>ACCEPTANCE.md</code>: numbered criteria that can be observed</span>
</div>

Requirements are the goal written so that each sentence can be **shown true or false** by a test or by running the app. Several inputs feed into them:

- **The design.** A mock-up or a sketch. Paste it in, or connect the design tool through MCP.
- **The project knowledge.** What the architecture and API docs say about the data, such as how dates arrive from the backend.
- **The work standards.** What `AGENTS.md` already fixes, such as no new packages.

```markdown title="ACCEPTANCE.md"
# Weekly summary: acceptance criteria (GOAL-1)

1. Above the history there is a "This week" card with one row per day,
   Monday to Sunday.
2. Each row shows the average score of that day's entries to one decimal
   place (for example 6.5), or "–" when the day has no entries.
3. The card shows the week's average over all of the week's entries and the
   number of entries.
4. Entries from other weeks are ignored. An entry made on Sunday at 23:59
   counts for that week; an entry made on the next Monday at 00:00 does not.
5. With no entries this week, the card says "No entries this week yet."
   instead of seven dashes.
6. The existing summary and history do not change.
```

!!! question "Which criterion would you test first?"
    ??? success "Answer"
        Criteria 4 and 5. Edges (the week boundary, the empty week) are where a plausible guess is most likely to be wrong, and where nobody notices by just looking at the screen with today's data.

!!! warning "What goes wrong here"
    - Criteria nobody can observe, such as "the code is clean".
    - Missing edge cases: time boundaries, empty data, very long text.
    - Letting the agent write the criteria it will later be judged by, without reading them.

### 5.4 Plan: What We Will Build, and How {#stage-plan}

<div class="stage-facts is-agent">
<span>Who</span><span><span class="sdlc-chip is-agent">Agent</span> proposes · <span class="sdlc-chip is-you">You</span> approve, correct or ask for an alternative</span>
<span>In</span><span><code>ACCEPTANCE.md</code> and the <a href="#knowledge"><b>project knowledge</b></a>: <code>ARCHITECTURE.md</code>, decision records, <code>NOTES.md</code>, API docs, design, <code>AGENTS.md</code></span>
<span>Out</span><span>An approved plan, with its sources, the contradictions found, and your written answers</span>
</div>

Ask the agent for a plan **before** it edits anything. The plan says *what* will be built and *how*: which files, which approach, which checks.

!!! danger "No plan without the project knowledge"
    Point the agent at the architecture, the decision records and the notes **before** it plans (the planning prompt in Section 3), and expect the plan to **name the documents it used**. A plan that cites no sources has guessed the architecture. Compare the two versions below: the knowledge removed one question, prevented one bug and exposed one stale document.

=== "Planned with the project knowledge"

    ```text
    Plan: weekly summary (GOAL-1)

    Based on
      ARCHITECTURE.md      models are pure Dart; HomeScreen owns the entries;
                           date logic takes the date as a parameter
      ADR-0004             weeks start on Monday, local time
      NOTES.md 2026-11-12  createdAt may be UTC: call toLocal() before grouping
      Contradiction        ARCHITECTURE.md lists lib/services/, which does not
                           exist yet. I will not create it.

    Files
      new   lib/models/weekly_summary.dart       summariseWeek(entries, today:)
      new   lib/widgets/weekly_summary_card.dart stateless card
      edit  lib/screens/home_screen.dart         card above the history (1, 6)
      new   test/weekly_summary_test.dart        criteria 2-5
      edit  test/widget_test.dart                criteria 1, 5, 6

    Approach
      Convert each createdAt with toLocal(), then group by day, Monday first.
      `today` is a parameter, so tests can fix the date (criterion 4).

    Question
      1. Should 6.45 round to 6.5?

    Checks
      flutter analyze and flutter test; I will report the actual output.
    ```

=== "Planned without it"

    ```text
    Plan: weekly summary

    Files
      new   lib/services/stats_service.dart   computes the week with DateTime.now()
      new   lib/screens/stats_screen.dart     a new screen with a bar chart
      edit  pubspec.yaml                      add a chart package

    Approach
      Group entries by createdAt.weekday, week starting on Sunday.

    Checks
      Run the tests.
    ```

    Every line is plausible, and four of them are wrong for this project: a layer that does not exist, a clock no test can control, a package `AGENTS.md` forbids, and a week that starts on the wrong day. Grouping UTC timestamps without `toLocal()` would also put entries made just after midnight on the previous day.

Review a plan with these questions:

- [ ] Does it **name the documents** it used, and did it read the right ones?
- [ ] Does it fit `ARCHITECTURE.md` and respect every relevant decision record?
- [ ] Does every criterion map to at least one step?
- [ ] Are all files inside what the task allows? Is any package added?
- [ ] Is the approach testable? Here, passing `today` in makes criterion 4 testable.
- [ ] Are the agent's questions answered **in writing**, and the contradictions it found fixed or noted? Answers are decisions, so they belong in the record.

A plan is cheap; an implementation is not. You can reject a plan, or ask for two alternatives and choose one, for a fraction of the cost of undoing code.

### 5.5 Implementation {#stage-implementation}

<div class="stage-facts is-agent">
<span>Who</span><span><span class="sdlc-chip is-agent">Agent</span> inside its harness</span>
<span>In</span><span>The approved plan, <code>NOTES.md</code>, <code>AGENTS.md</code></span>
<span>Out</span><span>Small, reviewable changes on a branch, each with a commit message that says why</span>
</div>

The agent works on a **branch** (here `feature/weekly-summary`), never directly on `main`. It implements the plan and follows the standards, the architecture and the interfaces the plan fixed. It runs the checks after every change (Section 5.6) and loops until they pass.

Each change ends in a **commit**, and the commit message is part of the record. Besides *what* changed, a good message links the change to *why* and records *how* it was made:

```text title="Commit message (illustrative)"
feat(stats): add weekly mood summary model

Story: As a user I want to see how my week went, so that I notice patterns.
Task:  GOAL-1, criteria 2-5: per-day and weekly averages.
Done:  summariseWeek(entries, today:) converts createdAt to local time,
       groups by day, Monday first (ADR-0004), and returns no average for
       days without entries.

Refs: GOAL-1
Standards: AGENTS.md rev. 2026-11-17
AI-Agent: <agent and model you used>
Reviewed-by: <your name>
```

The `Key: value` lines at the end are **Git trailers**. Git and other tools can read them, so `git log --grep="GOAL-1"` lists every commit for the goal.

!!! note "In this course's labs, you make the commit"
    The Lecture 4 `AGENTS.md` tells the agent **not** to commit. You review the diff first, then commit using a message like the one above. In a team with more experience, the agent may commit to a branch, but a person still reviews before anything is merged.

!!! warning "What goes wrong here"
    - One huge commit called "add stats".
    - Edits to files the plan did not mention.
    - "Fixing" a failing test by weakening it. `AGENTS.md` forbids this, and the diff shows it.

### 5.6 Quality Gate: Deterministic Tools {#stage-gate}

<div class="stage-facts is-tool">
<span>Who</span><span><span class="sdlc-chip is-tool">Deterministic tools</span></span>
<span>In</span><span>The changed code</span>
<span>Out</span><span>Pass, or an exact error message that goes back to the agent</span>
</div>

A deterministic tool gives the **same verdict for the same input, every time**, cheaply and without an opinion. A language model gives none of those guarantees, which is exactly why the gate exists. When the gate fails, its output goes back to the agent, which reads the error and fixes the code (the red loop on the map).

| Tool | What it checks | Command |
|---|---|---|
| Lint rules (`flutter_lints` in `analysis_options.yaml`) | Good practice for Dart and Flutter code | part of `flutter analyze` |
| `flutter analyze` (`dart analyze` for pure Dart) | Types, imports, lint rules | `flutter analyze` |
| `dart format` | Consistent formatting | `dart format --output=none --set-exit-if-changed .` |
| git-secrets | Passwords and keys about to be committed | `git secrets --scan` |
| Golden tests | The UI against a saved reference image | `flutter test` (tests use `matchesGoldenFile`) |
| OSV-Scanner | Known vulnerabilities in your dependencies (`pubspec.lock`) | `osv-scanner scan source -r .` |

The gate runs in three places. The agent runs it after every change, because `AGENTS.md` says so. A pre-commit hook can run it before each commit. And CI runs it on every pull request, so nobody can skip it:

```yaml title=".github/workflows/quality-gate.yml (minimal example)"
name: quality-gate
on: pull_request
jobs:
  gate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter pub get
      - run: dart format --output=none --set-exit-if-changed .
      - run: flutter analyze
      - run: flutter test
```

!!! danger "A passing gate does not mean a correct feature"
    In Lecture 4, `flutter analyze` reported `No issues found!` for a filter that deleted entries from the app's data. The gate proves the code is well-formed. Only tests against your criteria, and running the app, show that it does what you asked.

### 5.7 Tests {#stage-tests}

<div class="stage-facts is-tool">
<span>Who</span><span><span class="sdlc-chip is-agent">Agent</span> writes · <span class="sdlc-chip is-tool">Tools</span> run · <span class="sdlc-chip is-you">You</span> check that they test the criteria, and run the app</span>
<span>In</span><span><code>ACCEPTANCE.md</code> and the code</span>
<span>Out</span><span>Tests and their real results, and what you saw on a device</span>
</div>

There are three levels of automated test, from fast and narrow to slow and broad, plus your own run of the app:

| Level | In Flutter | Runs on | For the weekly summary |
|---|---|---|---|
| **Unit** | `test(...)` on plain Dart code | your computer, milliseconds | `summariseWeek`: averages, empty days, the week boundary (criteria 2–5) |
| **Integration** (widget) | `testWidgets(...)` with `flutter_test` | your computer, a simulated screen | the card appears above the history; the empty message (1, 5, 6) |
| **End-to-end** | `integration_test` package | a device or emulator | add an entry, see the week's average change |
| **Your run** | the app itself | a phone or emulator | narrow screen, dark mode, a long week of realistic data |

Here is the unit test for the riskiest criterion. Note how passing `today` in, the decision made in the plan, makes it possible:

```dart title="test/weekly_summary_test.dart (illustrative)"
test('Sunday 23:59 belongs to this week, next Monday 00:00 does not', () {
  final today = DateTime(2026, 11, 18); // a Wednesday
  final entries = [
    MoodEntry(score: 4, createdAt: DateTime(2026, 11, 22, 23, 59)), // Sunday
    MoodEntry(score: 9, createdAt: DateTime(2026, 11, 23, 0, 0)), // next Monday
  ];

  final week = summariseWeek(entries, today: today);

  expect(week.entryCount, 1);
  expect(week.days.last.average, 4.0);
});
```

!!! tip "Who writes the test that matters most?"
    An agent that writes both the code and its tests can make the same wrong assumption in both, and then everything passes. For the riskiest criterion, write the test yourself, or at least read it closely **before** the implementation exists. Then ask: *would this test fail if the feature were broken?* (Lecture 4, "a test that proves nothing".)

### 5.8 Documentation: Update What the Next Plan Reads {#stage-docs}

<div class="stage-facts is-agent">
<span>Who</span><span><span class="sdlc-chip is-agent">Agent</span> drafts · <span class="sdlc-chip is-you">You</span> check against the code</span>
<span>In</span><span>The change, the plan's answers and contradictions, what went wrong on the way</span>
<span>Out</span><span>Updated project knowledge, in the same pull request as the code</span>
</div>

This stage closes the loop that makes the next plan good. Whatever was decided or learned during this feature must be written down now, while it is fresh, or the next session (yours or the agent's) starts without it.

| What happened in this feature | Where it goes |
|---|---|
| A new model and a new widget | `ARCHITECTURE.md`: add them to the layers |
| "Weeks start on Monday" was settled | `docs/decisions/0004-weeks-start-on-monday.md` (ADR) |
| `lib/services/` was listed but does not exist | `ARCHITECTURE.md`: fix the contradiction the plan found |
| Daylight-saving weeks were not tested; the rounding trap | `NOTES.md`: a dated entry |
| The agent read the clock in one draft until told not to | `AGENTS.md`: add the rule, so no one has to say it again |

Agents are good at drafting these updates from the diff and the plan: ask for them explicitly. Your job is to check that the documents describe the code **as it now is**, not as it was planned.

!!! warning "What goes wrong here"
    - "We'll document it later." Later never comes, and the documents slowly turn false.
    - Documentation in a separate pull request that nobody reviews.
    - The agent describes what it *intended* to build. Check the documents against the diff.

### 5.9 Pull Request {#stage-pr}

<div class="stage-facts is-agent">
<span>Who</span><span><span class="sdlc-chip is-agent">Agent</span> drafts · <span class="sdlc-chip is-you">You</span> correct, own and submit</span>
<span>In</span><span>The commits, the gate and test results, the documentation changes</span>
<span>Out</span><span>A pull request a reviewer can check in minutes</span>
</div>

A pull request asks a teammate to accept your change. Its description is written for that reviewer. It says what was done and why, where to look first, what evidence exists, which documents changed, which AI tools helped, and which standards apply. The course's AI rules ask you to state significant AI help in exactly this place.

```markdown title="Pull request #12 (illustrative)"
## What and why
Adds a "This week" card above the history (GOAL-1, criteria 1-6). Closes #7.

## How to review
- Start with `lib/models/weekly_summary.dart`: all the date logic is there.
- Criterion 4 (the week boundary) is the risky part; see the two boundary tests.

## Evidence
- [ ] `flutter analyze`: <paste the real result>
- [ ] `flutter test`: <paste the real summary line>
- [ ] Ran on an Android emulator: <screenshot>
- Not verified: a daylight-saving change during the week.

## Documentation
- ARCHITECTURE.md: new model and widget; removed the non-existent lib/services/
- docs/decisions/0004-weeks-start-on-monday.md (new)
- NOTES.md: entry for 2026-11-17
- AGENTS.md: "do not read the clock inside logic"

## AI assistance
<Agent and model>. The agent proposed the plan, wrote the model class, a first
draft of the tests and the documentation updates. I rewrote the boundary tests
and the card layout.

## Standards
AGENTS.md rev. 2026-11-17 · Conventional Commits with trailers
```

!!! warning "Every line in Evidence must come from output you saw"
    An agent can write "all tests pass" without running them. Paste the real result, or leave the box unticked and say what you did not verify.

### 5.10 Review and Merge {#stage-review}

<div class="stage-facts is-you">
<span>Who</span><span><span class="sdlc-chip is-you">A person</span> a teammate reviews; the owner merges</span>
<span>In</span><span>The pull request, <code>ARCHITECTURE.md</code> and the decision records</span>
<span>Out</span><span>A review record (comments, approval) and the merged change</span>
</div>

The reviewer checks the pull request against the team's **code-review standards** and leaves a record: comments, questions, and finally an approval or a request for changes. An AI reviewer can add useful comments, but it cannot take responsibility. A person approves, and the author must be able to explain every line. "The AI wrote it" is not an answer in a code review.

- [ ] Every criterion is met, with evidence in the pull request
- [ ] The diff matches the approved plan; nothing unrelated changed
- [ ] The change fits `ARCHITECTURE.md` and the decision records
- [ ] The tests would fail if the feature were broken
- [ ] The documentation describes the code as it now is
- [ ] No secrets, no real personal or health data, no new packages without agreement
- [ ] You could explain any line of it if asked

When the pull request is merged, the project knowledge describes the new feature. The next idea starts from there: the pipeline is a loop, not a line.

---

## 6. Auditability: Walk Back From Code to Goal

On the map, the auditability rail runs alongside every stage. Each stage leaves a **record** that points back to the one before it, so you can start from any line of merged code and walk back to the goal, and to the decision, that justified it. Switch on **Audit trail** on the map and click a stage to see its record.

Here is the walk itself. A new teammate opens the weekly summary and asks a fair question. Press **Why is this here?** to follow the trail one step at a time. Then break a link and walk again, to see what is lost.

<div class="audit-walk">
<div class="audit-walk__controls">
<button type="button" class="sdlc-btn sdlc-btn--primary" data-walk="back">↑ Why is this here?</button>
<button type="button" class="sdlc-btn" data-walk="reset">Start again</button>
<span class="audit-walk__count" aria-live="polite"></span>
</div>
<div class="audit-walk__breaks">
<span class="sdlc-legend__hint">Break a link:</span>
<label><input type="checkbox" data-break="no-refs"> commit message "update", no <code>Refs:</code></label>
<label><input type="checkbox" data-break="chat-only"> plan answers given only in chat</label>
<label><input type="checkbox" data-break="no-adr"> no decision record</label>
</div>
<ol class="audit-walk__steps">
<li class="audit-walk__step"><b>Line of code</b><span class="audit-walk__how"><code>lib/models/weekly_summary.dart</code>, line 14</span><span class="audit-walk__code">final monday = day.subtract(Duration(days: day.weekday - DateTime.monday));</span><span class="audit-walk__q">"Why does our week start on Monday? Users in some countries start on Sunday. Can I change it?"</span></li>
<li class="audit-walk__step" data-needs="no-refs"><b>Commit</b><span class="audit-walk__how">found with <code>git blame -L 14,14 lib/models/weekly_summary.dart</code></span><span class="audit-walk__code">3f2a9c1 feat(stats): add weekly mood summary model
Refs: GOAL-1 · AI-Agent: … · Reviewed-by: …</span></li>
<li class="audit-walk__step"><b>Pull request #12</b><span class="audit-walk__how">found with <code>gh pr list --state merged --search "GOAL-1"</code></span><span>Reviewed and approved by a teammate. The description links the plan and lists <code>docs/decisions/0004-weeks-start-on-monday.md</code> under Documentation.</span></li>
<li class="audit-walk__step" data-needs="chat-only"><b>Plan</b><span class="audit-walk__how">linked from the pull request</span><span class="audit-walk__code">Approach  group entries by local day, Monday first
          (why: see the decision record)</span></li>
<li class="audit-walk__step" data-needs="no-adr"><b>Decision record: ADR-0004</b><span class="audit-walk__how">the plan points to it</span><span><em>Context:</em> our users are in Poland, where weeks start on Monday, as in ISO 8601. <em>Consequence:</em> if we support other countries, revisit this with a new ADR.</span></li>
<li class="audit-walk__step"><b>Acceptance criterion 1</b><span class="audit-walk__how">the plan maps its steps to criteria</span><span>"…one row per day, Monday to Sunday."</span></li>
<li class="audit-walk__step"><b>Goal: GOAL-1</b><span class="audit-walk__how">named at the top of <code>ACCEPTANCE.md</code></span><span>Weekly mood summary, from issue #7: "Users notice patterns without scrolling the history."</span></li>
<li class="audit-walk__end"><b>Trail complete</b>Monday is a recorded decision with a reason, not an accident. To change it, write a new ADR that supersedes ADR-0004, and the trail continues.</li>
<li class="audit-walk__break" data-break="no-refs"><b>Trail lost at the commit</b>The message says "update" and names no goal. Which feature was this for? You can only guess from the date, and searching for the goal will not find this commit.</li>
<li class="audit-walk__break" data-break="chat-only"><b>Trail lost at the plan</b>The plan's question about the first day of the week was answered in a chat that no longer exists. Was it a decision or a guess? Nobody can tell, so somebody will "fix" it.</li>
<li class="audit-walk__break" data-break="no-adr"><b>Trail lost at the decision</b>The plan says "Monday first", but there is no decision record to point to. Decided by whom, and why? Without a decision record the reason is gone, and the next agent session may switch to Sunday because that looks just as plausible.</li>
</ol>
</div>

Why it matters:

- **Months later**, the answer to "why?" is in the records, not in someone's memory.
- **Agents.** The next agent session plans from the same records (Section 3). A broken trail for people is a broken context for agents.
- **Regulated software.** Medical-device software standards, such as IEC 62304, expect requirements to be traceable to the code and the tests that implement them. The Mood Tracker is not a medical device, but it handles health data, and the habit costs little.
- **AI-assisted work.** The trailers and the pull request record which agent and model contributed, and who reviewed it.

```bash title="Following the trail with Git"
git log --oneline --grep="GOAL-1"                          # every commit for the goal
git log --format='%h %s%n  %(trailers:key=AI-Agent)'       # who assisted each commit
git blame lib/models/weekly_summary.dart                   # which commit wrote each line
```

---

## 7. Templates

Copy these into your project and adapt them. They follow the conventions used in this course.

=== "AGENTS.md"

    ```markdown
    # AGENTS.md

    Instructions for coding agents working in this project.

    ## Project
    <One paragraph: what the app does, who reads the code.>

    ## Project knowledge (read before planning)
    - Architecture: ARCHITECTURE.md
    - Decisions: docs/decisions/ (one ADR per decision; never contradict an accepted one)
    - Notes and work log: NOTES.md (read the latest entries)
    - API: docs/api.md

    ## Roles
    - Implementer: may edit files under `lib/` and `test/` named in the task.
    - Reviewer: reads the diff and comments; never edits.

    ## Commands
    flutter pub get    # fetch packages
    flutter analyze    # must report "No issues found!"
    flutter test       # every test must pass

    ## Code standards
    - Never change a list you were given; build a new one.
    - Create controllers once in a `State` and dispose of them in `dispose()`.
    - Do not read the clock inside logic; pass the date in.

    ## Commit standards
    Conventional Commits (`feat:`, `fix:`, `test:`, `docs:`, `refactor:`), then a
    body with Story, Task and Done, then trailers: Refs, Standards, AI-Agent.

    ## Quality gate
    Run after every change and report the actual output:
    `dart format --output=none --set-exit-if-changed .`, `flutter analyze`,
    `flutter test`. Do not claim a check passed unless you ran it.

    ## Boundaries
    - Change only the files named in the task. Ask before touching any other file.
    - Do not add packages or edit `pubspec.yaml`.
    - Do not delete or weaken tests to make them pass.
    - Never add real personal or health data.

    ## When you finish
    List the files you changed, the criterion each change addresses, the exact
    gate and test results, anything you did not verify, and the updates needed
    in ARCHITECTURE.md, docs/decisions/ and NOTES.md.
    ```

=== "ARCHITECTURE.md"

    ```markdown
    # <App>: architecture

    ## Purpose
    <Two sentences: what the app does and for whom.>

    ## Layers (dependencies point down only)
    | Layer | Folder | Contains | May depend on |
    |---|---|---|---|
    | Screens | lib/screens/ | screens; own the state | widgets, models, data |
    | Widgets | lib/widgets/ | reusable UI | models |
    | Models | lib/models/ | pure Dart data and logic | nothing from Flutter |
    | Data | lib/data/ | sample data, API client | models |

    ## Data flow
    <Where data comes from, who owns it, how it reaches the screen.>

    ## Rules
    - <Rule> (see ADR-<n>)

    ## Not yet built
    <Parts that are planned but do not exist, so nobody assumes they do.>
    ```

=== "Decision record"

    ```markdown
    # ADR-<n>: <decision in a few words>

    Status: proposed | accepted | superseded by ADR-<m>   (<date>, <GOAL-ID>)

    ## Context
    <The situation and the forces at play. What made a decision necessary?>

    ## Decision
    <What we decided, in one or two sentences.>

    ## Consequences
    <What becomes easier, what becomes harder, when to revisit.>
    ```

=== "NOTES.md"

    ```markdown
    # Notes

    ## <date>: <task> (<GOAL-ID>, PR #<n>)
    - Done: <what now works>
    - In progress / not done: <what is left>
    - Not verified: <what was not checked, and why>
    - Traps: <what surprised you, so the next session avoids it>
    ```

=== "ACCEPTANCE.md"

    ```markdown
    # <Feature>: acceptance criteria (<GOAL-ID>)

    1. <What the user sees or can do, in observable terms.>
    2. <The main behaviour, with a concrete example value.>
    3. <An edge case: empty data, a boundary, very long text.>
    4. <What must NOT change.>

    Out of scope: <what this change will not do>.
    ```

=== "Commit message"

    ```text
    <type>(<scope>): <what, in the imperative, under 60 characters>

    Story: As a <user> I want <goal>, so that <value>.
    Task:  <GOAL-ID>, criteria <n-m>: <the part this commit covers>.
    Done:  <what changed and why, in one to three lines>.

    Refs: <GOAL-ID>
    Standards: AGENTS.md rev. <date>
    AI-Agent: <agent and model, or "none">
    Reviewed-by: <name>
    ```

=== "Pull request"

    ```markdown
    ## What and why
    <One or two sentences; link the goal, the criteria and the issue.>

    ## How to review
    - <Where to start reading.>
    - <The risky part and the test that covers it.>

    ## Evidence
    - [ ] `flutter analyze`: <real result>
    - [ ] `flutter test`: <real summary line>
    - [ ] Ran on <device>: <screenshot>
    - Not verified: <what and why>

    ## Documentation
    - <ARCHITECTURE.md / ADR / NOTES.md / AGENTS.md changes, or "none needed, because…">

    ## AI assistance
    <Agent and model. What it did, and what you changed or rewrote.>

    ## Standards
    AGENTS.md rev. <date> · <commit convention>
    ```

---

## 8. Where You Use This in the Course

| When | Which stages | What you do |
|---|---|---|
| **Lecture 3** | the whole loop, small | specify → plan → implement → review the diff → verify |
| **Lecture 4** | 3, 4, 6, 7 | `ACCEPTANCE.md` and `AGENTS.md`, plan first, diff review, analyzer versus tests |
| **Lab 4, Part 3** | 3 to 7 | your first delegated task, with criteria you wrote before the agent saw the task |
| **Team project** | all ten | `ARCHITECTURE.md`, decision records and `NOTES.md` from the first sprint; features through pull requests, gates in CI, reviews by teammates |

---

## Quick Quiz

<quiz>
What does the harness add to a language model?

- [ ] A larger context window
- [x] Tools, the loop that uses them, instructions and standards, so the model can act and see the results
- [ ] A better model
- [ ] Automatic correctness
</quiz>

<quiz>
Why must the agent read `ARCHITECTURE.md`, the decision records and `NOTES.md` before it plans?

- [ ] Because agents refuse to plan without them
- [x] It starts every session without memory of the project; without these documents it guesses the architecture and earlier decisions, and the guesses look just as convincing as the facts
- [ ] To make the context window as full as possible
- [ ] They replace the acceptance criteria
</quiz>

<quiz>
A plan proposes `lib/services/stats_service.dart`, but the project has no `services` layer. What is the best response?

- [ ] Approve it: the agent probably knows a better structure
- [x] Ask which documents the plan is based on, point it to `ARCHITECTURE.md`, and ask for a plan that fits, or decide on purpose to add the layer and record that decision
- [ ] Let it implement first and review the code later
- [ ] Delete `ARCHITECTURE.md` so the plan no longer contradicts it
</quiz>

<quiz>
The quality gate passes: `flutter analyze` reports no issues and the formatter is happy. What do you know?

- [ ] The feature meets its acceptance criteria
- [x] The code is well-formed and consistent; whether it does what was asked still needs tests and a run
- [ ] There are no security problems
- [ ] The pull request can be merged
</quiz>

<quiz>
When should `ARCHITECTURE.md`, the decision records and `NOTES.md` be updated for a feature?

- [ ] At the end of the semester
- [ ] Only when the teacher asks
- [x] In the same pull request as the code, so reviewers check them together and the next plan reads the current state
- [ ] Never: the code is the documentation
</quiz>

<quiz>
What belongs in a pull request's Evidence section?

- [ ] The agent's statement that all tests pass
- [x] Real results you saw, plus what you did not verify
- [ ] The full chat transcript
- [ ] Nothing; the reviewer will run the tests
</quiz>

<quiz>
The plan's question about the first day of the week was answered in a chat that is now closed, and no decision record exists. What has been lost?

- [ ] Nothing, the code shows the answer
- [x] The reason: the trail from the code back to the decision is broken, so nobody can tell a decision from a guess
- [ ] The test results
- [ ] The commit
</quiz>

---

## Sources

- AGENTS.md, an open format for guiding coding agents: [agents.md](https://agents.md/)
- GitHub Docs, *About customizing GitHub Copilot responses* (custom instructions, `AGENTS.md`): [docs.github.com](https://docs.github.com/en/copilot/concepts/prompting-and-context/custom-instructions)
- GitHub Changelog, *Copilot coding agent now supports AGENTS.md custom instructions* (28 August 2025): [github.blog](https://github.blog/changelog/2025-08-28-copilot-coding-agent-now-supports-agents-md-custom-instructions)
- Claude Code, *Manage Claude's memory* (`CLAUDE.md`): [code.claude.com](https://code.claude.com/docs/en/memory)
- Model Context Protocol: [modelcontextprotocol.io](https://modelcontextprotocol.io/)
- Michael Nygard, *Documenting Architecture Decisions* (2011): [cognitect.com](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- Architectural Decision Records, templates and tools: [adr.github.io](https://adr.github.io/)
- Write the Docs, *Docs as Code*: [writethedocs.org](https://www.writethedocs.org/guide/docs-as-code/)
- Flutter, *Testing Flutter apps* (unit, widget and integration tests): [docs.flutter.dev](https://docs.flutter.dev/testing/overview)
- Flutter API, `matchesGoldenFile`: [api.flutter.dev](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
- Dart, `dart analyze`: [dart.dev](https://dart.dev/tools/dart-analyze)
- OSV-Scanner, *Supported languages and lockfiles*: [google.github.io/osv-scanner](https://google.github.io/osv-scanner/supported-languages-and-lockfiles)
- git-secrets: [github.com/awslabs/git-secrets](https://github.com/awslabs/git-secrets)
- GitHub Docs, *About pull request reviews*: [docs.github.com](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews)
- Conventional Commits 1.0.0: [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/)
- Git, `git interpret-trailers`: [git-scm.com](https://git-scm.com/docs/git-interpret-trailers)
