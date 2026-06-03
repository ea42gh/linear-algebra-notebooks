import subprocess
import sys
import time

pkgs = [
    # Core numerics / algebra
    "numpy>=2,<3",
    "scipy",
    "pandas",
    "sympy>=1.12",

    # Graphs / geometry
    "networkx",
    "graphviz",
    "pygraphviz",

    # Imaging / plotting
    "matplotlib",
    "pillow",
    "scikit-image",
    "scikit-learn",
    "xarray",

    # Interactive / dashboards
    "panel",
    "panel_mermaid",
    "holoviews[recommended]",
    "hvplot",
    "k3d",
    "streamz",

    # Jupyter frontend
    "jupyter",
    "jupyterlab",
    "notebook",

    # Jupyter extensions
    "webio_jupyter_extension==0.1.0",

    # Julia bridge (see note below)
    "julia",
    "juliacall",

    # Animation
    "manim",
]

cmd = [
    sys.executable,
    "-m", "pip", "install",
    "--no-cache-dir",
    "--upgrade",
    "--root-user-action=ignore",
    *pkgs
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
