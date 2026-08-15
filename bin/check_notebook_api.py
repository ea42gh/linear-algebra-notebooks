#!/usr/bin/env python3
"""Check notebook code cells for retired LA figure API spellings."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


PATTERNS = {
    "pivot_list": re.compile(r"\bpivot_list\s*="),
    "bg_for_entries": re.compile(r"\bbg_for_entries\s*="),
    "ref_path_list": re.compile(r"\bref_path_list\s*="),
    "comment_list": re.compile(r"\bcomment_list\s*="),
    "formater": re.compile(r"\bformater\s*="),
    "Nrhs": re.compile(r"\bNrhs\b"),
    "show_ge_final": re.compile(r"\bshow_ge_final\b"),
    "tmp_dir": re.compile(r"\btmp_dir\s*="),
    "keep_file": re.compile(r"\bkeep_file\s*="),
    "sigma2_digits": re.compile(r"\bsigma2_digits\s*="),
    "preamble": re.compile(r"\bpreamble\s*="),
    "extension": re.compile(r"\bextension\s*="),
    "LAFigureSpecs_render_import": re.compile(
        r"\bfrom\s+LAFigureSpecs\s+import\s+[^\n]*\brender_(?:ge|qr|eig|svd)_(?:svg|tex)\b"
    ),
    "LAFigureSpecs_render_attr": re.compile(
        r"\b(?:lf|LAFigureSpecs)\.render_(?:ge|qr|eig|svd)_(?:svg|tex)\b"
    ),
}

DEFAULT_EXCLUDES = {
    Path("notebooks") / "Matrix_images.ipynb",
}


def _source_text(source: object) -> str:
    if isinstance(source, list):
        return "".join(str(part) for part in source)
    return str(source or "")


def _iter_notebooks(paths: list[Path]) -> list[Path]:
    notebooks: list[Path] = []
    for path in paths:
        if path.is_file() and path.suffix == ".ipynb":
            notebooks.append(path)
        elif path.is_dir():
            notebooks.extend(path.rglob("*.ipynb"))
    return sorted(set(notebooks))


def main(argv: list[str]) -> int:
    paths = [Path(arg) for arg in argv] if argv else [Path("notebooks")]
    notebooks = _iter_notebooks(paths)
    failures: list[str] = []

    for notebook in notebooks:
        if notebook in DEFAULT_EXCLUDES:
            continue
        data = json.loads(notebook.read_text(encoding="utf-8"))
        for cell_index, cell in enumerate(data.get("cells", []), start=1):
            if cell.get("cell_type") != "code":
                continue
            source = _source_text(cell.get("source"))
            for name, pattern in PATTERNS.items():
                if pattern.search(source):
                    failures.append(f"{notebook}:{cell_index}: stale API spelling `{name}`")

    if failures:
        print("Notebook API check failed:", file=sys.stderr)
        for failure in failures:
            print(f"  {failure}", file=sys.stderr)
        return 1

    print(f"Notebook API check passed for {len(notebooks)} notebooks.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
