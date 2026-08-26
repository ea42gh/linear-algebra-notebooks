from pathlib import Path
import subprocess
import sys
import time


REQUIREMENTS = Path("/tmp/requirements.txt")


if not REQUIREMENTS.is_file():
    raise FileNotFoundError(
        f"Missing locked Python requirements file: {REQUIREMENTS}. "
        "Copy binder/requirements.txt before running this installer."
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
