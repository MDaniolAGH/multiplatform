"""
MkDocs hook: keep glossary tooltips where they make sense.

The glossary (includes/abbreviations.md) is appended to every page, and the
abbr extension then marks every matching word. This hook removes a tooltip
(keeping the word) when:

- it sits inside a link or a heading;
- the word is part of a longer token such as a domain, a path or a hyphenated
  name ("dart.dev", "api.flutter.dev", "git-secrets", "lib/api/");
- the page uses the word in another sense and says so with an HTML comment in
  its Markdown, for example:

      <!-- glossary-skip: record, provider -->
"""

import re

ABBR = r'<abbr title="[^"]*">([^<]*)</abbr>'
ABBR_RE = re.compile(ABBR)
SKIP_COMMENT = re.compile(r"<!--\s*glossary-skip:\s*(.*?)\s*-->", re.IGNORECASE)
CONTAINERS = re.compile(r"(<a\b[^>]*>.*?</a>|<h[1-6]\b[^>]*>.*?</h[1-6]>)", re.DOTALL)
GLUED_AFTER = re.compile(ABBR + r"(?=[-./]\w)")
GLUED_BEFORE = re.compile(r"(?<=[\w][./-])" + ABBR)


def on_page_content(html, page, config, files):
    html = CONTAINERS.sub(lambda m: ABBR_RE.sub(r"\1", m.group(0)), html)
    html = GLUED_AFTER.sub(r"\1", html)
    html = GLUED_BEFORE.sub(r"\1", html)

    skip = set()
    for match in SKIP_COMMENT.finditer(page.markdown or ""):
        skip.update(term.strip() for term in match.group(1).split(",") if term.strip())
    if skip:
        html = ABBR_RE.sub(lambda m: m.group(1) if m.group(1) in skip else m.group(0), html)
    return html
