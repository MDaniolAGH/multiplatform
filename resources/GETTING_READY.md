# Getting Ready

<div class="lab-meta" markdown>
<div class="lab-meta__row"><span class="lab-meta__label">Course</span> Multiplatform Mobile Software Engineering in Practice</div>
<div class="lab-meta__row"><span class="lab-meta__label">Duration</span> ~2-3 hours (self-paced, at home)</div>
<div class="lab-meta__row"><span class="lab-meta__label">Prerequisites</span> Basic programming experience in any language</div>
</div>

<div class="grid cards" markdown>

- :material-target:{ .lg .middle } **Learning Objectives**

    ---

    By the end of this prep guide, you will be able to:

    - [ ] Assess your skill level against course prerequisites
    - [ ] Install and configure all required development tools
    - [ ] Verify your setup with `flutter doctor`
    - [ ] Understand how the course works and what to expect in the first meeting

- :material-clock-outline:{ .lg .middle } **Time Estimate**

    ---

    | Section | Duration |
    |---------|----------|
    | Course overview | ~15 min |
    | Self-assessment & remediation | ~30 min – 6 hours |
    | Technical setup (Steps 1–9) | ~1–2 hours |
    | Verification & checklist | ~10 min |

</div>

!!! info "Read this before the first meeting"
    This page is your starting point. It explains how the course works, helps you assess your skills, shows you exactly how to set up your tools, and tells you what to expect on day one. ==**Complete Steps 1–8 before Lab 1.**== Steps 9 and 10 can wait: Python is needed later in the course, and the coding-agent account before Lab 4.

!!! abstract "TL;DR"
    Install Git, Flutter, Android Studio, and VS Code. Set up GitHub with SSH keys. Run `flutter doctor` until everything is green. Assess your programming skills — if you can write a Python class and navigate a terminal, you're ready.

!!! example "Think of it like... packing for a road trip"
    This prep guide is like **packing your car before a road trip** — you need the right gear (tools), a working GPS (GitHub), and enough fuel (prerequisite skills). Skipping this step means pulling over on day one to buy a map.

---

## How This Course Works

### The Big Picture

The course has **13 meetings**. In the first labs you build individual foundations: the terminal and Git, the Dart language, and your first Flutter screen, each with a short individual assignment (A1–A3). After that you form a team of 3–4 students and build a real mobile app together, while the labs and lectures keep adding what you need: interaction and state, data and networking, testing and release.

~~This is a lecture-heavy theory course~~ — it's the opposite. You'll write code from day one, and the lectures *follow* the labs to clarify what you experienced hands-on.

### Lab Before Lecture

This course flips the traditional order: ==**lab comes first, lecture comes second**== in each meeting. You'll wrestle with the material hands-on, then the lecture clarifies and deepens what you experienced. This is intentional — struggling first makes the explanations stick.

### The First Two Meetings

| Meeting | Lab (first) | Lecture (second) |
|---------|-------------|------------------|
| **Before the course** | **You are here.** Set up tools, assess skills | — |
| **1** | Terminal, Git and GitHub; assignment A1 | Mobile systems and multiplatform development |
| **2** | Dart fundamentals; assignment A2 | Dart, widgets and layout in Flutter |

Later meetings are published on the course website as the course progresses.

---

### Self-Check: Course Structure

Before continuing, make sure you understand:

- [ ] Each meeting has a lab first and a lecture second
- [ ] Labs 1–3 each end with a short individual assignment (A1–A3)
- [ ] Later you form a team and build a real mobile app

---

## What Happens in Meeting 1

So you know exactly what to expect on day one:

1. **Lab 1 (first):** You'll open a terminal, create directories, initialize a git repository, make commits, and push to GitHub. The lab workbook guides you step by step — no prior experience needed.
2. **Lecture 1 (second):** What makes mobile systems different, how Android and iOS differ, and which approaches exist for building one app for several platforms, including a first look at Flutter.

**What you need ready:** A working terminal, git installed, a GitHub account with SSH keys set up (see the setup checklist below).

~~You need Flutter experience for the first meeting~~ — you don't. Lab 1 is entirely terminal and Git. You meet Dart in Lab 2 and write your first Flutter screen in Lab 3.

---

## Self-Assessment Checklist

Work through these three tiers honestly. Nobody expects you to check every box before day one — but knowing where you stand helps you prepare.

!!! example "Think of it like... a health check-up"
    This self-assessment is like a **pre-surgery health check** — the doctor doesn't expect you to be a triathlete, but they need to know your baseline so they can plan accordingly. Be honest; it helps *you*.

### Tier 1: Must-Have (prerequisite skills)

If you cannot answer "yes" to most of these, dedicate time before the course begins:

- [ ] **Can you write a Python class** with `__init__`, methods, and inheritance?
- [ ] **Do you understand what a function return type means?** (e.g., a function that returns an integer vs. one that returns nothing)
- [ ] **Can you open a terminal and navigate directories?** (`cd`, `ls`, `mkdir`, `pwd`)
- [ ] **Do you understand variables, loops, and conditionals** in at least one language?
- [ ] **Can you read and write simple data structures?** (lists, dictionaries/maps)

### Tier 2: Strongly Recommended

These topics come up from Lab 2 onward. Prior exposure makes a big difference:

- [ ] **Have you used `async`/`await`** in any language? (Python, JavaScript, Dart, etc.)
- [ ] **Do you know what a generic type like `List<String>` means?**
- [ ] **Can you explain what an API endpoint is?** (e.g., `GET /api/patients` returns a list of patients)
- [ ] **Have you written code with error/exception handling?** (`try`/`catch` or equivalent)
- [ ] **Do you understand the difference between a class and an instance?**

### Tier 3: Helpful but Taught in the Course

Don't worry if these are new — we cover them explicitly:

- [ ] Have you used git before?
- [ ] Have you built a mobile app (any platform)?
- [ ] Do you know what Flutter or Dart is?
- [ ] Have you used a state management pattern (Provider, Redux, MobX, etc.)?
- [ ] Have you worked in an agile/scrum team?

**How to read your results:**

- **All Tier 1 checked:** You're ready. Tier 2 gaps will slow you down a bit in Lab 2 but won't stop you.
- **Most Tier 1 checked, some gaps:** Spend a few hours on the remediation links below. You'll be fine.
- **Several Tier 1 unchecked:** Invest serious time (10-15 hours) before the semester. The course moves fast from Lab 2.
- ==**Tier 3 all unchecked:** That's totally normal and expected. These are taught from scratch.==

!!! success "Checkpoint: Self-Assessment"
    You've identified your skill tier. If you're all-green on Tier 1, skip ahead
    to the [Technical Setup Checklist](#technical-setup-checklist). If you have
    gaps, the remediation section below has targeted resources for each skill.

---

## Skill Gap Remediation

For each Tier 1 and Tier 2 gap, here is **one recommended free resource**. You don't need to complete entire courses — focus on the specific skill you're missing.

??? protip "Pro tip"
    Don't try to learn everything. Pick the **one or two** Tier 1 skills you're weakest on and spend focused time there. Diminishing returns hit fast — 3 hours on your biggest gap beats 10 hours spread thin.

### Tier 1 Gaps

| Skill | Resource | Time |
|-------|----------|------|
| Function return types & signatures | [Real Python — Defining Your Own Python Function](https://realpython.com/defining-your-own-python-function/#argument-passing) | ~1 hour |
| Python OOP (classes, inheritance) | [Real Python — Object-Oriented Programming in Python](https://realpython.com/python3-object-oriented-programming/) | ~3 hours |
| Terminal / command line basics | [MDN — Command line crash course](https://developer.mozilla.org/en-US/docs/Learn_web_development/Getting_started/Environment_setup/Command_line) | ~2 hours |
| Variables, loops, conditionals | [Codecademy — Learn Python 3 (free tier)](https://www.codecademy.com/learn/learn-python-3) | ~4 hours |
| Data structures (lists, maps) | [Real Python — Lists and Tuples](https://realpython.com/python-lists-tuples/) + [Dictionaries](https://realpython.com/python-dicts/) | ~1 hour |

### Tier 2 Gaps

| Skill | Resource | Time |
|-------|----------|------|
| Async / `await` | [Real Python — Async IO in Python](https://realpython.com/async-io-python/) (concepts transfer to Dart) | ~2 hours |
| Generic types (`List<String>`) | [Oracle — Why Use Generics?](https://docs.oracle.com/javase/tutorial/java/generics/why.html) (concept applies to Dart) | ~1 hour |
| REST APIs | [freeCodeCamp — What is a REST API?](https://www.freecodecamp.org/news/what-is-a-rest-api/) | ~1 hour |
| Exception handling | [Real Python — Python Exceptions](https://realpython.com/python-exceptions/) | ~30 min |
| Classes vs instances | Covered in the Python OOP link above | — |

!!! tip "Time investment"
    If you have all Tier 1 skills, you're ready. Filling 2-3 Tier 2 gaps takes roughly **4-6 hours** of self-study. That investment pays off massively from Lab 2 onward.

---

## What the Course Teaches (Don't Pre-Study)

These topics are covered step-by-step in the course. Pre-studying them is unnecessary and may cause confusion if you learn a different approach:

- **Git & GitHub** — Lab 1 starts from zero with the terminal and Git
- **Dart programming language** — Lab 2 and Lecture 2 teach Dart from scratch (assuming you know OOP basics)
- **Flutter framework** — Lecture 1 introduces it; from Lab 3 you build with it
- **Working with coding agents** — taught step by step, before you use one in Lab 4
- **Interaction and state management** — later lectures, with guided exercises
- **REST API integration** — later in the course, with hands-on labs
- **Project management / Scrum** — taught when the team project starts

~~You should watch Flutter tutorials on YouTube before the course~~ — don't. The course introduces Flutter with a specific progression. Jumping ahead often means learning patterns we deliberately avoid (like `setState()` for shared state).

If you already know some of these, great — you'll move faster through those parts and can help your teammates.

---

## For CMS / Web Developers

If your background is in content management systems (WordPress, Strapi, headless CMS) or web development, here's what transfers and what's new.

### What Transfers Directly

| You Already Know | Course Equivalent |
|-----------------|-------------------|
| Templates / components | Flutter widgets (same idea — composable UI pieces) |
| REST API calls from a frontend | API integration later in the course (same concept, different syntax) |
| JSON data structures | Dart models and serialization |
| Admin panels / CRUD interfaces | Building screens with forms, lists, and detail views |
| Deployment workflows | CI/CD concepts (git-based, similar to Netlify/Vercel) |

### What's New

| New Concept | Why It Matters |
|-------------|---------------|
| **Strongly typed language (Dart)** | Unlike PHP/JavaScript, Dart requires explicit types. This catches bugs early but feels strict at first. |
| **Compiled mobile app** | Unlike a web page, your app compiles to native code. Changes require rebuilding (though Flutter's hot reload is fast). |
| **State management** | In a CMS, the server holds the state. In a mobile app, you manage state locally on the device. This is the biggest conceptual shift. |
| **Offline-first thinking** | Mobile apps must work without internet. CMS apps usually assume connectivity. |
| **Object-oriented architecture** | The course uses OOP patterns extensively. If you mainly write procedural PHP or JS, review the OOP section above. |

!!! note "You belong here"
    Non-traditional backgrounds bring valuable perspective — especially when building apps for specific domains (healthcare, education, finance), where understanding end-users matters as much as writing code. Your experience with content architecture, user flows, and API integration is directly applicable.

---

## Technical Setup Checklist

Complete **all** of this before the first lab session to avoid losing time on installation issues.

!!! warning "Disk space required"
    The Flutter SDK (~1.5 GB), Android Studio (~1 GB), and Android SDK + emulator images (~5-7 GB) require about **10 GB** of free disk space. macOS users who also install Xcode need an additional ~12 GB (**~22 GB total**). Make sure you have enough space before starting.

!!! info "Terminal note"
    All commands in this course use **bash** syntax. On **macOS** and **Linux**, use the built-in Terminal app. On **Windows**, use **Git Bash** (installed automatically with Git for Windows). Most commands are identical across all three operating systems — we use tabs only where they genuinely differ.

**Which terminal should I open?**

| Operating System | What to open |
|---|---|
| **macOS** | Open **Terminal** (press ++cmd+space++, type "Terminal", hit ++enter++) |
| **Windows** | Open **Git Bash** (installed with Git for Windows — see Step 1). If you haven't installed Git yet, do Step 1 first (it's a regular download, no terminal needed), then come back here. |
| **Linux** | Open your default **Terminal** emulator (usually ++ctrl+alt+t++) |

You should see a blinking cursor waiting for input — something like `username@computer ~ %` or `username@computer:~$`. This is the **prompt**, and it means the terminal is ready for your commands.

Here's an overview of the setup steps and how they connect:

```mermaid
graph TD
    S1["Step 1: Install Git"] --> S2["Step 2: GitHub + SSH Key"]
    S2 --> S8["Step 8: Clone Course Repo"]
    S1 --> S3["Step 3: Flutter SDK"]
    S3 --> S4["Step 4: Android Studio"]
    S4 --> S5["Step 5: VS Code"]
    S5 --> S7["Step 7: flutter doctor"]
    S4 --> S6["Step 6: Xcode<br/><i>(macOS only)</i>"]
    S6 --> S7
    S7 --> READY["All green? You're ready for Lab 1!"]
    S8 --> READY
    READY -.-> S9["Step 9: Python<br/><i>(can wait)</i>"]
    READY -.-> S10["Step 10: Coding-agent account<br/><i>(before Lab 4)</i>"]
    style S7 fill:#22A06B26,stroke:#22A06B
    style READY fill:#22A06B26,stroke:#22A06B,stroke-width:3px
    style S6 fill:#94A3B826,stroke:#94A3B8
    style S9 fill:#94A3B826,stroke:#94A3B8
    style S10 fill:#94A3B826,stroke:#94A3B8
```

### Step 1: Install Git

=== "macOS"

    ```bash
    xcode-select --install
    ```
    A system dialog will appear asking to install — click **Install** and wait (may take several minutes). This installs git along with the Xcode Command Line Tools.

=== "Linux"

    ```bash
    # Ubuntu / Debian
    sudo apt install git

    # Fedora
    sudo dnf install git
    ```
    `sudo` runs the command with administrator privileges — it will ask for your password. When you type the password, nothing will appear on screen (no dots, no stars). That's normal — just type it and press ++enter++.

=== "Windows"

    Download and install [Git for Windows](https://git-scm.com/download/win). The installer shows many option screens — **accept the defaults** for all of them. This also installs **Git Bash**, which you will use as your terminal throughout the course.

Verify:
```bash
git --version
```

Configure your identity and default branch name (replace the placeholder values with your real name and email):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@university.edu"
git config --global init.defaultBranch main
```
The last line sets `main` as the name for the default branch in new repositories. Don't worry about what that means yet — branches are covered in the labs.

!!! success "Checkpoint: Git"
    Run `git --version` — you should see a version number (e.g., `git version 2.44.0`).
    If you see `command not found`, revisit the installation step for your OS.

### Step 2: Create a GitHub Account and SSH Key

#### 2.1 Create a GitHub account

If you don't already have one:

1. Go to [github.com/join](https://github.com/join)
2. Use your student email — this gives you access to the GitHub Student Developer Pack
3. Choose a professional username (you may use this on your CV someday)

#### 2.2 Generate an SSH key

An SSH key is a pair of files on your computer that lets you prove your identity to GitHub without typing a password every time. You'll create the key pair now and then give GitHub the public half.

Open your terminal and run (replace the email with the one you used for GitHub):

```bash
ssh-keygen -t ed25519 -C "your.email@university.edu"
```

When prompted:

- **File location** — press ++enter++ to accept the default (`~/.ssh/id_ed25519`). The `~` means your home folder (e.g., `/Users/you` on macOS, `C:\Users\you` on Windows).
- **Passphrase** — press ++enter++ twice for no passphrase (or set one if you prefer)

You should see output like:

```
Generating public/private ed25519 key pair.
Your identification has been saved in /home/you/.ssh/id_ed25519
Your public key has been saved in /home/you/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:abc123... your.email@university.edu
```

#### 2.3 Copy your public key

=== "macOS"

    ```bash
    pbcopy < ~/.ssh/id_ed25519.pub
    ```

=== "Linux"

    ```bash
    xclip -selection clipboard < ~/.ssh/id_ed25519.pub
    ```
    If `xclip` is not installed: `sudo apt install xclip`

=== "Windows (Git Bash)"

    ```bash
    clip < ~/.ssh/id_ed25519.pub
    ```

If none of the above work, you can always open the file manually and copy its contents:

```bash
cat ~/.ssh/id_ed25519.pub
```

Select the entire output (starts with `ssh-ed25519`) and copy it (++cmd+c++ on macOS, right-click → **Copy** in Git Bash).

#### 2.4 Add the key to GitHub

1. Go to [github.com](https://github.com) → click your profile picture → **Settings**
2. In the left sidebar, click **SSH and GPG keys**
3. Click **New SSH key**
4. **Title**: enter something descriptive (e.g., "My laptop")
5. **Key**: paste the public key you just copied
6. Click **Add SSH key**

#### 2.5 Test the connection

```bash
ssh -T git@github.com
```

If this is your first time connecting, you'll see:

```
The authenticity of host 'github.com (...)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wv...
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type `yes` and press ++enter++. This is normal — your computer is verifying GitHub's identity for the first time.

You should then see:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

That means it worked.

!!! warning "Why SSH matters"
    GitHub no longer accepts passwords for git operations — without SSH keys, `git push` will fail with an authentication error. Lab 1 assumes SSH is configured. **Do this now.**

!!! warning "Common mistake"
    Copying the SSH key with extra spaces or newlines. Use the copy commands above to copy the key cleanly. If `ssh -T git@github.com` returns `Permission denied`, the key wasn't added correctly — go back to step 2.4 and re-check.

!!! tip "Stuck? Don't worry"
    If you can't get SSH working at home, don't let it block you. **Lab 1** walks through this step by step with instructor help. Move on to Steps 3–8 and come back to this during class.

!!! success "Checkpoint: GitHub + SSH"
    Run `ssh -T git@github.com` — you should see `Hi <username>! You've successfully authenticated`.
    If you see `Permission denied (publickey)`, re-do steps 2.2–2.4 above.

### Step 3: Install Flutter SDK

Follow the official guide for your platform: [Install Flutter](https://docs.flutter.dev/get-started/install). When the page asks for your target platform, choose **Android** — it works on all operating systems and is what we use in this course.

After installation, run:
```bash
flutter doctor
```

Resolve any issues it reports. Target: all checks pass (minor warnings for platforms you won't use are fine).

!!! warning "Add Flutter to your PATH permanently"
    If you only set the PATH for one terminal session, you'll have to re-export it every time you open a new terminal.

    - **macOS / Linux:** Add the `export PATH` line to your `~/.zshrc` (macOS) or `~/.bashrc` (Linux), then **restart your terminal** or run `source ~/.zshrc` (or `source ~/.bashrc`) for the change to take effect.
    - **Windows:** Add the Flutter `bin` folder to your system PATH via **Settings → System → About → Advanced system settings → Environment Variables**. The [official Flutter guide](https://docs.flutter.dev/install/add-to-path) walks through this for each operating system. **Restart Git Bash** afterwards.

    Without this, `flutter` commands won't work after you close the terminal.

### Step 4: Install Android Studio

Download from [developer.android.com/studio](https://developer.android.com/studio).

Even if you prefer VS Code as your editor, you need Android Studio because it provides:
- The Android SDK
- The Android emulator (AVD Manager)

**Set up an emulator:**

1. Open Android Studio → More Actions → Virtual Device Manager
2. Create a new device (e.g., Pixel 7, API 34 — the API number is the Android version; pick the highest available)
3. Launch it once to verify it works

!!! warning "Common mistake"
    Skipping the emulator setup. You *will* need an emulator from Lab 3 onward, and downloading the system image (~1 GB) during class wastes lab time. Set it up now and verify it boots.

### Step 5: Install VS Code (Recommended IDE)

Download from [code.visualstudio.com](https://code.visualstudio.com/).

Install these extensions (search in the Extensions panel):

- **Flutter** (by Dart Code) — includes the Dart extension automatically
- **Dart** (if not auto-installed)

??? challenge "Stretch Goal: Power-user VS Code setup"
    Install these optional extensions for a smoother workflow later in the course:

    - **GitLens** — enhanced git blame, history, and diff inline
    - **Error Lens** — shows errors and warnings inline next to the code
    - **Material Icon Theme** — better file icons for Flutter projects
    - **Pubspec Assist** — search and add Dart packages without leaving the editor

### Step 6: macOS Only — Install Xcode

!!! note "Windows and Linux users"
    Skip this step. iOS development requires macOS. You will use the Android emulator instead, which works on all platforms.

If you're on macOS and want to test on iOS:

1. Install Xcode from the Mac App Store
2. Open Xcode once to accept the license agreement
3. Point the command-line tools to the full Xcode installation (`sudo` will ask for your Mac password — nothing appears on screen as you type, that's normal):
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   ```
4. Open the iOS Simulator: `open -a Simulator`

### Step 7: Final Verification

Run this command to confirm Flutter is set up correctly:

```bash
flutter doctor
```

You should see output similar to:

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain
[✓] Xcode (or [!] if not on macOS — that's fine)
[✓] Chrome
[✓] Android Studio
[✓] VS Code
[✓] Connected device (or set up an emulator)
```

| Symbol | Meaning |
|--------|---------|
| `[✓]` | Fully configured and working |
| `[!]` | Partially working — a minor issue or optional component is missing (often safe to ignore) |
| `[✗]` | Not working — needs to be fixed before you can develop for that platform |

!!! warning "Don't skip this"
    Every semester, students lose 30-60 minutes of the first lab session debugging installation issues. Doing this at home means you can start coding from minute one.

!!! success "Checkpoint: Flutter Doctor"
    All checks show `[✓]` (or only minor warnings for platforms you don't need).
    If you have `[✗]` errors, check the troubleshooting section below before asking
    for help.

### Step 8: Clone the Course Materials Repository

All lab exercises, starter projects, and templates are distributed through a single **course repository** on GitHub. Clone it now so you have everything ready:

```bash
cd ~
git clone https://github.com/MDaniolAGH/multiplatform.git course-materials
```

The folders you will use:

```
course-materials/
├── labs/          # exercises and assignment templates, one folder per lab
├── lectures/      # lecture notes
└── checkpoints/   # the finished Mood Tracker at each stage of the course
```

Each lab's instructions tell you exactly which files to use. You do **not** need to read ahead — just make sure the repository is cloned, and run `git pull` before each lab.

### Step 9: Verify Python (needed later in the course)

Later labs use Python to run a small backend API. You can do this step now or later. Verify that Python is installed:

```bash
python3 --version
```

You should see `Python 3.8` or higher. If not:

=== "macOS"

    Python 3 comes pre-installed on recent macOS versions (or gets installed with the Xcode Command Line Tools from Step 1). If still missing, install via Homebrew (`brew install python3`) or download from [python.org](https://www.python.org/downloads/).

=== "Linux"

    ```bash
    sudo apt install python3 python3-venv python3-pip
    ```

=== "Windows"

    Download from [python.org](https://www.python.org/downloads/). During installation, check **"Add Python to PATH"**.

    !!! note "Windows note"
        The `python3` command may not work on Windows. Try `python --version` or `py --version` instead.

### Step 10: Create a Coding-Agent Account (before Lab 4)

From Lab 4 onwards you will also work with a coding agent. The course supports two; prepare one of them:

- **GitHub Copilot:** free for students verified through [GitHub Education](https://education.github.com). Apply with your student email; verification can take **several days**, so do it early.
- **Mistral Vibe:** create an account at [mistral.ai](https://mistral.ai). Its free plan includes a limited number of coding sessions.

---

### Self-Check: Technical Setup

Before continuing, verify every tool:

- [ ] `git --version` prints a version number
- [ ] `ssh -T git@github.com` prints `Hi <username>!`
- [ ] `flutter doctor` shows all green checks (or only platform-irrelevant warnings)
- [ ] Android emulator launches and boots to the home screen
- [ ] VS Code opens and the Flutter extension is installed
- [ ] *(Can wait)* `python3 --version` prints a version number (on Windows, try `python --version` or `py --version`)

---

### Common `flutter doctor` Issues

If `flutter doctor` reports problems, check these common fixes before asking for help:

??? question "Android SDK licenses not accepted"
    Run `flutter doctor --android-licenses` and accept all licenses by typing `y` at each prompt.

??? question "Android SDK not found / `ANDROID_HOME` not set"
    Open Android Studio → Settings → Appearance & Behavior → System Settings → Android SDK. Note the SDK location. Then add it to your shell profile:

    === "macOS / Linux"

        Add to `~/.zshrc` or `~/.bashrc`:
        ```bash
        export ANDROID_HOME=$HOME/Library/Android/sdk   # macOS
        # export ANDROID_HOME=$HOME/Android/Sdk         # Linux
        export PATH=$ANDROID_HOME/platform-tools:$PATH
        ```
        Then run `source ~/.zshrc` (or `~/.bashrc`).

    === "Windows"

        Add `ANDROID_HOME` as a system environment variable pointing to `C:\Users\YourName\AppData\Local\Android\Sdk`. Add `%ANDROID_HOME%\platform-tools` to your PATH.

??? question "Xcode command line tools not installed (macOS)"
    Run `sudo xcode-select --install`. If Xcode is installed but the CLI tools are not detected, run `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`.

??? question "No connected devices"
    Make sure your Android emulator is running (launch from Android Studio → AVD Manager) or your physical device has USB debugging enabled. Run `flutter devices` to see what Flutter detects.

??? question "`flutter` command not found"
    The Flutter SDK is not on your PATH. Follow the [official PATH setup instructions](https://docs.flutter.dev/get-started/install) for your platform.

---

## Frequently Asked Questions

??? question "I've never used a terminal. Will I survive Lab 1?"
    Yes. Lab 1 starts from `cd` and `ls`. It assumes zero terminal experience and walks you through every command. The only prerequisite is having a terminal open and git installed (see setup above).

??? question "I only know Python. Is that enough?"
    Python gives you everything you need for Tier 1. The course teaches Dart from scratch in Lab 2 — if you understand Python OOP (classes, methods, inheritance), you'll pick up Dart quickly because the concepts are the same.

??? question "I'm not a CS student. Is this course too hard?"
    This course is designed for students from diverse backgrounds, including international students from various programs. No computer science degree is required. Labs 1–3 build your foundation step by step. The project work that follows is done in teams, so you can lean on teammates with different strengths. The key is doing this preparation and not falling behind in the first three labs.

??? question "Do I need a Mac for this course?"
    No. Flutter works on macOS, Windows, and Linux. The only thing you can't do without a Mac is test on iOS. Android development works on all platforms, and that's sufficient for the course.

??? question "How much time should I expect to spend outside class?"
    During Labs 1–3: about **2-3 hours per week** on individual assignments. During the team project: about **4-6 hours per week**, depending on your role and sprint goals. Teams that communicate well and plan realistically spend less time than teams that don't.

??? question "What if I'm already experienced with Flutter/mobile dev?"
    Great — you'll move faster through the early labs and can help your teammates. The course still offers value through engineering practice, working with coding agents, project management, and the experience of building a real app in a team.

??? question "I come from a web/CMS background (WordPress, Strapi, etc.). Is that relevant?"
    Very much so. See the "For CMS / Web Developers" section above. Your experience with APIs, content structure, and user flows transfers directly. The main new things are the typed language (Dart) and managing state on the device instead of the server.

---

## Your Checklist — Complete Before Lab 1

Print this or keep it open. Check off each item:

- [ ] Read how the course works — lab first, lecture second
- [ ] Completed the self-assessment — I know which tier I'm at
- [ ] Addressed Tier 1 skill gaps (if any) using the remediation links
- [ ] **Git** installed and configured (`git --version` works)
- [ ] **GitHub account** created with SSH key set up (`ssh -T git@github.com` works)
- [ ] *(Can wait)* **Python 3** installed (`python3 --version` works — on Windows, try `python` or `py`)
- [ ] **Flutter SDK** installed (`flutter doctor` passes)
- [ ] **Android Studio** installed with at least one emulator configured
- [ ] **VS Code** installed with Flutter and Dart extensions
- [ ] **Xcode** installed (macOS only, optional)
- [ ] **Course materials repository** cloned
- [ ] *(Before Lab 4)* Applied for **GitHub Education**, or created a **Mistral** account
- [ ] `flutter doctor` shows all green checks (or only platform warnings I can ignore)

**All done?** You're ready for Lab 1. See you in the lab.

---

## Quick Quiz

<quiz>
What is the order within each meeting?

- [ ] Lecture first, then lab
- [x] Lab first, then lecture
- [ ] Lecture only, no lab
- [ ] Lab only, no lecture
</quiz>

<quiz>
Which tier of the self-assessment covers skills taught from scratch in the course?

- [ ] Tier 1 — Must-Have
- [ ] Tier 2 — Strongly Recommended
- [x] Tier 3 — Helpful but Taught in the Course
- [ ] All tiers are prerequisites
</quiz>

<quiz>
What is the most critical command to run after completing the technical setup?

- [ ] `git status`
- [ ] `python3 --version`
- [x] `flutter doctor`
- [ ] `ssh -T git@github.com`
</quiz>

<quiz>
What do Labs 1–3 each end with?

- [ ] A team presentation
- [x] A short individual assignment (A1–A3)
- [ ] A written exam
- [ ] Nothing; they are optional
</quiz>

---

!!! question "End-of-Prep Reflection"
    Take 2 minutes to reflect before you close this page:

    1. **What is your biggest concern about this course?** Is it the tools, the programming, the teamwork, or something else?
    2. **What is your strongest skill going in?** How might you use it to help your future teammates?
    3. **What is one thing you will do this week to prepare?** (Fill a Tier 1 gap, install Flutter, set up SSH keys?)

    Write your answers somewhere you can revisit later in the semester — you'll be surprised how far you've come.

---

## Questions?

If you have setup issues before the course starts, open a GitHub Issue in the course repository or email the instructor. We'd rather help you before the first meeting than during it.
