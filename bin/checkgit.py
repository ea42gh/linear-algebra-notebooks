#!/usr/bin/env python3
"""Print git status for dirty repositories."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def git(repo: Path, *args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["git", "-C", str(repo), *args],
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )


def main(argv: list[str]) -> int:
    root = Path.cwd()
    repos = argv or ["."]
    missing: list[Path] = []
    failures: list[tuple[Path, str]] = []

    for repo_arg in repos:
        repo = (root / repo_arg).resolve()
        if not repo.exists():
            missing.append(repo)
            continue

        porcelain = git(repo, "status", "--porcelain")
        if porcelain.returncode != 0:
            failures.append((repo, porcelain.stderr.strip() or porcelain.stdout.strip()))
            continue
        if not porcelain.stdout.strip():
            continue

        print(f"# ============================================= {repo.name}")
        status = git(repo, "status", "--short", "--branch")
        if status.stdout:
            print(status.stdout.rstrip())
        if status.returncode != 0:
            failures.append((repo, status.stderr.strip() or status.stdout.strip()))

    for repo in missing:
        print(f"# WARNING missing repository: {repo}", file=sys.stderr)

    for repo, message in failures:
        print(f"# ERROR checking repository: {repo}", file=sys.stderr)
        if message:
            print(message, file=sys.stderr)

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
