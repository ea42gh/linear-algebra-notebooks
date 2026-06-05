#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <notebook_dir> [timeout_seconds] [report_dir]"
  exit 1
fi

NB_DIR="$1"
TIMEOUT="${2:-600}"
REPORT_DIR="${3:-artifacts/notebook-check}"

if ! command -v jupyter >/dev/null 2>&1; then
  echo "ERROR: jupyter not found in PATH"
  exit 1
fi

if [[ ! -d "$NB_DIR" ]]; then
  echo "ERROR: directory not found: $NB_DIR"
  exit 1
fi

mkdir -p "$REPORT_DIR/executed" "$REPORT_DIR/logs"
FAILED=()

mapfile -t NOTEBOOKS < <(find "$NB_DIR" -type f -name "*.ipynb" | sort)
if [[ ${#NOTEBOOKS[@]} -eq 0 ]]; then
  echo "ERROR: no notebooks found in $NB_DIR"
  exit 1
fi

for nb in "${NOTEBOOKS[@]}"; do
  rel="${nb#"$NB_DIR"/}"
  out="$REPORT_DIR/executed/$rel"
  log="$REPORT_DIR/logs/${rel//\//__}.log"
  mkdir -p "$(dirname "$out")"
  echo -n "Running: $nb"
  if ! jupyter nbconvert --to notebook --execute "$nb" \
        --ExecutePreprocessor.timeout="$TIMEOUT" \
        --output "$out" \
        --log-level WARN >"$log" 2>&1; then
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
  echo
  echo "Execution logs are in: $REPORT_DIR/logs"
  exit 1
fi
