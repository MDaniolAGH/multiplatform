"""
MkDocs hook: add a content hash to the course's own CSS and JavaScript links.

GitHub Pages lets browsers cache files for 10 minutes, so after an update a
reader could get the new page with the old script. Every link to a file under
assets/stylesheets/ or assets/javascripts/ gets `?v=<hash of the file>`, which
changes only when the file changes.
"""

import hashlib
import re
from pathlib import Path

ASSET = re.compile(r'(?P<attr>href|src)="(?P<url>[^"?#]*?(?P<path>assets/(?:stylesheets|javascripts)/[^"?#]+\.(?:css|js)))"')

_hashes = {}


def _hash(docs_dir, path):
    if path not in _hashes:
        file = Path(docs_dir) / path
        _hashes[path] = hashlib.sha256(file.read_bytes()).hexdigest()[:10] if file.is_file() else None
    return _hashes[path]


def on_pre_build(config):
    _hashes.clear()


def on_post_page(output, page, config):
    def stamp(match):
        digest = _hash(config["docs_dir"], match.group("path"))
        if not digest:
            return match.group(0)
        return '{}="{}?v={}"'.format(match.group("attr"), match.group("url"), digest)

    return ASSET.sub(stamp, output)
