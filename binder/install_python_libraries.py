from pathlib import Path
import subprocess
import sys
import time


REQUIREMENTS_DIR = Path("/tmp/requirements")
PYTHON_VERSION = f"{sys.version_info.major}.{sys.version_info.minor}"
REQUIREMENTS = REQUIREMENTS_DIR / f"requirements-py{PYTHON_VERSION}.txt"


if not REQUIREMENTS.is_file():
    raise FileNotFoundError(
        f"Missing locked Python requirements file for Python {PYTHON_VERSION}: {REQUIREMENTS}. "
        "Copy the matching binder/requirements-py*.txt file before running this installer."
    )

cmd = [
    sys.executable,
    "-m",
    "pip",
    "install",
    "--no-cache-dir",
    "--upgrade",
    "--root-user-action=ignore",
    "-r",
    str(REQUIREMENTS),
]

print("Running:", " ".join(cmd))
for attempt in range(1, 4):
    try:
        subprocess.check_call(cmd)
        break
    except subprocess.CalledProcessError:
        if attempt == 3:
            raise
        wait_seconds = 30
        print(
            f"pip install failed on attempt {attempt}; "
            f"waiting {wait_seconds}s before retrying..."
        )
        time.sleep(wait_seconds)
