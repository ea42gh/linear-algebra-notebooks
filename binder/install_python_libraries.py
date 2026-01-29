import subprocess
import sys

pkgs = [
    # Core numerics / algebra
    "numpy",
    "scipy",
    "pandas",
    "sympy",

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
]

cmd = [
    sys.executable,
    "-m", "pip", "install",
    "--no-cache-dir",
    "--upgrade",
    *pkgs
]

print("Running:", " ".join(cmd))
subprocess.check_call(cmd)
