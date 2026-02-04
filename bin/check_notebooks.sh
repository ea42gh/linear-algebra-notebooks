#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <notebook_dir> [timeout_seconds]"
  exit 1
fi

NB_DIR="$1"
TIMEOUT="${2:-600}"

if ! command -v jupyter >/dev/null 2>&1; then
  echo "ERROR: jupyter not found in PATH"
  exit 1
fi

if [[ ! -d "$NB_DIR" ]]; then
  echo "ERROR: directory not found: $NB_DIR"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
FAILED=()

# Find notebooks (non-recursive). Add -maxdepth 1 if you want only top-level.
mapfile -t NOTEBOOKS < <(find "$NB_DIR" -type f -name "*.ipynb" | sort)

for nb in "${NOTEBOOKS[@]}"; do
  out="$TMP_DIR/$(basename "$nb")"
  echo -n "Running: $nb"
  if ! jupyter nbconvert --to notebook --execute "$nb" \
        --ExecutePreprocessor.timeout="$TIMEOUT" \
        --output "$out" \
        --log-level WARN >/dev/null 2>&1; then
    printf "  \033[31mFAIL\033[0m\n"
    FAILED+=("$nb")
  else
    echo
  fi
done

echo
if [[ ${#FAILED[@]} -eq 0 ]]; then
  echo "All notebooks passed."
else
  echo "Notebooks with failing cells:"
  printf '%s\n' "${FAILED[@]}"
fi
