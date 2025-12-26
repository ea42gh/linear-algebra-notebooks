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

    # Interactive / dashboards
    "panel",
    "panel_mermaid",
    "holoviews[all]",
    "hvplot",
    "k3d",
    "streamz",

    # Jupyter extensions
    "webio_jupyter_extension==0.1.0",

    # Julia bridge (legacy, see note below)
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

