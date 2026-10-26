"""
MkDocs hook: strip instructor-only presenter notes from published pages.

Lecture notes keep `> PRESENTER NOTE: ...` blockquotes in the source for the
instructor. This hook removes those blockquotes (and the intro blockquote that
explains them) before rendering, so they never reach the public website.
"""

import re

# A blockquote whose first line starts one of these is removed in full
NOTE_START = re.compile(r"^>\s*(PRESENTER NOTE:|Lines marked with `> PRESENTER NOTE:`)")
PRESENTER_CUES = re.compile(r"(?<=^\*\*Format:\*\*)(.*?) with presenter cues")


def on_page_markdown(markdown, page, config, files):
    out = []
    skipping = False
    for line in markdown.splitlines(keepends=True):
        if skipping:
            if line.startswith(">"):
                continue
            skipping = False
        if NOTE_START.match(line):
            skipping = True
            continue
        out.append(PRESENTER_CUES.sub(r"\1", line))
    return "".join(out)
