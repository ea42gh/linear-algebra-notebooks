#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <notebook_dir_or_file> [timeout_seconds] [report_dir] [startup_timeout] [notebook_only] [resume_from]"
  echo
  echo "Environment:"
  echo "  NOTEBOOK_STARTUP_TIMEOUT  Kernel startup timeout in seconds (default: 180)"
  echo "  NOTEBOOK_ONLY             Run only this notebook path or basename"
  echo "  NOTEBOOK_RESUME_FROM      Skip notebooks until this path or basename"
  exit 1
fi

NB_INPUT="$1"
TIMEOUT="${2:-600}"
REPORT_DIR="${3:-artifacts/notebook-check}"
STARTUP_TIMEOUT="${4:-${NOTEBOOK_STARTUP_TIMEOUT:-180}}"
NOTEBOOK_ONLY="${5:-${NOTEBOOK_ONLY:-}}"
NOTEBOOK_RESUME_FROM="${6:-${NOTEBOOK_RESUME_FROM:-}}"

if ! command -v jupyter >/dev/null 2>&1; then
  echo "ERROR: jupyter not found in PATH"
  exit 1
fi

if [[ -f "$NB_INPUT" ]]; then
  NB_DIR="$(dirname "$NB_INPUT")"
  NOTEBOOKS=("$NB_INPUT")
elif [[ -d "$NB_INPUT" ]]; then
  NB_DIR="$NB_INPUT"
  mapfile -t NOTEBOOKS < <(find "$NB_DIR" -type f -name "*.ipynb" | sort)
else
  echo "ERROR: notebook path not found: $NB_INPUT"
  exit 1
fi

mkdir -p "$REPORT_DIR/executed" "$REPORT_DIR/logs"
FAILED=()

if [[ -n "$NOTEBOOK_ONLY" ]]; then
  FILTERED=()
  for nb in "${NOTEBOOKS[@]}"; do
    rel="${nb#"$NB_DIR"/}"
    if [[ "$nb" == "$NOTEBOOK_ONLY" || "$rel" == "$NOTEBOOK_ONLY" || "$(basename "$nb")" == "$NOTEBOOK_ONLY" ]]; then
      FILTERED+=("$nb")
    fi
  done
  NOTEBOOKS=("${FILTERED[@]}")
fi

if [[ -n "$NOTEBOOK_RESUME_FROM" ]]; then
  FILTERED=()
  found=0
  for nb in "${NOTEBOOKS[@]}"; do
    rel="${nb#"$NB_DIR"/}"
    if [[ $found -eq 0 && ( "$nb" == "$NOTEBOOK_RESUME_FROM" || "$rel" == "$NOTEBOOK_RESUME_FROM" || "$(basename "$nb")" == "$NOTEBOOK_RESUME_FROM" ) ]]; then
      found=1
    fi
    if [[ $found -eq 1 ]]; then
      FILTERED+=("$nb")
    fi
  done
  NOTEBOOKS=("${FILTERED[@]}")
fi

if [[ ${#NOTEBOOKS[@]} -eq 0 ]]; then
  echo "ERROR: no notebooks selected from $NB_INPUT"
  exit 1
fi

for nb in "${NOTEBOOKS[@]}"; do
  rel="${nb#"$NB_DIR"/}"
  out="$REPORT_DIR/executed/$rel"
  log="$REPORT_DIR/logs/${rel//\//__}.log"
  mkdir -p "$(dirname "$out")"
  out_dir="$(dirname "$out")"
  out_name="$(basename "$out")"
  rm -f "$log"
  echo -n "Running: $nb"
  if ! ELA_NOTEBOOK_CHECK=1 jupyter nbconvert --to notebook --execute "$nb" \
        --ExecutePreprocessor.timeout="$TIMEOUT" \
        --ExecutePreprocessor.startup_timeout="$STARTUP_TIMEOUT" \
        --output-dir "$out_dir" \
        --output "$out_name" \
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
